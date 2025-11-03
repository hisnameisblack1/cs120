//Henry Wrede Black

float d; //var for diameter
float s; //var for speed 
float a; //var for accelleration

void setup() {
  size(400, 400);

  d = 0;
  s = 8;
  a = -0.1;
}

void draw() {
  ellipseMode(CENTER);
  background(255); //white

  fill(255, 0, 0); //red
  ellipse(width/2, height/2, d, d);

  d += s; //diameter increases by speed "s"
  s = max(0, s + a);
}

void mousePressed() {
  d = 0; //resets diameter to 0
  s = 8; //resets speed to 8
}
