//Henry Wrede Black
//strip of 16 flying geese with varying color pattern

void setup() {
  size(800, 100);
  background(255);
}
void draw() {
  for (int r = 0, b = 150, x = 0; x < (height/2)*16; r += 100, b += -10) {
    fill(r, 0, b);
    for (int count = 0; count < 4; x += height/2, count ++) {
      triangle(x, 0, x, height, x+height/2, height/2);
    }
  }
}
