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
//   production rule:
//   angle: , scale factor: 1
void drawF(int depth, float len) {
  if (depth == 0) {
    // do 'F' - draw line, move turtle
    line(0, 0, len, 0);
    translate(len, 0);
  } else {
    // otherwise do what the rule states: 
   
  }
}

// X - Production rule
//   production rule: 
//   angle: , scale factor: 1
void drawX(int depth, float len) {
  if (depth == 0) {
  } else {
    // otherwise do what rule states: 

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
