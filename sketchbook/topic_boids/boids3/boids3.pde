// Henry Wrede Black
// flock of 100 boids moving around the drawing window

PVector[] pos, vel;           // boid's position and velocity
float radius, angle;        // boid's neighborhood
float maxforce, maxspeed;   // boid's maximum acceleration and speed

PVector obstaclePos;

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

  obstaclePos = new PVector(random(50, width-50), random(50, height-50));
}

void draw () {
  background(255);
  for (int i = 0; i < pos.length; i++) {
    // 1 - draw scene
    //  a - draw obstacle
    ellipseMode(CENTER);
    fill(100);
    ellipse(obstaclePos.x, obstaclePos.y, 100, 100);

    //  b - draw boid
    drawBoid(pos[i], vel[i], 255, 0, 0);
  }
  for (int i = 0; i < pos.length; i++) {
    // 2 - compute net steering force
    //  a - compute steering force for each behavior
    PVector obsavoid = computeObsAvoidance(pos[i], vel[i], maxforce, obstaclePos, 50, 10);
    PVector collisionavoid = computeCollisionAvoidance(pos[i], vel[i], maxforce, pos, vel, 10);
    PVector seek = computeSeek(pos[i], vel[i], maxspeed, new PVector(mouseX, mouseY));
    PVector wander = computeWander(pos[i], vel[i], maxspeed);
    //  b - combine forces (one behavior)
    PVector steer = new PVector(0, 0);
    obsavoid.setMag(100);
    collisionavoid.setMag(100);
    seek.setMag(2);
    wander.setMag(1);
  /*
  STUCK - 
  implementation of conditional pattern... how to calc potential collision
  magnitude for avoidance?? v.mag()
  */
    float obsDistance = dist(pos[i].x, pos[i].y, obstaclePos.x, obstaclePos.y); // distance between individual boid and obstacle
    float mouseDistance = dist(mouseX, mouseY, pos[i].x, pos[i].y); // distance between individal boid and mouse position
    if (obsDistance <= 50) {
     steer.add(obsavoid);
    } else if (mouseDistance <= 200) {
      steer.add(seek);
    } else {
      steer.add(wander);
    }
    steer.add(collisionavoid);
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
