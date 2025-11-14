//Henry Wrede Black
// two wandering circles

float t;
float x;
float y;
void setup() {
  size(400, 400);
  t = 0;
  x= width/4;
  y = height/2;
}
void draw() {
  ellipseMode(CENTER);
  background(255);

  x = x + random(-3, 3);
  y = y + random(-3, 3);
  // draw circle
  fill(255, 0, 0);
  ellipse(x, y, 25, 25);
  // update circle position
  {
    float x = map(noise(t), 0, 1, width/2, width);
    float y = map(noise(t+1), 0, 1, height/4, height-(height/4) );
    fill(0, 0, 255);
    ellipse(x, y, 25, 25);
  }
  // update t variable
  t+=.01;
}
// Interaction
void mousePressed() {
  x = width/4;
  y = height/2;
  t = 0;
}
