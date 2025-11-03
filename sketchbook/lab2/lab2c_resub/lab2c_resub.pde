//Henry Wrede Black
//Circle copying around screen, dependent on mouse position

//CORRECTIONS - clicking the mouse now clears the background

void setup() {
  size(400,400);
  background(255);
}

void draw() {
  noStroke();
  fill(255,0,0);
  ellipse(mouseX, mouseY,20,20);
}

void mousePressed(){
  background(255);
}
