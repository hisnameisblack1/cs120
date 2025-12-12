//Henry Wrede Black
//tumbling blocks quilt

void setup() {
  size(500, 500);
}
void draw() {
  background(255);
  for (int y = 20; y < height+20; y += 60) {
    for (int x = -20; x <= width+20; x += 40) {
      drawBlock(x, y-20);
      drawBlock(x+20, y+10);
    }
  }
}

void drawBlock(int x, int y) {
  noStroke();
  fill(0, 0, 255);
  quad(x, y, x-20, y-10, x, y-20, x+20, y-10); //top part of block
  fill(0, 0, 150);
  quad(x, y, x, y+20, x-20, y+10, x-20, y-10);
  fill(0);
  quad(x, y, x+20, y-10, x+20, y+10, x, y+20); //right side
}
