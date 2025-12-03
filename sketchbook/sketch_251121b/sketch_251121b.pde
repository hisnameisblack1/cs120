// Henry Wrede Black
// Intro to L-Systems - Fractal Binary Tree

void setup() {
  size(500, 500);
}
void draw() {
  background(255);

  drawfract(width/2, height, 4, 7);
}

// F production rules
void drawF1(int depth, float len) {
  if (depth == 0) {
    line(0, 0, len, 0);
    translate(len, 0);
  } else {
    // rule: F1F1
    drawF1(depth-1, len);
    drawF1(depth-1, len);
  }
}
void drawF0(int depth, float len) {
  if (depth == 0) {
    line(0, 0, len, 0);
    translate(len, 0);
  } else {
    // rule: F1[+F0]-F0
    drawF1(depth-1, len);
    pushMatrix();
    rotate(radians(45));
    drawF0(depth-1, len);
    popMatrix();
    rotate(radians(-45));
    drawF0(depth-1, len);
  }
}
void drawfract (int x, int y, float len, int depth) {
  pushMatrix();

  translate(x, y);
  rotate(radians(270));

  // generator: F0
  drawF0(depth, len);

  popMatrix();
}
