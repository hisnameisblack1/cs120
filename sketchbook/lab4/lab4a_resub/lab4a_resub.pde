// Henry Wrede Black
// expanding circle, diamaeter stops before reaching the sides of the window

float d; //var for diameter
float s; //var for speed 
void setup() {
  size(400, 400);
  d = 0;
  s = 8;
}
void draw() {
  ellipseMode(CENTER);
  background(255); //whites
  // draw ellipse
  fill(255, 0, 0); //red
  ellipse(width/2, height/2, d, d);
  // update ellipse
  d += s; //diameter increases by speed "s"
  s = max(0, s + -0.1);
}
// Interaction
void mousePressed() {
  d = 0; //resets diameter to 0
  s = 8; //resets speed to 8
}
