// Henry Wrede Black
// exploding fireworks

// spark properties
float[] x, y;             // position
float[] xspeed, yspeed;   // speed
float transparency;     // transparency

float timer;            // stage timer
boolean exploding;      // true if exploding, false if in launch stage

void setup () {
  size(500, 500);
  // initialize for launch
  reset();
  timer = random(50, 150);
  exploding = false;
}

void draw () {
  background(0);
  // draw fireworks sparks
  for (int i = 0; i < x.length; i++) {
    noStroke();
    fill(255, 255, 0, transparency);
    ellipse(x[i], y[i], 4, 4);
  }
  // update fireworks sparks
  for (int i = 0; i < x.length; i++) {
    x[i] = x[i]+xspeed[i];
    y[i] = y[i]+yspeed[i];
    yspeed[i] = yspeed[i]+.04;  // gravity
  }
  if ( exploding ) {    // exploding sparks also fade away
    transparency = transparency-1;
  }
  // update countdown timer
  timer = timer-1;
  // handle stage transitions - when timer expires
  if ( timer <= 0 && !exploding ) {  // launch -> exploding
    exploding = true;
    timer = 200;  // reset timer
    // change speeds as the firework explodes
    for (int i = 0; i < x.length; i++) {
      float angle = random(0, 2*PI);
      xspeed[i] = xspeed[i]+cos(angle)*random(0, 1);
      yspeed[i] = yspeed[i]+sin(angle)*random(0, 1);
    }
  } else if ( timer <= 0 && exploding ) {  // exploding -> launch
    exploding = false;
    timer = random(50, 150);  // reset timer
    reset();  // reset spark for launch
  }
}
// reset spark for the beginning of the launch
void reset () {
  // firework starts somewhere in the middle-ish of the screen,
  //  at the bottom
  float launchx = random(width/4, 3*width/4);
  x = new float[1000];
  for (int i = 0; i < x.length; i++) {
    x[i] = launchx;
  }
  y = new float[1000];
  for (int i = 0; i < y.length; i++) {
    y[i] = height;
  }

  // launch goes straight up
  xspeed = new float[1000];
  for (int i = 0; i < xspeed.length; i++) {
    xspeed[i] = 0;
  }
  yspeed = new float[1000];
  for (int i = 0; i < yspeed.length; i++) {
    yspeed[i] = -6;
  }
  // spark is fully opaque during launch
  transparency = 255;
}
