// Henry Wrede Black

// a moving plume which cycles through the rainbow

// spark properties -- MAKE ARRAY VARIABLES
float[] x, y;                // position
float[] xspeed, yspeed;      // speed
float[] hue, saturation, brightness;  // color (HSB)
float[] transparency;        // transparency
float[] t;                   // noise parameter

// emitter properties
float emitterX;              // center of emitter
float emitterSpeed;          // speed of emitter
float emitterHue;            // hue of particles currently being emitted

void setup () {
  size(1000, 400);
  colorMode(HSB);

  // start offscreen and invisible -- INIT ARRAY VAR
  x = new float[30000];
  for (int i = 0; i < x.length; i++) {
    x[i] = 0;
  }
  y = new float[30000];
  for (int i = 0; i < y.length; i++) {
    y[i] = height+10;
  }
  xspeed = new float[30000];
  for (int i = 0; i < xspeed.length; i++) {
    xspeed[i] = 0;
  }
  yspeed = new float[30000];
  for (int i = 0; i < yspeed.length; i++) {
    yspeed[i] = 0;
  }
  hue = new float[30000];
  for (int i = 0; i < hue.length; i++) {
    hue[i] = 0;
  }
  saturation = new float[30000];
  for (int i = 0; i < saturation.length; i++) {
    saturation[i] = 0;
  }
  brightness = new float[30000];
  for (int i = 0; i < brightness.length; i++) {
    brightness[i] = 0;
  }
  transparency = new float[30000];
  for (int i = 0; i < transparency.length; i++) {
    transparency[i] = -1;
  }
  t = new float[30000];
  for (int i = 0; i < t.length; i++) {
    t[i] = 0;
  }

  emitterX = 10;
  emitterSpeed = 0.25;
  emitterHue = 0;
}

void draw () {
  background(0);

  // draw spark
  for (int i = 0; i < x.length; i++) {
    noStroke();
    fill(hue[i], saturation[i], brightness[i], transparency[i]);
    ellipse(x[i], y[i], 2, 2);
  }

  // update spark
  for (int i = 0; i < x.length; i++) {
    if ( transparency[i] >= 0  ) {        // when spark is visible...
      x[i] = x[i]+xspeed[i]+map(noise(t[i]), 0, 1, -.7, .7);   // noise to wiggle spark as it rises
      y[i] = y[i]+yspeed[i];
      xspeed[i] = xspeed[i]-.01*xspeed[i];
      transparency[i] = transparency[i]-1;
      t[i] = t[i]+.005;
    } else if ( random(0, 100) <= 1 ) {   // reset spark when no longer visible (staggered)
      x[i] = emitterX+random(-5, 5);
      y[i] = height;
      xspeed[i] = emitterSpeed;
      yspeed[i] = random(-1.5, -3.5);
      t[i] = random(0, 1000);
      hue[i] = random(emitterHue-10, emitterHue+10);
      saturation[i] = random(200, 255);
      brightness[i] = random(200, 255);
      transparency[i] = random(200, 255);
    }
  }
  // update emitter
  emitterX = emitterX+emitterSpeed;
  emitterHue = emitterHue+emitterSpeed*255/width;  // so it cycles through colors across the width of the window
}
