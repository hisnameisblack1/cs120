// Henry Wrede Black
// flock of 100 boids moving around the drawing window

PVector[] pos, vel;           // boid's position and velocity
float radius, angle;        // boid's neighborhood
float maxforce, maxspeed;   // boid's maximum acceleration and speed

void setup () {
  size(600, 600);

  // start with random position and velocity
  pos = new PVector[100];
  vel = new PVector[100];
  for (int i = 0; i < pos.length; i++) {
    pos[i] = new PVector(random(0, width), random(0, height));
    vel[i] = new PVector(random(-1, 1), random(-1, 1));
  }
  // other boid parameters
  radius = 60;
  angle = radians(135);
  maxforce = .2;
  maxspeed = 3;
}

void draw () {
  background(255);
  for (int i = 0; i < pos.length; i++) {
    // 1 - draw scene
    drawBoid(pos[i], vel[i], 255, 0, 0);
  }
  for (int i = 0; i < pos.length; i++) {
    // 2 - compute net steering force
    //  a - compute steering force for each behavior
    PVector separation = computeSeparation(pos[i], vel[i], radius, angle, pos, vel);
    PVector alignment = computeAlignment(pos[i], vel[i], radius, angle, pos, vel);
    PVector cohesion = computeCohesion(pos[i], vel[i], radius, angle, pos, vel);
    PVector forward = computeForward(pos[i], vel[i], maxspeed);
    //  b - combine forces (one behavior)
    PVector steer = new PVector(0, 0);
    separation.setMag(3);
    alignment.setMag(3);
    cohesion.setMag(2);

    steer.add(separation);
    steer.add(alignment);
    steer.add(cohesion);
    steer.add(forward);
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
    if ( pos[i].y > height ) {
      pos[i].y = 0;
    } else if ( pos[i].y < 0 ) {
      pos[i].y = height;
    }
  }
}
