// Henry Wrede Black
// ecosystem simulation

// prey
PVector preypos, preyvel;  // position and velocity
float preyhunger;  // hunger
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
  preypos = new PVector(random(0, width), random(0, height));
  preyvel = new PVector(random(-1, 1), random(-1, 1));
  predpos = new PVector(random(0, width), random(0, height));
  predvel = new PVector(random(-1, 1), random(-1, 1));

  // hunger
  preyhunger = random(100, 1000);

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
  drawBoid(preypos, preyvel, 255, 255-preyhunger, 255-preyhunger);
  // predator boid
  drawBoid(predpos, predvel, 0, 0, 255);

  // -- update prey ---------------------------------------------------------

  // if the prey isn't full and food has been reached, update hunger and food supply
  // otherwise prey gets more hungry
  if ( preyhunger < 1000 && dist(foodpos.x, foodpos.y, preypos.x, preypos.y) < 10 ) {
    preyhunger = preyhunger+100;
    food = food-.5;
  } else {
    preyhunger = preyhunger-1;
  }
  // update prey's position and velocity
  {
    // 2 - compute net steering force
    //  a - compute steering force for each behavior

    //  b - combine forces (one behavior)
    PVector steer = new PVector(0, 0);

    //  c - limit the size of the force that can be applied
    steer.limit(preymaxforce);

    // 3 - update boid's velocity
    //  a - add net steering force
    preyvel.add(steer);
    //  b - limit boid's max speed
    preyvel.limit(preymaxspeed);

    // 4 - update boid's position
    //  a - update position by adding velocity
    preypos.add(preyvel); 
    //  b - wrap at edges of window
    if ( preypos.x > width ) { 
      preypos.x = 0;
    } else if ( preypos.x < 0 ) { 
      preypos.x = width;
    }
    if ( preypos.y > height ) { 
      preypos.y = 0;
    } else if ( preypos.y < 0 ) { 
      preypos.y = height;
    }
  }

  // -- update predator ---------------------------------------------------------
  // update predator's position and velocity
  {
    // 2 - compute net steering force
    //  a - compute steering force for each behavior

    //  b - combine forces (one behavior)
    PVector steer = new PVector(0, 0);

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
