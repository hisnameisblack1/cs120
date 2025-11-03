//Henry Wrede Black, Joey Burvis
//ellipse ramp using a nested loop
void setup() {
  size(500, 500);
  background(255);
}
void draw() {
  ellipseMode(CENTER);
  for (int x = 25, y = 25; x <= width-25 && y <= height-25; x += 50, y += 50) {
    for (int yPos = 0; yPos <= height-50; yPos += 50) {
      fill(255, 0, 0);
      ellipse(x, y+yPos, 45, 45);
    }
  }
}
