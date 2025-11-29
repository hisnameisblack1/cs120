// Henry Wrede Black
// ecosystem simulation

// prey
PVector[] preypos, preyvel;  // position and velocity
float[] preyhunger;  // hunger
float preyradius, preyangle;  // defines what the prey can see
float preymaxforce, preymaxspeed;  // other prey parameters

// predator
PVector predpos, predvel;  // position and velocity
float predradius, predangle;  // defines what the predator can see
float predmaxforce, predmaxspeed;  // other predator parameters

// food
float food;   // amount of food left
PVector foodpos;   // food position

void setup () {
  size(800, 800);

  // start with random positions and velocities
  //   prey
  preypos = new PVector[100];
  preyvel = new PVector[100];
  for (int i = 0; i < preypos.length; i++) {
    preypos[i] = new PVector(random(0, width), random(0, height));
    preyvel[i] = new PVector(random(-1, 1), random(-1, 1));
  }
  //   predator
  predpos = new PVector(random(0, width), random(0, height));
  predvel = new PVector(random(-1, 1), random(-1, 1));

  // hunger
  preyhunger = new float[100];
  for (int i = 0; i < preyhunger.length; i++) {
    preyhunger[i] = random(100, 1000);
  }
  // other boid properties
  preyradius = 60;
  preyangle = radians(135);
  preymaxforce = .3;
  preymaxspeed = 3;
  predradius = 300;
  predangle = radians(135);
  predmaxforce = .1;
  predmaxspeed = 2;

  // food
  food = 255;
  foodpos = new PVector(random(50, width-50), random(50, height-50));
}

void draw () {

  // 1 - draw scene
  background(255);
  // food
  fill(255-food);
  ellipse(foodpos.x, foodpos.y, 20, 20);
  // prey boid
  for (int i = 0; i < preypos.length; i++) {
    drawBoid(preypos[i], preyvel[i], 255, 255-preyhunger[i], 255-preyhunger[i]);
  }
  // predator boid
  drawBoid(predpos, predvel, 0, 0, 255);

  // -- update prey ---------------------------------------------------------

  // if the prey isn't full and food has been reached, update hunger and food supply
  // otherwise prey gets more hungry
  for (int i = 0; i < preypos.length; i++) {
    if ( preyhunger[i] < 1000 && dist(foodpos.x, foodpos.y, preypos[i].x, preypos[i].y) < 10 ) {
      preyhunger[i] = preyhunger[i]+100;
      food = food-.5;
    } else {
      preyhunger[i] = preyhunger[i]-1;
    }
    // update prey's position and velocity
    {
      // 2 - compute net steering force
      //  a - compute steering force for each behavior
      PVector evade = computeEvade( preypos[i], preyvel[i], preymaxspeed, predpos, predvel);
      PVector separation = computeSeparation(preypos[i], preyvel[i], preyradius, preyangle, preypos, preyvel);
      PVector alignment = computeAlignment(preypos[i], preyvel[i], preyradius, preyangle, preypos, preyvel);
      PVector cohesion = computeCohesion(preypos[i], preyvel[i], preyradius, preyangle, preypos, preyvel);
      PVector avoid = computeCollisionAvoidance(preypos[i], preyvel[i], preymaxforce, preypos, preyvel, 50);
      PVector arrive = computeArrive(preypos[i], preyvel[i], preymaxspeed, foodpos, 100);
      PVector wander = computeWander(preypos[i], preyvel[i], preymaxspeed);
      //  b - combine forces (one behavior)
      PVector steer = new PVector(0, 0);
      separation.setMag(6);
      alignment.setMag(5);
      cohesion.setMag(5);

      if ( dist(preypos[i].x, preypos[i].y, predpos.x, predpos.y) < 250) { // if preyboid is within 250 pixels
        steer.add(evade);
        steer.add(separation);
        steer.add(alignment);
        steer.add(cohesion);
      } else if (dist(preypos[i].x, preypos[i].y, foodpos.x, foodpos.y) > 100 && avoid.mag() > 0) { // if prey is not near food and theres potential for a collision
        steer.add(avoid);
      } else if (preyhunger[i] <= 0 && dist(foodpos.x, foodpos.y, preypos[i].x, preypos[i].y) < 300) { // prey is hungry and within 300 pixels of food
        steer.add(arrive);
      } else {
        steer.add(wander);
      }

      //  c - limit the size of the force that can be applied
      steer.limit(preymaxforce);

      // 3 - update boid's velocity
      //  a - add net steering force
      preyvel[i].add(steer);
      //  b - limit boid's max speed
      preyvel[i].limit(preymaxspeed);

      // 4 - update boid's position
      //  a - update position by adding velocity
      preypos[i].add(preyvel[i]);
      //  b - wrap at edges of window
      if ( preypos[i].x > width ) {
        preypos[i].x = 0;
      } else if ( preypos[i].x < 0 ) {
        preypos[i].x = width;
      }
      if ( preypos[i].y > height ) {
        preypos[i].y = 0;
      } else if ( preypos[i].y < 0 ) {
        preypos[i].y = height;
      }
    }
  }
  // -- update predator ---------------------------------------------------------
  // update predator's position and velocity
  {
    // 2 - compute net steering force
    //  a - compute steering force for each behavior
    PVector pursue = computePursue (predpos, predvel, predradius, predangle, predmaxspeed, preypos, preyvel);
    PVector wander = computeWander(predpos, predvel, predmaxspeed);
    //  b - combine forces (one behavior)
    PVector steer = new PVector(0, 0);

    if (pursue.mag() > 0) { // if there's prey in sight
      steer.add(pursue);
    } else {
      steer.add(wander);
    }

    //  c - limit the size of the force that can be applied
    steer.limit(predmaxforce);

    // 3 - update boid's velocity
    //  a - add net steering force
    predvel.add(steer);
    //  b - limit boid's max speed
    predvel.limit(predmaxspeed);

    // 4 - update boid's position
    //  a - update position by adding velocity
    predpos.add(predvel);
    //  b - wrap at edges of window
    if ( predpos.x > width ) {
      predpos.x = 0;
    } else if ( predpos.x < 0 ) {
      predpos.x = width;
    }
    if ( predpos.y > height ) {
      predpos.y = 0;
    } else if ( predpos.y < 0 ) {
      predpos.y = height;
    }
  }

  // -- update food ---------------------------------------------------------
  // move food if depleted
  if ( food < 0 ) {
    food = 255;
    foodpos = new PVector(random(50, width-50), random(50, height-50));
  }
}
