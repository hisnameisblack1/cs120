//Henry Wrede Black
//three-circle pattern where the middle circle grows in size

//CORRECTIONS -- reduced # of variables, left and right circles are now calc their x pos in terms of the "diam" variable

float diam; //diameter of the center circle

void setup() {
  size(400, 400);
  diam = 1; //initializes the variable for the center circle
}

void draw() {
  ellipseMode(CENTER);
  background(255); //white

  //center circle
  fill(255, 0, 0); //red
  ellipse(width/2, height/2, diam, diam); //center circle

  ellipse((width/2)+(diam/2)+15, height/2, 30, 30); //right circle
  ellipse((width/2)-(diam/2)-15, height/2, 30, 30); //left circle

  //animation
  diam = diam + 1;
}
