//testing

int circDi = 200;


void setup() {
  size(400, 400);
}

void draw() {
  background(255);
  noStroke();
  fill(255, 0, 0);
  ellipse(200, 200, circDi, circDi);
}

void mousePressed() {
  background(255);
  circDi = circDi - 10;
}
