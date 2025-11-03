//Henry Wrede Black
//test to map mouseX position to control speed of a circle

float x;
float y;
float a;
float c;

void setup() {
  size(500, 500);

  x = width/2;
  y = height/2;

}

void draw() {
  ellipseMode(CENTER);
  background(255);

  fill(255, 0, 0);
  ellipse(x, y, 25, 25);

  a = map(mouseX, 0, width, -1, 1);
  c = map(mouseY, 0, height, -1, 1);

  x = x + a;
  y = y + c;
}
