// Henry Wrede Black
// group of boids following leader, leader is tracking an invisible point moving around window

// followers
PVector[] follpos, follvel;  // position and velocity

// leader
PVector leadpos, leadvel;    // position and velocity

// gen pararamters
float radius, angle;         // defines what the follower can see
float maxforce, maxspeed;    // other follower parameters
float leadmaxforce, leadmaxspeed;

// variables for parametric equation
float t;                     // time variable
float R, r, a;               // variables for hypoconchroidal motion
float cx, cy;                // centerpoint of hypoconchroid

void setup () {
  size(1000, 800);

  // start with random positions and velocities
  //  followers
  follpos = new PVector[200];
  follvel = new PVector[200];
  for (int i = 0; i < follpos.length; i++) {
    follpos[i] = new PVector(random(0, width), random(0, height));
    follvel[i] = new PVector(random(-1, 1), random(-1, 1));
  }
  //  leader
  leadpos = new PVector(random(0, width), random(0, height));
  leadvel =  new PVector(random(-1, 1), random(-1, 1));


  //  other boid properties
  radius = 60;
  angle = radians(135);
  maxforce = .3;
  maxspeed = 4;
  leadmaxforce = .4;
  leadmaxspeed = 4;

  //  hypoconchroid properties for point pathing
  t = 1;
  cx = width/2;
  cy = height/2;
  R = 300;
  r = 100;
  a = 0.9;
}

void draw () {
  // 1 - draw scene
  background(255);

  // invisible point moving in hypoconchroidal pattern for leader pathfinding
  PVector point = new PVector((R-r)*cos(t) + a*r*cos(t*(R-r)/r) + cx, (R-r)*sin(t) + a*r*sin(t*(R-r)/r) + cy); // parametric equation
  noStroke();
  point(point.x, point.y);

  // follower boid
  for (int i = 0; i < follpos.length; i++) {
    drawBoid(follpos[i], follvel[i], 0, 150, 0);
  }
  // leader boid
  drawBoid(leadpos, leadvel, 255, 255, 255);

  // -- update followers ---------------------------------------------------------
  // update follower's position and velocity
  {
    for (int i = 0; i < follpos.length; i++) {
      // 2 - compute net steering force
      //  a - compute steering force for each behavior
      PVector wander = computeWander(follpos[i], follvel[i], maxspeed);
      PVector offset_pursuit = computeOffsetPursuit ( follpos[i], follvel[i], maxspeed, leadpos, leadvel, new PVector(-20, 0));
      PVector avoid = computeCollisionAvoidance(follpos[i], follvel[i], maxforce, leadpos, leadvel, 600);
      PVector separation = computeSeparation(follpos[i], follvel[i], radius, angle, follpos, follvel);
      PVector alignment = computeAlignment(follpos[i], follvel[i], radius, angle, follpos, follvel);
      PVector cohesion = computeCohesion(follpos[i], follvel[i], radius, angle, follpos, follvel);
      //  b - combine forces (one behavior)
      PVector steer = new PVector(0, 0);
      separation.setMag(3);
      alignment.setMag(1);
      cohesion.setMag(1);

      if ( dist(follpos[i].x, follpos[i].y, leadpos.x, leadpos.y) < 500) { // if followers are within 500 pixels of leader
        steer.add(offset_pursuit);
        steer.add(separation);
        steer.add(alignment);
        steer.add(cohesion);
      } else {
        steer.add(wander);
      }

      steer.add(avoid);

      //  c - limit the size of the force that can be applied
      steer.limit(maxforce);

      // 3 - update boid's velocity
      //  a - add net steering force
      follvel[i].add(steer);
      //  b - limit boid's max speed
      follvel[i].limit(maxspeed);

      // 4 - update boid's position
      //  a - update position by adding velocity
      follpos[i].add(follvel[i]);
      //  b - wrap at edges of window
      if ( follpos[i].x > width ) {
        follpos[i].x = 0;
      } else if ( follpos[i].x < 0 ) {
        follpos[i].x = width;
      }
      if ( follpos[i].y > height ) {
        follpos[i].y = 0;
      } else if ( follpos[i].y < 0 ) {
        follpos[i].y = height;
      }
    }
  }

  // -- update leader ---------------------------------------------------------
  // update leader's position and velocity
  {
    // 2 - compute net steering force
    //  a - compute steering force for each behavior
    PVector seek = computeSeek (leadpos, leadvel, leadmaxspeed, new PVector(point.x, point.y));
    PVector wander = computeWander(leadpos, leadvel, leadmaxspeed);

    //  b - combine forces (one behavior)
    PVector steer = new PVector(0, 0);

    if (dist(leadpos.x, leadpos.y, point.x, point.y) < 200) {
      steer.add(seek);
    } else {
      steer.add(wander);
    }

    // pursue invisible target

    //  c - limit the size of the force that can be applied
    steer.limit(maxforce);

    // 3 - update boid's velocity
    //  a - add net steering force
    leadvel.add(steer);
    //  b - limit boid's max speed
    leadvel.limit(leadmaxspeed);

    // 4 - update boid's position
    //  a - update position by adding velocity
    leadpos.add(leadvel);
    //  b - wrap at edges of window
    if ( leadpos.x > width ) {
      leadpos.x = 0;
    } else if ( leadpos.x < 0 ) {
      leadpos.x = width;
    }
    if ( leadpos.y > height ) {
      leadpos.y = 0;
    } else if ( leadpos.y < 0 ) {
      leadpos.y = height;
    }
  }
  // Update t
  t += 0.05;
}
