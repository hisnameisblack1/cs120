// Henry Wrede Black
// first plant

void setup() {
  size(500, 500);
}
void draw() {
  background(255);
  
  drawFract(width/2, height, 1.5, 7);
}
// F - Production rule
//   production rule: F → FF
//   angle: 22.5, scale factor: 1
void drawF(int depth, float len) {
  if (depth == 0) {
    // do 'F' - draw line, move turtle
    line(0, 0, len, 0);
    translate(len, 0);
  } else {
    // otherwise do what the rule states: F -> FF
    drawF(depth-1, len);
    drawF(depth-1, len);
  }
}

// X - Production rule
//   production rule: X → F-[[X]+X]+F[+FX]-X
//   angle: 22.5, scale factor: 1
void drawX(int depth, float len) {
  if (depth == 0) {
  } else {
    // otherwise do what rule states: X → F-[[X]+X]+F[+FX]-X
    drawF(depth-1, len);
    rotate(radians(-22.5));
    pushMatrix();
    pushMatrix();
    drawX(depth-1, len);
    popMatrix();
    rotate(radians(22.5));
    popMatrix();
    rotate(radians(22.5));
    drawF(depth-1, len);
    pushMatrix();
    rotate(radians(22.5));
    drawF(depth-1, len);
    drawX(depth-1, len);
    popMatrix();
    rotate(radians(-22.5));
    drawX(depth-1, len);
  }
}

// Generator - drawing function for the whole fractal
void drawFract(int x, int y, float len, int depth) {
  pushMatrix();
  // set up turtles initial position
  translate(x, y);
  rotate(radians(270));

  // generator: X
  drawX(depth, len);

  popMatrix();
}
