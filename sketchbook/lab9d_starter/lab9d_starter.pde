// Henry Wrede Black
// single-version of lab9d array sketch
// ocean highway with one car

//car properties
float x, y; //position
float xspeed; //speed
float r, g, b; //color

void setup() {
  size(1000, 600);

  x = 10;
  y = height/2+15;
  xspeed = 5;
  r = random(0, 255);
  g = random(0, 255);
  b = random(0, 255);
}
void draw() {
  background(134, 218, 255); //light blue
  randomSeed(0);
  // background objects
  static_background();
  // draw car
  car(x, y, r, g, b);
  //update car's position
  x += xspeed;
  if (x >= width) {
    xspeed = -1*xspeed;
    x = width;
    y = height/2+65;
  } else if (x < -50) {
    xspeed = -1*xspeed;
    x = -50;
    y = height/2+15;
  }
}
// -- DRAWING FUNCTIONS
void car(float x, float y, float r, float g, float b) {//draws a car at position (x, y) with color (r, g, b)
  ellipseMode(CENTER);
  rectMode(CORNER);
  noStroke();
  fill(r, g, b);
  rect(x, y, 50, 15);
  rect(x+10, y-10, 30, 10);
  fill(0);
  ellipse(x+10, y+15, 15, 15);
  ellipse(x+40, y+15, 15, 15);
}
void dash(int x, int y) {
  noStroke();
  fill(230, 230, 0);
  quad(x, y, x+50, y, x+55, y-3, x+5, y-3);
}
void bridge_support(int x) {

  fill(100);
  rect(x, height/2+160, 50, height);
  fill(75);
  rect(x+50, height/2+160, 15, height);
}
void static_background() {
  noStroke();
  fill(0, 175, 225);
  rect(0, height/2-40, width, height); //water in background
  fill(50);
  rect(0, height/2, width, 100); //highway aspahlt
  fill(100);
  rect(0, height/2-10, width, 10); //sidewalls of highway
  rect(0, height/2+100, width, 10);
  fill(150);
  rect(0, height/2+110, width, 50); //side of bridge
  bridge_support(150);
  bridge_support(100);
  bridge_support(450);
  bridge_support(400);
  bridge_support(750);
  bridge_support(700);
  for (int x = 0; x <= width; x+= 60) { //deaws a line of dashes in the middle of the highway
    dash(x, height/2+50);
  }
}
