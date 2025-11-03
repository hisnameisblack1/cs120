//Henry Wrede Black, Joey Burvis
//small black circle that moves up diagonally

float x; //x value for the circle
float y; //y value for the circle

void setup() {
  size(400, 400);
  x = width - width;
  y = height - 50;
}

void draw() {
  background(255);
  ellipseMode(CORNER);

  noStroke();
  fill(0);

  ellipse(x, y, 50, 50);

  x = x + 1; //increments the circle right 1 every frame
  y = y - 1; //increments the circle up 1 every frame
}
