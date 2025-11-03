//Henry Wrede Black
/* 
An ellipse that starts at the bottom of the window and 
moves upward whenever the mouse is moving, when mouse is clicked
ellipse will no longer move.
*/

int y;
boolean stopEllipse;

void setup() {
  size(200, 800);
  y = height;
}
void draw() {
  background(255);
  //draws ball
  fill(255, 0, 0);
  ellipse(width/2, y, 30, 30);
  //when does the ellipses position update?
  if (mouseX != pmouseX && mouseY != pmouseY && !stopEllipse) { //only true if stopEllipse is false
    y += -10; //ellipse moves up
  } else { 
    y += 0; //ellipse doesn't move
  }
  if (y <= 0) {
    y = height;
  }
}
//when mouse is pressed, stopEllipse becomes true and ball no longer moves
void mousePressed() {
  stopEllipse = true;
  if (stopEllipse) {
    y += 0;
  }
}
