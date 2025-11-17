// Henry Wrede Black
// Additive pattern for fractals

void setup() {
  size(400, 400);
}
void draw() {
  background(200, 200, 255);
  drawSnowFamily(width/2, height-100, 200);
}
void drawSnowFamily(int x, int y, int dim) {
  if (dim < 10) {
    return;
  } else {
    ellipseMode(CENTER);
    fill(255);
    stroke(0);
    ellipse(x, y, dim, dim);
    ellipse(x, y-(dim/2+dim/3), 2*dim/3, 2*dim/3);
    ellipse(x, y-(dim/2+dim/3+dim/6), dim/3, dim/3);
    // draw smaller copies
    drawSnowFamily(x-(dim/2+dim/4), y+dim/4, dim/2);
    drawSnowFamily(x+(dim/2+dim/4), y+dim/4, dim/2);
  }
}
