// Henry Wrede Black
// group of boids folling leader

// followers
PVector[] follpos, follvel;  // position and velocity

// leader
PVector leadpos, leadvel;    // position and velocity

// gen pararamters for all boids
float radius, angle;         // defines what the follower can see
float maxforce, maxspeed;    // other follower parameters

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
  leadpos = new PVector(random(0, width), random(0, height));
  leadvel =  new PVector(random(-1, 1), random(-1, 1));

  // other boid properties
  radius = 60;
  angle = radians(135);
  maxforce = .3;
  maxspeed = 3;

}

void draw () {
  // 1 - draw scene
  background(255);
  for (int i = 0; i < follpos.length; i++) {
    // follower boid
    drawBoid(follpos[i], follvel[i], 0, 150, 0);
  }
  // leader boid
  drawBoid(leadpos, leadvel, 0, 200, 200);

  // -- update followers ---------------------------------------------------------
  // update follower's position and velocity
  {
    for (int i = 0; i < follpos.length; i++) {
      // 2 - compute net steering force
      //  a - compute steering force for each behavior
      PVector wander = computeWander(follpos[i], follvel[i], maxspeed);
      PVector offset_pursuit = computeOffsetPursuit ( follpos[i], follvel[i], maxspeed, leadpos, leadvel, new PVector(-leadpos.x-10, leadpos.y));
      PVector avoid = computeCollisionAvoidance(follpos[i], follvel[i], maxforce, leadpos, leadvel, 100);
      PVector separation = computeSeparation(follpos[i], follvel[i], radius, angle, follpos, follvel);

      //  b - combine forces (one behavior)
      PVector steer = new PVector(0, 0);
      if ( dist(follpos[i].x, follpos[i].y, leadpos.x, leadpos.y) < 300) {
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
    PVector wander = computeWander(leadpos, leadvel, maxspeed);
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
}
