// Henry Black
// Intro to L-Systems - Quadratic Koch Island

void setup() {
  size(500, 500);
}
void draw() {
  background(255);
  
  QuadKoch(125, 125, 250, 3);
  
}
// Drawing function for the F production rule
void drawF(int depth, float len) {
  if (depth == 0) {
    // do the 'F' action - draw line, move turtle
    line(0, 0, len, 0);
    translate(len, 0);
  } else {
    // otherwise, do what the rule states: F+F-F-FF+F+F-F
    drawF(depth-1, len/4);
    rotate(radians(90));
    drawF(depth-1, len/4);
    rotate(radians(-90));
    drawF(depth-1, len/4);
    rotate(radians(-90));
    drawF(depth-1, len/4);
    drawF(depth-1, len/4);
    rotate(radians(90));
    drawF(depth-1, len/4);
    rotate(radians(90));
    drawF(depth-1, len/4);
    rotate(radians(-90));
    drawF(depth-1, len/4);
  }
}
// Generator - drawing function for the whole fractal
void QuadKoch ( int x, int y, float len, int depth) {
  pushMatrix();
  
  // set up initial position and orientation -
  // turtle should start at the upper left corner of the 
  // initial quad, facing right
  translate(x, y);
  rotate(radians(0)); // turtle is facing right
  
  // generator: F+F+F+
  drawF(depth, len);
  rotate(radians(90));
  drawF(depth, len);
  rotate(radians(90));
  drawF(depth, len);
  rotate(radians(90));
  drawF(depth, len);
  rotate(radians(90));
  
  popMatrix();
}
