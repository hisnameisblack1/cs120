// Henry Wrede Black
// CPSC 120 Capstone Project
//    Duck-Hunt Inspired Interactive Animation

PVector[] pos, vel;         // boid's position and velocity
PVector[] hitpos, hitvel;
float radius, angle;        // boid's neighborhood
float maxforce, maxspeed;   // boid's maximum acceleration and speed

float[] grass_stroke, grass_strokeweight;
float[] grassX1, grassX2, grassY2;

boolean[] hit; // boolean array that says if a bird has been hit or not
PVector shot; // stored (x,y) position of where the mouse clicked, used to see if shot hit or not in boid behaviours

float[] dogX, dogY; // animation array variables for the dog's position on the screen
float up, down; // values for speeds at which the dog moves up or down

void setup() {
  size(1500, 800);

  // -- BIRD/BOID Definitions and initializations
  // boids (ducks) start with random position above the grass and random velocity
  pos = new PVector[5];
  vel = new PVector[5];
  hit = new boolean[5];
  dogX = new float[5];
  dogY = new float[5];
  for (int i = 0; i < pos.length; i++) {
    pos[i] = new PVector(random(0, width), random(height*0.11, height*0.54)); // birds start with random positions and velocities
    vel[i] = new PVector(random(-1, 1), random(-1, 1));

    hit[i] = false; // no birds are hit when sketch starts
  }
  // other boid parameters
  radius = 60;
  angle = radians(135);
  maxforce = .6;
  maxspeed = 10;

  // Dog properties
  for (int i = 0; i < dogY.length; i++) {
    dogY[i] = height;
  }
  up = -1;
  down = 1;

  // -- Grass array value initialization
  grass_stroke = new float[1000];
  grass_strokeweight = new float[1000];
  grassX1 = new float[1000];
  grassX2 = new float[1000];
  grassY2 = new float[1000];
  for (int i = 0; i < grass_stroke.length; i++) {
    grass_stroke[i] = random(150, 225);
    grass_strokeweight[i] = random(5, 15);
    grassX1[i] = i*1.5;
    grassX2[i] = random(-10, 10);
    grassY2[i] = height*0.9-random(150, 200);
  }

  // Initial value for shot coords
  shot = new PVector(-10, -10);
}

void draw() {
  randomSeed(0);
  background(100, 150, 200);

  // background elements
  drawTerrain(0, height*0.3, width, height*0.3, 175, 50, 50, 50); // background mountain

  //   Boids Pattern
  for (int i = 0; i < pos.length; i++) {
    // 1 - draw scene
    drawBoid(pos[i], vel[i]);
  }
  for (int i = 0; i < pos.length; i++) {
    // 2 - compute net steering force
    PVector random_point_within_bounds = new PVector(random(0, width), random(height*0.25, height*0.4)); // stores a random coordinate for the boid to arrive at
    PVector down_point = new PVector(pos[i].x, height);
    //  a - compute steering force for each behavior
    PVector separation = computeSeparation(pos[i], vel[i], radius, angle, pos, vel);
    PVector wander = computeWander (pos[i], vel[i], maxspeed );
    PVector arrive_random = computeArrive (pos[i], vel[i], maxspeed, random_point_within_bounds, 100); // behaviour to return bird within bounds
    PVector seek_down = computeArrive(pos[i], vel[i], maxspeed, new PVector(pos[i].x, height), 5); // behaviour to make the bird go down where it was hit
    //  b - combine forces (one behavior)
    PVector steer = new PVector(0, 0);
    separation.setMag(5);

    // if hit, then boolean array true, and different set of behaviours
    if (dist(shot.x, shot.y, pos[i].x, pos[i].y) < 25 || hit[i]) { // if bird is within 25 pixels of stored (shot) value
      hit[i] = true; // set hit to true for the birds position in the array
      steer.add(seek_down);
      //steer.add(down_point);
      // bird will only seek down
    } else if (!hit[i] && (pos[i].y < height*0.1 || pos[i].y > height*0.55) || (pos[i].x < 0 || pos[i].x > width)) { // if bird leaves set bounds of sketch, arrive to a random point within the bounds
      steer.add(arrive_random);
    } else if (!hit[i]) { // if the bird arrives at the random point, then return to regular behaviours
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
      dog(dogX[i], dogY[i]);
    }
    // update dog
    for (int i = 0; i < dogX.length; i++) {
      if (pos[i].y > height*0.9) {
        dogY[i] = max(dogY[i], height*0.65);
        dogY[i] += up;
        up += -0.1;
        up = max(-5, up);
      } else {
        dogY[i] += down;
        dogY[i] = min(height, dogY[i]);
      }
    }
  }
  // elements in the foreground of the sketch
  foreground_elements();
  crosshair();
}
// -- DRAWING FUNCTIONS
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

// drawing function for the grass
void front_grass() {
  for (int i = 0; i < grass_stroke.length; i++) {
    stroke(0, grass_stroke[i], 50);
    strokeWeight(grass_strokeweight[i]);
    line(grassX1[i], height*0.9, grassX1[i]+grassX2[i], grassY2[i]);
  }
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
// drawing function for rocks around foreground, set posiion
void foreground_elements() {
  front_grass();
  drawTerrain(0, height*0.85, width, height*0.85, 20, 150, 100, 15);
  for (float count = 0; count <= 25; count++) {
    float x = random(0, width);
    float y = random(height*0.9, height);
    noStroke();
    fill(150);
    quad(x, y, x, y-15, x-13, y-16, x-27, y-5);
  }
}
// drawing function for dog that pops up where a bird drops
// position determined by parameters (x, y)
void dog(float x, float y) {
  // ears
  pushMatrix();
  translate(x, y);
  ellipseMode(CORNER);
  fill(0);
  rotate(radians(-35));
  ellipse(115, -135, 50, 100);
  rotate(radians(70));
  ellipse(-165, -135, 50, 100);
  popMatrix();
  // duck on point at end of arm
  drawDuck(x+140, y-120); // draws the duck on the dog's right arm
  // arms
  noFill();
  ellipseMode(CORNER);
  stroke(200, 85, 0);
  strokeWeight(20);
  line(x+50, y-45, x+125, y-125); // right arm
  arc(x-95, y-40, 75, 250, PI+radians(20), PI+HALF_PI); // left arm
  // body
  ellipseMode(CENTER);
  noStroke();
  fill(200, 90, 0);
  ellipse(x, y, 125, 350); // bottom layer of body
  fill(229, 115, 0);
  ellipse(x, y+5, 115, 345); // top layer of body
  // head
  ellipse(x, y-100, 115, 75); // bottom head section
  ellipse(x, y-145, 100, 115); // top head section
  fill(50);
  arc(x, y-115, 85, 50, 0-QUARTER_PI/2, PI+QUARTER_PI/2); // mouth
  fill(229, 84, 0);
  ellipse(x, y-100, 50, 15);
  // eyes
  fill(255);
  arc(x-10, y-155, 50, 65, HALF_PI, PI+HALF_PI); // left white
  arc(x+10, y-155, 50, 65, PI+HALF_PI, TWO_PI+HALF_PI); // right white
  fill(0);
  arc(x-10, y-155, 20, 35, HALF_PI, PI+HALF_PI); // left pupil
  arc(x+10, y-155, 20, 35, PI+HALF_PI, TWO_PI+HALF_PI); // right pupil
  // nose
  fill(25);
  ellipse(x, y-120, 35, 25); // big part of nose
  fill(200);
  ellipse(x+3, y-120, 15, 10); // shiny bit of nose
}

// drawing function for the the duck, used to draw the dog that pops up
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

// drawing function for the tree
void tree() {
  // tree for the background, either an L-system (complicated), or a composite shape using fat lines for wood parts and whatever looks good for leafy bits
}

// -- INTERACTION ELEMENTS
void mousePressed() {
  if (mousePressed) {
    shot = new PVector(mouseX, mouseY);
  } else {
    shot = new PVector(0, 0);
  }
}
/*
 NEED TO ADD
 - clouds
 
 - rain
 
 - lightning
 
 -- tree
 - could be fractal tree or composite shape
 
 -- bush/rock
 - rock could be interesting if I use fractals to get some cool surface detail
 
 DONE - variety in front terrain, rocks and small shrubs
 
 -- shooting mechanic
 DONE - crosshair linked to mouse position
 - "bullet" (don't really need), look at adding if nothing else is needed
 
 DONE -- boid ducks
 - draw out (or use png image???)
 DONE - behaviour first
 DONE  - implement shoot-down mechanic later, (particle system spatter effect or is that too much?)
 
 -- dog
 DONE - draw out
 SORT OF DONE - pop-up mechanic
 */
