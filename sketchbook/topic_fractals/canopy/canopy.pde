// Henry Wrede Black
// fractal canopy

void setup() {
  size(500, 500);
}
void draw() {
  background(255);

  drawTree(width/2, height, 100, -PI/2, 2*PI/11, 0.75);
}
// position (x,y), line segment length (len), orentation angle (a), angle (b) between segments, scale factor (s) between iterations
void drawTree(float x, float y, float len, float a, float b, float s) {
  if ( len < 5) {
    return;
  } else {
    // draw line segment
    line(x, y, x+cos(a)*len, y+sin(a)*len);

    // draw connecting line segments
    drawTree(x+cos(a)*len, y+sin(a)*len, s*len, a-b/2, 2*PI/11, 0.75);
    drawTree(x+cos(a)*len, y+sin(a)*len, s*len, a+b/2, 2*PI/11, 0.75);
  }
}
