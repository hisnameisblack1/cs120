// Henry Wrede Black
// sierpinski gasket

void setup() {
  size(500, 500);
}
void draw() {
  background(200, 255, 200);
  drawSierpinski(0, height, 500);
}
void drawSierpinski( float x, float y, float w) {
  if (w < 50) {
    // draw one triangle
    fill(0);
    stroke(0);
    triangle(x, y, x+w, y, x+w/2, y-w);
  } else {
   drawSierpinski(x, y, w/2);
   drawSierpinski(x+w/2, y, w/2);
   drawSierpinski(x+w/4, y-w/2, w/2);
  }
}
