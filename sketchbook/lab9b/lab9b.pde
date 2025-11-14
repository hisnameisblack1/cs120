// Henry Wrede Black
// objects whose animation starts after some period of time

float[] x, y;  // ellipse's position
int[] timer;   // remaining delay until ellipse starts moving

void setup () {
  size(400, 400);

  // ellipse starts in a random position
  x = new float[50];
  for (int i = 0; i < x.length; i++) {
    x[i] = random(0, width);
  }
  y = new float[50];
  for (int i = 0; i < y.length; i++) {
    y[i] = random(0, height);
  }

  // each ellipse will start moving after 40 frames plus it's location in the array 
  timer = new int[50];
  for (int i = 0; i < timer.length; i++) {
    timer[i] = 40+40*i;
  }
}

void draw () {
  background(255);

  // always draw the ellipse
  for (int i = 0; i < x.length; i++) {
    fill(255, 0, 0);
    ellipse(x[i], y[i], 10, 10);
  }
  // always decrease the timer
  for (int i = 0; i < timer.length; i++) {
    timer[i] = timer[i]-1;

    // only move the ellipse if the timer has gotten to 0 (or below)
    if ( timer[i] <= 0 ) {
      x[i] = x[i]+1;
    }
  }
}
