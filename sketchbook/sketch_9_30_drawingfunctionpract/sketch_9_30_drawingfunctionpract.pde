//Henry Wrede Black

//working with user functions

void setup() {
  size(1000, 600);
}

void draw() {
  background(75);
  snowman(width/2, height-100, 200);
  snowman(width/4, height-200, 100);
  snowman(mouseX, mouseY, 100);
}

void snowman(int x, int y, int d) {
  ellipseMode(CENTER);
  fill(255);

float d1 = d;
float d2 = d*0.66;
float d3 = d*0.33;

  ellipse(x, y, d1, d1);
  ellipse(x, y-(d1/2+d2/2), d2, d2);
  ellipse(x, y-(d1/2+d2+d3/2), d3, d3);
}
