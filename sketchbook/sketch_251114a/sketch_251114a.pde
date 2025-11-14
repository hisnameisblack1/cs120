// Henry Wrede Black
// t-square fractal

void setup() {
  size(500, 500);
}
void draw() {
  background(255, 200, 200);
  
  drawSquares(width/2, height/2, 250);
}
void drawSquares( float x, float y, float w) {
  // additive pattern
  if ( w < 2) {
    return;
  } else {
    rectMode(CENTER);
    fill(0);
    stroke(0);
    rect(x, y, w, w);
    
    // draw four squares at corner
    drawSquares(x-w/2, y+w/2, w/2);
    drawSquares(x-w/2, y-w/2, w/2);
    drawSquares(x+w/2, y+w/2, w/2);
    drawSquares(x+w/2, y-w/2, w/2);
  }
}
