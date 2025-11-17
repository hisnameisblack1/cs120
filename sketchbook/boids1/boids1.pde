// Henry Wrede Black

// single boid arrives at the mouse position

PVector pos, vel;           // boid's position and velocity
float radius, angle;        // boid's neighborhood
float maxforce, maxspeed;   // boid's maximum acceleration and speed

void setup () {
  size(600, 600);

  // start with random position and velocity
  pos = new PVector(random(0, width), random(0, height));
  vel = new PVector(random(-1, 1), random(-1, 1));

  // other boid parameters
  radius = 60;
  angle = radians(135);
  maxforce = .2;
  maxspeed = 3;
}

void draw () {

  // 1 - draw scene
  background(255);
  drawBoid(pos, vel, 255, 0, 0);

  // 2 - compute net steering force
  //  a - compute steering force for each behavior
  PVector arrive = computeArrive(pos, vel, maxspeed, new PVector(mouseX, mouseY), 100);
  //  b - combine forces (one behavior)
  PVector steer = new PVector(0, 0);
  steer.add(arrive);

  //  c - limit the size of the force that can be applied
  steer.limit(maxforce);

  // 3 - update boid's velocity
  //  a - add net steering force
  vel.add(steer);
  //  b - limit boid's max speed
  vel.limit(maxspeed);

  // 4 - update boid's position
  //  a - update position by adding velocity
  pos.add(vel);
  //  b - wrap at edges of window
  if ( pos.x > width ) {
    pos.x = 0;
  } else if ( pos.x < 0 ) {
    pos.x = width;
  }
  if ( pos.y > height ) {
    pos.y = 0;
  } else if ( pos.y < 0 ) {
    pos.y = height;
  }
}
