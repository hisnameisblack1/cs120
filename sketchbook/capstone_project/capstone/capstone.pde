// Henry Wrede Black
// CPSC 120 Capstone Project
//    Duck-Hunt Inspired Interactive Animation

PVector[] pos, vel;         // boid's position and velocity
float radius, angle;        // boid's neighborhood
float maxforce, maxspeed;   // boid's maximum acceleration and speed

float[] grass_stroke, grass_strokeweight;
float[] grassX2, grassY2;

void setup() {
  size(1500, 800);

  // boids (ducks) start with random position above the grass and random velocity
  pos = new PVector[5];
  vel = new PVector[5];
  for (int i = 0; i < pos.length; i++) {
    pos[i] = new PVector(random(0, width), random(0, height*0.5));
    vel[i] = new PVector(random(-1, 1), random(-1, 1));
  }
  // boolean array... hit/not hit

  // grass array
  grass_stroke = new float[3000];
  grass_strokeweight = new float[3000];
  grassX2 = new float[3000];
  grassY2 = new float[3000];
  for (int i = 0; i < grass_stroke.length; i++) {
    grass_stroke[i] = random(150, 225);
    grass_strokeweight[i] = random(1, 5);
    grassX2[i] = grassX1[i]+random(-10, 10);
    grassY2[i] = height*0.9-random(100, 200);
  }

  // other boid parameters
  radius = 60;
  angle = radians(135);
  maxforce = .2;
  maxspeed = 3;
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
    //  a - compute steering force for each behavior
    PVector separation = computeSeparation(pos[i], vel[i], radius, angle, pos, vel);
    PVector wander = computeWander (pos[i], vel[i], maxspeed );
    PVector arrive = computeArrive (pos[i], vel[i], maxspeed, new PVector(random(0, width), random(0, height*0.4)), 100);
    //  b - combine forces (one behavior)
    PVector steer = new PVector(0, 0);
    separation.setMag(5);

    // if hit, then boolean array true, and different set of behaviours
    if (pos[i].y > random(height*0.25, height*0.55)) {
      steer.add(arrive);
    } else {
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
    //  b - wrap at edges of window
    if ( pos[i].x > width ) {
      pos[i].x = 0;
    } else if ( pos[i].x < 0 ) {
      pos[i].x = width;
    }
  }

  // elements in the foreground of the sketch
  front_grass();
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
  for (float x = 0; x <= width; x+= 0.5) {
    stroke(0, grass_stroke[i], 50);
    strokeWeight(grass_strokeweight[i]);
    line(x, height*0.9, grassX2[i], grassY2[i]);
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

/*
 NEED TO ADD
 - clouds
 - rain
 - lightning
 - tree
 - could be fractal tree or composite shape
 - bush/rock
 - rock could be interesting if I use fractals to get some cool surface detail
 - variety in front terrain, rocks and small shrubs
 - shooting mechanic
 - crosshair linked to mouse position
 - "bullet"
 - boid ducks
 - draw out (or use png image???)
 - behaviour first
 - implement shoot-down mechanic later, (particle system spatter effect or is that too much?)
 - dog
 - draw out
 - pop-up mechanic
 */
