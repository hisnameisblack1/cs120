// Henry Wrede Black
// Drunkards Path Quilt Pattern

void setup() {
  size(400, 400);
  background(255);
}
void draw() {
  q4x4(100, 100);
  q4x4(300, 100);
  q4x4(100, 300);
  q4x4(300, 300);
}
// -- Drawing Functions
// c1 affects the color of the square, c2 affects the arc's color
void tLeft(int x, int y, float c1, float c2) { // arc in top left
  rectMode(CENTER);
  ellipseMode(CENTER);
  noStroke();
  fill(c1, c1, 200);
  rect(x, y, 50, 50);
  fill(c2, c2, 200);
  arc(x-25, y-25, 60, 60, 0, HALF_PI);
}
void tRight(int x, int y, float c1, float c2) { // arc in top right
  rectMode(CENTER);
  ellipseMode(CENTER);
  noStroke();
  fill(c1, c1, 200);
  rect(x, y, 50, 50);
  fill(c2, c2, 200);
  arc(x+25, y-25, 60, 60, HALF_PI, PI);
}
void bLeft(int x, int y, float c1, float c2) { // arc in bottom left
  rectMode(CENTER);
  ellipseMode(CENTER);
  noStroke();
  fill(c1, c1, 200);
  rect(x, y, 50, 50);
  fill(c2, c2, 200);
  arc(x-25, y+25, 60, 60, PI+HALF_PI, TWO_PI);
}
void bRight(int x, int y, float c1, float c2) { // arc in bottom right
  rectMode(CENTER);
  ellipseMode(CENTER);
  noStroke();
  fill(c1, c1, 200);
  rect(x, y, 50, 50);
  fill(c2, c2, 200);
  arc(x+25, y+25, 60, 60, PI, PI+HALF_PI);
}
void q4x4(int x, int y) { // 4x4 block of arc blocks
  //top left
  tRight(x-75, y-75, 200, 0);
  bLeft(x-25, y-75, 0, 200);
  tRight(x-75, y-25, 0, 200);
  tRight(x-25, y-25, 200, 0);
  //top right
  bRight(x+25, y-75, 0, 200);
  bRight(x+75, y-75, 200, 0);
  bRight(x+25, y-25, 200, 0);
  tLeft(x+75, y-25, 0, 200);
  //bottom left
  bRight(x-75, y+25, 0, 200);
  tLeft(x-25, y+25, 200, 0);
  tLeft(x-75, y+75, 200, 0);
  tLeft(x-25, y+75, 0, 200);
  //bottom right
  bLeft(x+25, y+25, 200, 0);
  bLeft(x+75, y+25, 0, 200);
  tRight(x+25, y+75, 0, 200);
  bLeft(x+75, y+75, 200, 0);
}
