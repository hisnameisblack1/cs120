//Henry Wrede Black
//Circle copying around screen, dependent on mouse position, circle is partially transparent

void setup() {
  size(400,400);
  background(255);
}

void draw() {
  noStroke();
  fill(255,0,0,75);
  ellipse(mouseX, mouseY,20,20);
}
