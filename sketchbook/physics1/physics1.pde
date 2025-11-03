//Henry Wrede Black
//four bouncing balls
// -- DECLARING VARIABLES
//position and speed variables of red ball
float xR; 
float yR;
float xspeedR;
float yspeedR;
//position and speed variables of blue ball
float xB;
float yB;
float xspeedB;
float yspeedB;
//position and speed variables of yellow ball
float xY;
float yY;
float xspeedY;
float yspeedY;
//position and speed variables of purple ball
float xP;
float yP;
float xspeedP;
float yspeedP;
//Physics variables
float g; //gravity
float air; //air resistance or "k"
float damp; //force impact transfer

void setup() {
  size(500, 500);
  //red initial values
  xR = 10;
  yR = 10;
  xspeedR = 1;
  yspeedR = 0;
  //blue initial values
  xB = 10;
  yB = 10;
  xspeedB = 1;
  yspeedB = 0;
  //yellow initial values
  xY = 10;
  yY = 10;
  xspeedY = 1;
  yspeedY = 0;
  //purple initial values
  xP = 10;
  yP = 10;
  xspeedP = 1;
  yspeedP = 0;
  //physics values
  air = 0.001;
  damp = 0.95;
  g = 0.04;
}
void draw() {
  background(255); //white
  ellipseMode(CENTER);
  //red ball - subject to gravity
  {
    fill(255, 0, 0); //red
    ellipse(xR, yR, 20, 20);
    xR += xspeedR;
    yR += yspeedR;
    yspeedR += g;
    if (xR >= width-10) { //circle bounces when it hits the sides of the window
      xspeedR = -1*xspeedR;
      xR = width-11;
    } else if (xR < 10) {
      xspeedR = -1*xspeedR;
      xR = 10;
    }
    if (yR >= height-10) { //circle bounces when it hits the bottom
      yspeedR = -1*yspeedR;
      yR = height-11;
    }
  }
  //yellow ball - subject to air resistance and gravity
  {
    fill(255, 255, 0); //yellow
    ellipse(xY, yY, 20, 20);
    xY += xspeedY;
    yY += yspeedY;
    xspeedY += -air*xspeedY;
    yspeedY += g + -air*yspeedY;
    if (xY >= width-10) {
      xspeedY = -1*xspeedY;
      xY = width-11;
    } else if (xY < 10) {
      xspeedY = -1*xspeedY;
      xY = 10;
    }
    if (yY >= height-10) {
      yspeedY = -1*yspeedY;
      yY = height-11;
    }
  }
  //blue ball - subject to damping and gravity
  {
    fill(0, 0, 255); //blue
    ellipse(xB, yB, 20, 20);
    xB += xspeedB;
    yB += yspeedB;
    yspeedB += g;
    if (xB >= width-10) {
      xspeedB = -damp*xspeedB;
      xB = width-11;
    } else if (xB < 10) {
      xspeedB = -damp*xspeedB;
      xB = 10;
    }
    if (yB >= height-10) {
      yspeedB = -damp*yspeedB;
      yB = height-11;
    }
  }
  //purple ball - subject to air resistance, damping, and gravity
  {
    fill(255, 0, 255);
    ellipse(xP, yP, 20, 20);
    xP += xspeedP;
    yP += yspeedP;
    xspeedP += -air*xspeedP;
    yspeedP += g + -air*yspeedP;
    if (xP >= width-10) {
      xspeedP = -damp*xspeedP;
      xP = width-11;
    } else if (xP < 10) {
      xspeedP = -damp*xspeedP;
      xP = 10;
    }
    if (yP >= height-10) {
      yspeedP = -damp*yspeedP;
      yP = height-11;
    }
  }
}
// -- INTERACTION
void mouseClicked() { //clicking the mouse resets the values for all balls
  //reset values for red ball
  xR = 10;
  yR = 10;
  xspeedR = 1;
  yspeedR = 0;
  //reset values for blue ball
  xB = 10;
  yB = 10;
  xspeedB = 1;
  yspeedB = 0;
  //reset values for yellow ball
  xY = 10;
  yY = 10;
  xspeedY = 1;
  yspeedY = 0;
  //reset values for purple ball
  xP = 10;
  yP = 10;
  xspeedP = 1;
  yspeedP = 0;
}
