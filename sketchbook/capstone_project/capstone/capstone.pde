// Henry Wrede Black
// CPSC 120 Capstone Project
//    Duck-Hunt Inspired Interactive Animation
//    Clicking the mouse on a bird will cause it to fall, where a dog will catch it
//    Pressing "r" or "R" will release the birds

PVector[] pos, vel;         // boid's position and velocity
float radius, angle;        // boid's neighborhood
float maxforce, maxspeed;   // boid's maximum acceleration and speed

float[] grass_stroke, grass_strokeweight;
float[] grassX1, grassX2, grassY2;

boolean[] hit; // boolean array that says if a bird has been hit or not
PVector shot;  // stored (x,y) position of where the mouse clicked, used to see if shot hit or not in boid behaviours

float[] dogX, dogY; // animation array variables for the dog's position on the screen
float[] up;         // values for speeds at which the dogs moves up or down
float t; // time variable for noise function in dog's side-to-side movement
float t2; // time variable for constrained parametric movement

void setup() {
  size(1500, 800);

  // -- BIRD/BOID Definitions and initializations
  // boids (ducks) start with random position above the grass and random velocity
  pos = new PVector[5];
  vel = new PVector[5];
  hit = new boolean[5];
  for (int i = 0; i < pos.length; i++) {
    pos[i] = new PVector(random(0, width), random(height*0.11, height*0.54)); // birds start with random positions
    vel[i] = new PVector(random(-1, 1), random(-1, 1));                       // and velocities

    hit[i] = false; // no birds are hit when sketch starts
  }
  // other boid parameters
  radius = 60;
  angle = radians(135);
  maxforce = .6;
  maxspeed = 10;

  // -- Dog properties
  dogX = new float[5];
  dogY = new float[5];
  up = new float[5];
  for (int i = 0; i < dogY.length; i++) {
    dogY[i] = height; // all dogs start at a y value equal to the window height
    up[i] = -10;      // downward speed of the dogs starts as -10
  }

  // -- Grass array value initialization
  grass_stroke = new float[1000];
  grass_strokeweight = new float[1000];
  grassX1 = new float[1000];
  grassX2 = new float[1000];
  grassY2 = new float[1000];
  for (int i = 0; i < grass_stroke.length; i++) {
    grass_stroke[i] = random(150, 225);       // color of grass varies
    grass_strokeweight[i] = random(5, 15);    // thickness of grass varies
    grassX1[i] = i*1.5;                       // blade of grass every 1.5 pixels
    grassX2[i] = random(-10, 10);             // random x value for endpoint
    grassY2[i] = height*0.9-random(150, 200); // random y value for endpoint
  }

  t = 0;  // first time variable, used for perlin noise equation
  t2 = 0; // second time variable, used for the parametric motion equation

  // Initial value for shot coords
  shot = new PVector(0, 0); // "hit" location is set to a place where the boids won't be near
}

void draw() {
  randomSeed(0);
  background(100, 150, 200);

  // -- BACKGROUND ELEMENTS
  drawSky(); // background blue gradient
  { // constrained motion using parametric equation
    float x = width*0.5 + 1000*cos(t2+PI);
    float y = height/2 + 150*sin(t2+PI);
    float a = map(x, 0, width*0.75, 0, 100);
    drawMoon(x, y, a);
  }
  drawTerrain(0, height*0.3, width, height*0.3, 175, 50, 50, 50); // background mountain

  // -- BOIDS PATTERN
  for (int i = 0; i < pos.length; i++) {
    // 1 - draw scene
    drawBoid(pos[i], vel[i]);
  }
  for (int i = 0; i < pos.length; i++) {
    // 2 - compute net steering force
    PVector random_point_within_bounds = new PVector(random(width*0.15, width*0.85), random(height*0.15, height*0.5)); // stores a random coordinate within bounds for the boid to arrive at
    //  a - compute steering force for each behavior
    PVector separation = computeSeparation(pos[i], vel[i], radius, angle, pos, vel);
    PVector wander = computeWander (pos[i], vel[i], maxspeed );
    PVector arrive_random = computeArrive (pos[i], vel[i], maxspeed, random_point_within_bounds, 100); // behaviour to return bird within bounds
    PVector seek_down = computeArrive(pos[i], vel[i], maxspeed, new PVector(pos[i].x, height), 5);     // behaviour to make the bird go down to the x pos where it was hit
    //  b - combine forces (one behavior)
    PVector steer = new PVector(0, 0);
    separation.setMag(5);

    // if the bird is hit, it will seek directly down...
    // or if the bird is out of bounds, it will seek a random point within bounds...
    // otherwise if bird is within bounds and not hit it will maintain regular behaviour (seperation/wander)...
    if (dist(shot.x, shot.y, pos[i].x, pos[i].y) < 25 || hit[i]) { // if bird is within 25 pixels of stored (shot) value or already marked as "hit" - when hit is true, bird will then only seek down
      hit[i] = true; // set hit to true for the birds position in the array
      steer.add(seek_down);
    } else if (!hit[i] && (pos[i].y < height*0.1 || pos[i].y > height*0.55) || (pos[i].x < width*0.1 || pos[i].x > width*0.9)) { // if bird hasn't been "hit" and leaves set bounds of sketch, arrive to a random point within the bounds
      steer.add(arrive_random);
    } else if (!hit[i]) { // if bird hasn't been "hit" then continue regular behaviours
      steer.add(separation);
      steer.add(wander);
    }

    //  c - limit the size of the force that can be applied
    steer.limit(maxforce);
    // 3 - update boid's velocity
    //  a - add net steering force
    vel[i].add(steer);
    //  b - limit boid's max speed
    vel[i].limit(maxspeed);

    // 4 - update boid's position
    //  a - update position by adding velocity
    pos[i].add(vel[i]);
  }

  // Code for dog that pops up when bird goes below grass
  {
    // draw dog
    for (int i = 0; i < dogX.length; i++) {
      dogX[i] = pos[i].x; // dog's x position is the same as the corresponding bird in the array
      dog(dogX[i]+map(noise(t), 0, 1, -20, 20), dogY[i]);
    }
    // update dog
    for (int i = 0; i < dogX.length; i++) {
      if (pos[i].y > height*0.9 && hit[i]) {
        dogY[i] += up[i];
        up[i] = min(0, up[i] + 0.18);
      } else {
        dogY[i] += 10;
        dogY[i] = min(height, dogY[i]);
      }
    }
  }

  t += 0.01; // update time variable
  t2 += 0.02;

  // elements in the foreground of the sketch
  foreground_elements();
  crosshair();
}
// -- DRAWING FUNCTIONS
// drawing function for crosshair that follows the mouse
void crosshair() {
  strokeWeight(4);
  stroke(255, 0, 0);
  fill(255, 0, 0);
  ellipse(mouseX, mouseY, 5, 5);
  line(mouseX, mouseY-10, mouseX, mouseY-25);
  line(mouseX, mouseY+10, mouseX, mouseY+25);
  line(mouseX-10, mouseY, mouseX-25, mouseY);
  line(mouseX+10, mouseY, mouseX+25, mouseY);
}
// drawing function for the sky in the background, set position
void drawSky() {
  rectMode(CORNER);
  for (int y = 0, b = 255, g = 215; y <= height*0.5; y += 5, b += -1, g += -2) {
    for (int x = 0; x <= width; x+=5) {
      noStroke();
      fill(0, g, b);
      rect(x, y, 5, 5);
    }
  }
}
void drawMoon(float x, float y, float a) {
  ellipseMode(CENTER);
  noStroke();
  fill(100, a);
  ellipse(x, y, 300, 300);
  fill(150, a);
  ellipse(x, y, 290, 290);
  fill(175, a);
  ellipse(x+75, y-80, 75, 75);
  ellipse(x-45, y+75, 80, 80);
  ellipse(x-80, y-75, 50, 50);
  ellipse(x+50, y+25, 60, 60);
  ellipse(x-30, y+30, 50, 50);
}

// drawing function for terrain elements using fractals
//  (x1, y1), (x2, y2) specify the endpoints for the midpoint displacement math
//  (maxd) is the maximum displacement, which controls the "jaggedness" of the terrain
//  (r), (g), and (b) control the color of the resulting terrain
void drawTerrain(float x1, float y1, float x2, float y2, float maxd, int r, int g, int b) {
  if (dist(x1, y1, x2, y2) < 25) {
    stroke(r, g, b);
    fill(r, g, b);
    quad(x1, y1, x2, y2, x2, height, x1, height);
  } else {
    {
      float d = random(-maxd, maxd);
      drawTerrain(x1, y1, (x1+x2)/2, (y1+y2)/2+d, maxd/2, r, g, b);
      drawTerrain((x1+x2)/2, (y1+y2)/2+d, x2, y2, maxd/2, r, g, b);
    }
  }
}
// drawing function for the grass, set position
void front_grass() {
  for (int i = 0; i < grass_stroke.length; i++) {
    stroke(0, grass_stroke[i], 50);
    strokeWeight(grass_strokeweight[i]);
    line(grassX1[i], height*0.9, grassX1[i]+grassX2[i], grassY2[i]);
  }
}
// drawing function for all foreground elements, set position
void foreground_elements() {
  drawTree(250, height*0.8);
  front_grass(); // draws grass
  drawTerrain(0, height*0.85, width, height*0.85, 20, 150, 100, 15); //draws dirt in front of grass
  for (int count = 0; count <= 25; count++) { // draws rocks on dirt
    float x = random(0, width);
    float y = random(height*0.9, height);
    noStroke();
    fill(150);
    quad(x, y, x, y-15, x-13, y-16, x-27, y-5);
  }
}
// drawing function for tree
//   position determined by (x, y)
void drawTree(float x, float y) {
  rectMode(CENTER);
  ellipseMode(CENTER);
  noStroke();
  // tree trunk
  fill(193, 94, 0);
  rect(x, y-150, 50, 300);
  //branches
  stroke(193, 94, 0);
  strokeWeight(10);
  line(x, y-175, x-100, y-225);
  line(x, y-200, x+100, y-275);
  line(x, y-100, x+50, y-200);
  strokeWeight(8);
  line(x-50, y-200, x-35, y-250);
  // leaves
  noStroke();
  fill(0, 203, 0);
  ellipse(x-10, y-375, 200, 200); // big main green
  ellipse(x+75, y-400, 100, 100);
  ellipse(x-80, y-425, 150, 150);
  ellipse(x+50, y-325, 125, 125);
  ellipse(x-100, y-225, 50, 50); // green on left branch
  fill(0, 175, 0); // darker green for green overlays
  ellipse(x-10, y-375, 185, 185);
  ellipse(x+75, y-400, 85, 85);
  ellipse(x-80, y-425, 135, 135);
  ellipse(x+50, y-325, 110, 110);
  ellipse(x-100, y-225, 40, 40);
}
// drawing function for the dogs that pop up where a bird drops
//   position determined by parameters (x, y)
void dog(float x, float y) {
  // ears
  pushMatrix();
  translate(x, y);
  ellipseMode(CORNER);
  fill(0);
  rotate(radians(-35));
  ellipse(115, -135, 50, 100);  // right ear
  rotate(radians(70));
  ellipse(-165, -135, 50, 100); // left ear
  popMatrix();
  // duck on point at end of arm
  drawDuck(x+140, y-120); // draws the duck on the dog's right arm
  // arms
  noFill();
  ellipseMode(CORNER);
  stroke(200, 85, 0);
  strokeWeight(20);
  line(x+50, y-45, x+125, y-125);                       // right arm
  arc(x-95, y-40, 75, 250, PI+radians(20), PI+HALF_PI); // left arm
  // body
  ellipseMode(CENTER);
  noStroke();
  fill(200, 90, 0);
  ellipse(x, y, 125, 350);     // bottom layer of body
  fill(229, 115, 0);
  ellipse(x, y+5, 115, 345);   // top layer of body
  // head
  ellipse(x, y-100, 115, 75);  // bottom head section
  ellipse(x, y-145, 100, 115); // top head section
  fill(50);
  arc(x, y-115, 85, 50, 0-QUARTER_PI/2, PI+QUARTER_PI/2); // mouth
  fill(229, 84, 0);
  ellipse(x, y-100, 50, 15);
  // eyes
  fill(255);
  stroke(0);
  strokeWeight(2);
  arc(x-10, y-155, 50, 65, HALF_PI, PI+HALF_PI);        // left white
  arc(x+10, y-155, 50, 65, PI+HALF_PI, TWO_PI+HALF_PI); // right white
  fill(0);
  arc(x-10, y-155, 20, 35, HALF_PI, PI+HALF_PI);        // left pupil
  arc(x+10, y-155, 20, 35, PI+HALF_PI, TWO_PI+HALF_PI); // right pupil
  // nose
  noStroke();
  fill(25);
  ellipse(x, y-120, 35, 25);   // big part of nose
  fill(200);
  ellipse(x+3, y-120, 15, 10); // shiny bit of nose
}

// drawing function for the duck held by dog when it pops up
//   position determined by parameters (x,y)
void drawDuck( float x, float y) {
  ellipseMode(CENTER);
  pushMatrix();
  translate(x, y);
  noStroke();
  // back wing
  fill(0);
  triangle(-20, 0, -30, 55, 0, 15);
  // body 1
  fill(175);
  ellipse(0, 0, 40, 60);
  // right wing
  fill(100);
  triangle(-20, 0, -20, 65, 0, 15);
  // body 2
  fill(200);
  ellipse(-5, 0, 30, 50);
  // bill
  fill(255, 200, 0);
  quad(-23, -45, -15, -65, -10, -65, -11, -45);
  // head
  fill(0, 190, 0);
  ellipse(-18, -30, 30, 40);
  // eyes
  fill(255);
  ellipse(-20, -40, 15, 10); // white part
  fill(0);
  ellipse(-20, -41, 7, 3); // pupil
  popMatrix();
}

// -- INTERACTION ELEMENTS
// actions to take when mouse is pressed
void mousePressed() {
  if (mousePressed) {
    shot = new PVector(mouseX, mouseY); // store location where mouse was pressed, used to decide if bird was hit or not
  } else {
    shot = new PVector(0, 0);           // otherwise, "hit" location is in a spot where birds can't reach
  }
}
// actions to take when a key is pressed
void keyPressed() {
  // releases all captured birds
  if (key == 'r' || key == 'R') {
    for (int i = 0; i < hit.length; i++) {
      hit[i] = false; // sets boolean array values to false
      up[i] = -10;    // resets up speed of dogs
    }
  }
}
