//Henry Black
//bouncing ball and a rectangular obstacle (collision testing)
// -- DECLARING VARIABLES
//position and speed variables of red ball
float xR;
float yR;
float prevxR;
float prevyR;
float xspeedR;
float yspeedR;
//Physics variables
final float G = 0.05; //gravity .... CONSTANT
final float AIR = 0.0025; //air resistance or "k"
final float DAMP = 0.9; //force impact transfer
//collision variables
boolean top;
boolean bottom;
boolean left;
boolean right;
void setup() {
  size(500, 500);
  //red balls initial position and speed
  xR = width/2;
  yR = 10;
  prevxR = xR;
  prevyR = yR;
  xspeedR = random(-20, 20);
  yspeedR = random(0, 20);
}
void draw() {
  background(255);
  ellipseMode(CENTER);
  rectMode(CORNER);
  // -- DRAWING OBJECTS
  //box
  fill(100);
  rect(100, 350, 200, 50);
  //red ball - subject to air resistance, damping, and gravity
  fill(255, 0, 0);
  ellipse(xR, yR, 20, 20);
  prevxR = xR;
  prevyR = yR;
  xR += xspeedR;
  yR += yspeedR;
  xspeedR += -AIR*xspeedR;
  yspeedR += G + -AIR*yspeedR;
  // -- CONDITIONAL STATEMENTS
  //inizialization of boolean variables
  if ((yR+10 >= 350) && (prevyR+10 < 350) && (xR+10 >= 100) && (xR-10 <= 300)) { //top
    top = true;
  } else {
    top = false;
  }
  if ((yR-10 <= 400) && (prevyR-10 > 400) && (xR+10 >= 100) && (xR-10 <= 300)) { //bottom
    bottom = true;
  } else {
    bottom = false;
  }
  if ((xR+10 >= 100) && (prevxR+10 < 100) && (yR+10 >= 350) && (yR-10 <= 400)) { //left side
    left = true;
  } else {
    left = false;
  }
  if ((xR-10 <= 300) && (prevxR-10 > 300) && (yR+10 >= 350) && (yR-10 <= 400)) { //right side
    right = true;
  } else {
    right = false;
  }
  //conditionals to outline collisions
  if (xR >= width-10) {
    xspeedR = -DAMP*xspeedR;
    xR = width-11;
  } else if (xR < 10) {
    xspeedR = -DAMP*xspeedR;
    xR = 11;
  }
  if (yR >= height-10) {
    yspeedR = -DAMP*yspeedR;
    yR = height-11;
  }
  //collision for box
  if (left || right) { //left  and right side
    xspeedR = -(DAMP/2)*xspeedR; //damp value for when the balls bounce off the box are half what it is for the sides of the window
    xR = prevxR;
  }
  if (top || bottom) { //top and bottom
    yspeedR = -(DAMP/2)*yspeedR;
    yR = prevyR;
  }
}
// -- INTERACTION
void mouseClicked() { //clicking the mouse resets the values for all balls
  //reset values for red ball
  xR = width/2;
  yR = 10;
  xspeedR = random(-5, 5);
  yspeedR = random(0, 5);
}
