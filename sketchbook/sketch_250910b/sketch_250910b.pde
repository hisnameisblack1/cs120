//Henry Wrede Black
//3-ellipse copying around the screen, following mouse pos, mouseclick clears background

void setup() {
  size(400, 400);
  background(255); // white
}
void draw() {

  ellipseMode(CENTER);

  stroke(0);
  fill(255, 0, 0);

  //circles
  ellipse(mouseX, mouseY, 50, 50);
  ellipse(mouseX-40, mouseY, 30, 30);
  ellipse(mouseX+40, mouseY, 30, 30);
}
//input for clearing background
void mouseClicked () {
  background(255); // white
}
