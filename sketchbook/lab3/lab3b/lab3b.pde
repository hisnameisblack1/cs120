//Henry Wrede Black
//three-circle pattern where the middle circle grows in size

float diam; //diameter of the center circle
float leftx; //x position of the left circle
float rightx; //x position of the right circle

void setup() {
  size(400, 400);
  diam = 1; //initializes the variable for the center circle
}

void draw() {
  ellipseMode(CENTER);
  background(255); //white

  leftx = (width/2)+(diam/2)+15;
  rightx = (width/2)-(diam/2)-15;


  //center circle
  fill(255, 0, 0); //red
  ellipse(width/2, height/2, diam, diam);

  //left and right circles
  ellipse(leftx, height/2, 30, 30);
  ellipse(rightx, height/2, 30, 30);

  //animation
  diam = diam + 1;
}
