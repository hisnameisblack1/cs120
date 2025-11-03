//Henry Wrede Black
//rolling wheel

//CORRECTIONS -- adjusts to window size, reduced # of variables

float x; //x pos
float a; //angle of wheel "spokes"

void setup() {
  size(800, 200);

  //Initialize variables
  x = 50;
  a = radians(0); //starting angle is 0
}

void draw() {
  background(255);
  ellipseMode(CENTER);

  //Circle
  stroke(0);
  fill(255); //white
  ellipse(x, height-50, 100, 100);

  //Wheel "spokes"
  noStroke();
  fill(255, 0, 0); //red
  arc(x, height-50, 100, 100, a, a + radians(90));
  arc(x, height-50, 100, 100, a + radians(180), a + radians(270));
  
  a = a + radians(1); //changes the angle of the arcs at a constant rate of angle "a"
  x = x + radians(1) * 50; //changes x position at a rate of "a" (angle change each frame) multiplied by the radius "r"

}

//Interaction
void mouseClicked() {
  x = 50;
  a = radians(0);
}
