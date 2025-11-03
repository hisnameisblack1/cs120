//Henry Wrede Black
/* A small ellipse starts in the center of the drawing window, moving right.
It changes direction (from right to down to left to up to right) when
the mouse is clicked and/or it reaches the edge of the window */

//position variables
int x;
int y;
//state variables
int direction;

void setup() {
  size(400, 400);
  x = width/2; //sets starting value (x,y) for the ellipse
  y = height/2;
  direction = 1;
  
}
void draw() {
  background(255);
  //draw red ball
  fill(255, 0, 0);
  ellipse(x, y, 30, 30);
  //initializes/defines state variable
  if (direction == 1) { //moves right
    x += 1; //increases
    y += 0; //doesn't change
  }
  if (direction == 2) { //moves left
    x += -1; //decreases
    y += 0; //doesnt change
  }
  if (direction == 3) { //moves down
    x += 0; //doesn't change
    y += 1; //increases
  }
  if (direction == 4) { //moves up
    x += 0; //doesn't change
    y += -1; //decreases
  }
  //what direction does the ellipse move?
  if (direction == 1 && x >= width-15) {
    direction = 3;
  } else if (direction == 3 && y >= height-15) {
    direction = 2;
  } else if (direction == 2 && x <= 15) {
    direction = 4;
  } else if (direction == 4 && y <= 15) {
    direction = 1;
  }
}
//each time mouse is clicked, direction of ellipse cycles through right-down-left-up
void mouseClicked() {
  if (direction == 1) {
    direction = 3;
  } else if (direction == 3) {
    direction = 2;
  } else if (direction == 2) {
    direction = 4;
  } else if (direction == 4) {
    direction = 1;
  }
}
