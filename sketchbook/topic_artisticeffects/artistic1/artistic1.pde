// Henry Wrede Black
// Artistic effect 1: pixellate

PImage img;

void setup() {
  size(500, 665);
  noSmooth();

  // load image
  img = loadImage("seaturtle.jpg");
}
void draw() {
  background(0);
  randomSeed(0);

  drawPixellate(img, 25, 25, 10);
}
// pixellate drawing function
// (src) - source image
// (x, y) - position
// (s) - rectangle size
void drawPixellate(PImage src, int x, int y, float s) {
  // load pixels of source image
  src.loadPixels();

  // compute pixel colors
  for ( int row = x; row < src.height; row += s) {
    for (int col = y; col < src.width; col += s) {
      int loc = row*src.width+col;
      // compute r, g, b
      float r = red(src.pixels[loc]);
      float g = green(src.pixels[loc]);
      float b = blue(src.pixels[loc]);
      // set the pixel's color
      src.pixels[loc] = color(r, g, b);
      // draw squares
      rectMode(CENTER);
      noStroke();
      fill(r, g, b);
      rect(row, col, s, s);
    }
  }
}
