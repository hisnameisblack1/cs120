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
PVector shot;

void setup() {
  size(1500, 800);

  // -- BIRD/BOID Definitions and initializations
  // boids (ducks) start with random position above the grass and random velocity
  pos = new PVector[5];
  vel = new PVector[5];
  hit = new boolean[5];
  for (int i = 0; i < pos.length; i++) {
    pos[i] = new PVector(random(0, width), random(height*0.11, height*0.54)); // birds start with random positions and velocities
    vel[i] = new PVector(random(-1, 1), random(-1, 1));
    
    hit[i] = false; // no birds are hit when sketch starts
  }

  // boolean array... hit/not hit
  // other boid parameters
  radius = 60;
  angle = radians(135);
  maxforce = .2;
  maxspeed = 3;

  // -- Grass array value initialization
  grass_stroke = new float[3000];
  grass_strokeweight = new float[3000];
  grassX1 = new float[3000];
  grassX2 = new float[3000];
  grassY2 = new float[3000];
  for (int i = 0; i < grass_stroke.length; i++) {
    grass_stroke[i] = random(150, 225);
    grass_strokeweight[i] = random(1, 5);
    grassX1[i] = i*0.5;
    grassX2[i] = random(-10, 10);
    grassY2[i] = height*0.9-random(100, 200);
  }

  // Initial value for shot coords
  shot = new PVector(-10, -10);
}

void draw() {
  randomSeed(0);
  background(100, 150, 200);

  // background elements
  drawTerrain(0, height*0.3, width, height*0.3, 175, 50, 50, 50);

  //   Boids Pattern
  for (int i = 0; i < pos.length; i++) {
    // 1 - draw scene
    drawBoid(pos[i], vel[i], 255, 0, 0);
  }
  for (int i = 0; i < pos.length; i++) {
    // 2 - compute net steering force
    PVector random_point_within_bounds = new PVector(random(0, width), random(height*0.25, height*0.4)); // stores a random coordinate for the boid to arrive at
    //  a - compute steering force for each behavior
    PVector separation = computeSeparation(pos[i], vel[i], radius, angle, pos, vel);
    PVector wander = computeWander (pos[i], vel[i], maxspeed );
    PVector arrive_random = computeArrive (pos[i], vel[i], maxspeed, random_point_within_bounds, 100); // behaviour to return bird within bounds
    PVector seek_down = computeSeek(pos[i], vel[i], maxspeed, new PVector(pos[i].x, height)); // behaviour to make the bird go down where it was hit
    //  b - combine forces (one behavior)
    PVector steer = new PVector(0, 0);
    separation.setMag(5);

    // if hit, then boolean array true, and different set of behaviours
    if (dist(shot.x, shot.y, pos[i].x, pos[i].y) < 25) {
      hit[i] = true; // bird is now hit, will only follow the seek down behaviour
      steer.add(seek_down);
    } else if (!hit[i] && (pos[i].y < height*0.1 || pos[i].y > height*0.55) || (pos[i].x < 0 || pos[i].x > width)) { // if bird leaves set bounds of sketch, arrive to a random point within the bounds
      steer.add(arrive_random);
    } else if (!hit[i] && pos[i] == random_point_within_bounds) { // if the bird arrives at the random point, then return to regular behaviours
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

  // elements in the foreground of the sketch
  //  front_grass();
  drawTerrain(0, height*0.85, width, height*0.85, 20, 150, 100, 15);
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
void front_grass() { // arrayify
  for (int i = 0; i < grass_stroke.length; i++) {
    for (float x = 0; x <= width; x += 0.5) {
      stroke(0, grass_stroke[i], 50);
      strokeWeight(grass_strokeweight[i]);
      line(grassX1[i], height*0.9, grassX1[i]+grassX2[i], grassY2[i]);
    }
  }
}
// drawing function for terrain elements using fractals
//  (x1, y1), (x2, y2) specify the endpoints for the midpoint displacement algorithm
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
// drawing function for the tree
void tree() {
  // tree for the background, either an L-system (complicated), or a composite shape using fat lines for wood parts and whatever looks good for leafy bits
}

// -- INTERACTION ELEMENTS
void mousePressed() {
  if (mousePressed) {
    shot = new PVector(mouseX, mouseY);
    println(shot);
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
 
 - variety in front terrain, rocks and small shrubs
 
 -- shooting mechanic
 DONE - crosshair linked to mouse position
 - "bullet"
 
 -- boid ducks
 - draw out (or use png image???)
 - behaviour first
 - implement shoot-down mechanic later, (particle system spatter effect or is that too much?)
 
 -- dog
 - draw out
 - pop-up mechanic
 */
