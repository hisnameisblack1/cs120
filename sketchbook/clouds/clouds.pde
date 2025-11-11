// Henry Wrede Black
// cloud generation

// particle properties
float[] x, y;                    // position
float[] w, h;                    // size
float[] xspeed, yspeed;          // speed
float[] transparency;            // transparency
int[] lifetime;                  // lifetime

// child emitter properties
float[] emitX, emitY;            // center of emitter
float[] emitW, emitH;            // size of emitter
float[] emitXspeed, emitYspeed;  // speed of emitter
int[] emitLife;                  // emitter lifetime

// parent emitter properties
float parentX, parentY;          // center of emitter
float parentW, parentH;          // size of emitter
int parentLife;                  // emitter lifetime

void setup () {
  size(800, 300);

  // start particle as not alive
  x = new float[30000];
  for (int i = 0; i < x.length; i++) {
    x[i] = 0;
  }
  y = new float[30000];
  for (int i = 0; i < y.length; i++) {
    y[i] = 0;
  }
  w = new float[30000];
  for (int i = 0; i < w.length; i++) {
    w[i] = 0;
  }
  h = new float[30000];
  for (int i = 0; i < h.length; i++) {
    h[i] = 0;
  }
  xspeed = new float[30000];
  for (int i = 0; i < xspeed.length; i++) {
    xspeed[i] = 0;
  }
  yspeed = new float[30000];
  for (int i = 0; i < yspeed.length; i++) {
    yspeed[i] = 0;
  }
  transparency = new float[30000];
  for (int i = 0; i < transparency.length; i++) {
    transparency[i] = 0;
  }
  lifetime = new int[30000];
  for (int i = 0; i < lifetime.length; i++) {
    lifetime[i] = -1;
  }

  // start child emitter as not alive
  emitX = new float[10];
  emitY = new float[10];
  emitW = new float[10];
  emitH = new float[10];
  emitXspeed = new float[10];
  emitYspeed = new float[10];
  emitLife = new int[10];
  for (int i = 0; i < emitX.length; i++) {
    emitX[i] = 0;
    emitY[i] = 0;
    emitW[i] = 0;
    emitH[i] = 0;
    emitXspeed[i] = 0;
    emitYspeed[i] = 0;
    emitLife[i] = -1;
  }
  // initialize parent emitter
  parentX = random(20, 150);
  parentY = random(50, height-10);
  parentW = 50;
  parentH = 25;
  parentLife = 1000;
}

void draw () {
  background(0);
  // draw particle (if alive)
  for (int i = 0; i < x.length; i++) {
    if ( lifetime[i] >= 0 ) {
      noStroke();
      fill(255, transparency[i]);
      ellipse(x[i], y[i], w[i], h[i]);
    }
  }

  // update parent emitter - reset if its lifetime has expired
  //  or it has moved out of the window
  if ( parentLife >= 0 && parentX <= width && parentY >= 0 ) {
    parentX = parentX+1.5;  // moves right, seeding new clouds
    parentY = parentY-.05;
    parentW = parentW+.15;
    parentH = parentH+.1;
    parentLife = parentLife-1;
  } else {
    parentX = random(20, 150);
    parentY = random(50, height-10);
    parentW = 50;
    parentH = 25;
    parentLife = 1000;
  }
  // update child emitter - reset if its lifetime has expired
  for (int i = 0; i < emitX.length; i++) {
    if ( emitLife[i] >= 0 ) {
      emitX[i] = emitX[i]+emitXspeed[i];
      emitY[i] = emitY[i]+emitYspeed[i];
      emitW[i] = emitW[i]+.1;
      emitH[i] = emitH[i]+.05;
      emitLife[i] = emitLife[i]-1;
    } else {
      float angle = radians(random(0, 360));
      emitX[i] = parentX+random(0, parentW/2)*cos(angle);
      emitY[i] = parentY+random(0, parentH/2)*sin(angle);
      emitXspeed[i] = (emitX[i]-parentX)/parentW/10;
      emitYspeed[i] = -abs((emitY[i]-parentY)/parentH/5);
      emitW[i] = 20;
      emitH[i] = 10;
      emitLife[i] = int(random(50, 500));
    }
  }
  // update particle - reset if its lifetime has expired
  for (int i = 0; i < x.length; i++) {
    if ( lifetime[i] >= 0 ) {
      x[i] = x[i]+xspeed[i];
      y[i] = y[i]+yspeed[i];
      if ( lifetime[i] >= 255*2 ) {
        transparency[i] = min(transparency[i]+1, 255);
      } else {
        // fade/shrink older particles for a more graceful cloud
        //  dissolution
        transparency[i] = transparency[i]-.5;
        w[i] = max(w[i]-.05, 0);
        h[i] = max(h[i]-.05, 0);
      }
      lifetime[i] = lifetime[i]-1;
    } else if ( random(0, 2000) <= 1 ) {   // reset expired particle (staggered)
      float angle = random(0, 2*PI);
      int emit = int(random(0, emitX.length));
      x[i] = emitX[emit]+random(0, emitW[emit]/2)*cos(angle);
      y[i] = emitY[emit]+random(0, emitH[emit]/2)*sin(angle);
      xspeed[i] = emitXspeed[emit]+(x[i]-emitX[emit])/emitW[emit]/10;
      yspeed[i] = emitYspeed[emit]-abs((y[i]-emitY[emit])/emitH[emit]/10);
      w[i] = random(5, 15);
      h[i] = random(5, 15);
      transparency[i] = random(0, 20);
      lifetime[i] = int(random(700, 1000));
    }
  }
}
