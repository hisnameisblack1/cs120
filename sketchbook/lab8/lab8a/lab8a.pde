//Henry Wrede Black
//strip of 16 flying geese with varying color pattern

void setup() {
  size(800, 100);
  background(255);
}
void draw() {
  for (int x = 0, count = 0; count <= 16; x += height/2, count ++) {
    if (count < 4) {
      fill(0, 0, 200);
    } else if (count < 8) {
      fill(75, 0, 150);
    } else if (count < 12) {
      fill(150, 0, 75);
    } else if (count < 16) {
      fill(225, 0, 75);
    }
    triangle(x, 0, x, height, x+height/2, height/2);
  }
}
