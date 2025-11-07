//Henry Wrede Black
//block star quilt

void setup() {
  size(550, 550);
}
void draw() {
  background(255);
  for (int y = 0, blue = 55; y+50 <= height; y += 50, blue += 25) {
    for (int x = 0, red = 255; x+50 <= width; x += 50, red += -25) {
      rectMode(CORNER);
      fill(red, 0, blue);
      rect(x, y, 50, 50);
    }
  }
  for (int y = 25; y <= height; y += 50) {
    for (int x = 25; x <= width; x += 50) {
      rectMode(CENTER);
      fill(255);
      rect(x, y, 25, 25);
    }
  }
  for (int y = 25, x = 25; y <= height && x <= width; y += 50, x += 50) {
    fill(0);
    rect(x, y, 25, 25);
  }
  for (int y = height-25, x = 25; y <= height && x <= width; y += -50, x += 50) {
    fill(0);
    rect(x, y, 25, 25);
  }
  for (int y = 0; y <= height; y += 100) {
    for (int x = 50; x <= width; x += 100) {
      fill(255);
      quad(x-25, y, x, y-25, x+25, y, x, y+25);
      quad(x-75, y+50, x-50, y+25, x-25, y+50, x-50, y+75);
    }
  }
}
