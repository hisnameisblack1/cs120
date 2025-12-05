// Henry Wrede Black, Joey Burvis
// black-to-red color gradient

PImage img;

void setup() {
  size(500, 500);

  img = generateGradient(width, height);
}
void draw() {
  background(0);

  image(img, 0, 0);
}

PImage generateGradient( int w, int h) {
  PImage dst = createImage(w, h, RGB);

  for ( int row = 0; row < dst.height; row++) {
    for ( int col = 0; col < dst.width; col++) {
      int loc = row*dst.width+col;

      float r = map(col, 0, width, 0, 255);

      dst.pixels[loc] = color(r, 0, 0);
    }
  }
  dst.updatePixels();
  return dst;
}
