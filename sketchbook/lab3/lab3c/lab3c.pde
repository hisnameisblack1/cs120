//Henry Wrede Black
//rolling wheel


float x; //x pos
float y; //y pos
float diam; //diameter of the circle
float a; //change in angle each frame (RADIANS)
float r; //radius, 1/2 diam
float sa; //start angle - animation variable

void setup() {
  size(800, 200);

  //Initialize variables
  x = 50;
  y = 150;
  diam = 100;
  r = diam/2;
  a = radians(1); //change in angle each frame
  sa = radians(0); //starting angle is 0
}

void draw() {
  background(255);
  ellipseMode(CENTER);

  //Circle
  stroke(0);
  fill(255); //white
  ellipse(x, y, diam, diam);

  //Wheel "spokes"
  noStroke();
  fill(255, 0, 0); //red
  arc(x, y, diam, diam, sa, sa + radians(90));
  arc(x, y, diam, diam, sa + radians(180), sa + radians(270));

  x = x + a * r; //changes x position at a rate of "a" (angle change each frame) multiplied by the radius "r"
  sa = sa + a; //changes the angle of the arcs at a constant rate of angle "a"
}

//Interaction
void mouseClicked() {
  x = 50;
  sa = radians(0);
}
