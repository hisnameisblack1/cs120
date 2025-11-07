// Henry Wrede Black

// 50 growing/fading circles that look kind of like a raindrop in a puddle
// clicking the mouse toggles the fill color for the circles

float[] x, y;  // circle position
float diam[];  // circle size
float c[];     // circle color

boolean fill;  // if true, fill the circle with its current
//  color instead of white

void setup () {
  size(600, 600);

  // circle starts with random position
  x = new float[50];
  for (int i = 0; i < x.length; i++) {
    x[i] = random(0, width);
  }
  y = new float[50];
  for (int i = 0; i < y.length; i++) {
    y[i] = random(0, height);
  }

  // circle starts with random size
  diam = new float[50];
  for (int i = 0; i < diam.length; i++) {
    diam[i] = random(0, 50);
  }
  // circle starts with random (grayscale) color
  c = new float[50];
  for (int i = 0; i < c.length; i++) {
    c[i] = random(0, 255);
  }
}

void draw () {
  background(255);

  // draw the circle
  for (int i = 0; i < x.length; i++) {
    stroke(c[i]);
    if ( fill ) {
      fill(c[i]);
    } else {
      fill(255);
    }
    ellipse(x[i], y[i], diam[i], diam[i]);
  }
  // update the size and color (and position, sometimes) of the circle
  for (int i = 0; i < x.length; i++) {
    diam[i] = diam[i]+1;  // grow
    c[i] = c[i]+3;    // fade
    if ( c[i] >= 255 ) {   // reset when the color has become white
      c[i] = 0;
      diam[i] = 0;
      x[i] = random(0, width);
      y[i] = random(0, height);
    }
  }
}

void mouseClicked () {
  fill = !fill;   // toggle fill
}
