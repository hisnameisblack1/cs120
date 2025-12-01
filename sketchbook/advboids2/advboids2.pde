// Henry Wrede Black
// group of boids folling leader

// followers
PVector[] follpos, follvel;  // position and velocity

// leader
PVector leadpos, leadvel;    // position and velocity

// gen pararamters for all boids
float radius, angle;         // defines what the follower can see
float maxforce, maxspeed;    // other follower parameters

// variables for parametric equation
float t;                     // time variable
float R, r, a;               // variables for hypoconchroidal motion
float cx, cy;                // centerpoint of hypoconchroid

void setup () {
  size(800, 800);

  // start with random positions and velocities
  //  followers
  follpos = new PVector[100];
  follvel = new PVector[100];
  for (int i = 0; i < follpos.length; i++) {
    follpos[i] = new PVector(random(0, width), random(0, height));
    follvel[i] = new PVector(random(-1, 1), random(-1, 1));
  }
  //  leader
  leadvel =  new PVector(random(-1, 1), random(-1, 1));

  // other boid properties
  radius = 60;
  angle = radians(135);
  maxforce = .3;
  maxspeed = 3;

  t = 1;
  cx = width/2;
  cy = height/2;
  R = 133;
  r = 57;
  a = 1.5;
}

void draw () {
  // 1 - draw scene
  background(255);
  for (int i = 0; i < follpos.length; i++) {
    // follower boid
    drawBoid(follpos[i], follvel[i], 0, 150, 0);
  }
  // leader boid
PVector leaderpos = new PVector((R-r)*cos(t) + a*r*cos(t*(R-r)/r) + cx, (R-r)*sin(t) + a*r*sin(t*(R-r)/r) + cy);
  
  drawBoid(leaderpos, leadvel, 0, 200, 200);

  // -- update followers ---------------------------------------------------------
  // update follower's position and velocity
  {
    for (int i = 0; i < follpos.length; i++) {
      // 2 - compute net steering force
      //  a - compute steering force for each behavior
      PVector wander = computeWander(follpos[i], follvel[i], maxspeed);
      PVector offset_pursuit = computeOffsetPursuit ( follpos[i], follvel[i], maxspeed, leaderpos, leadvel, new PVector(-leaderpos.x-10, leaderpos.y));
      PVector avoid = computeCollisionAvoidance(follpos[i], follvel[i], maxforce, leaderpos, leadvel, 100);
      PVector separation = computeSeparation(follpos[i], follvel[i], radius, angle, follpos, follvel);

      //  b - combine forces (one behavior)
      PVector steer = new PVector(0, 0);
      if ( dist(follpos[i].x, follpos[i].y, leaderpos.x, leaderpos.y) < 300) {
        steer.add(offset_pursuit);
        steer.add(separation);
        steer.add(avoid);
      } else {
        steer.add(wander);
      }

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
    PVector wander = computeWander(leaderpos, leadvel, maxspeed);
    //  b - combine forces (one behavior)
    PVector steer = new PVector(0, 0);

    steer.add(wander);

    //  c - limit the size of the force that can be applied
    steer.limit(maxforce);

    // 3 - update boid's velocity
    //  a - add net steering force
    leadvel.add(steer);
    //  b - limit boid's max speed
    leadvel.limit(maxspeed);

    // 4 - update boid's position
    //  a - update position by adding velocity
    leaderpos.add(leadvel);
    //  b - wrap at edges of window
    if ( leaderpos.x > width ) {
      leaderpos.x = 0;
    } else if ( leaderpos.x < 0 ) {
      leaderpos.x = width;
    }
    if ( leaderpos.y > height ) {
      leaderpos.y = 0;
    } else if ( leaderpos.y < 0 ) {
      leaderpos.y = height;
    }
  }
  // Update time variable 
  t += 0.015;
  
  
}
