// Henry Wrede Black, Joey Burvis
// image where the green and blue color components of the color are swapped

PImage img, filtered;

void setup() {
  size(500, 500);

  img = loadImage("uluru-sunset.jpg");

  filtered = greenblue_swap(img);
}
void draw() {
  background(0);

  image(filtered, 0, 0, width, height);
}

PImage greenblue_swap( PImage src) {
  // create blank image
  PImage dst = createImage(src.width, src.height, RGB);

  src.loadPixels();

  for ( int row = 0; row < dst.height; row++) {
    for ( int col = 0; col < dst.width; col++) {
      int loc = row*dst.width+col;

      float r = red(src.pixels[loc]);
      float g = blue(src.pixels[loc]);
      float b = green(src.pixels[loc]);

      dst.pixels[loc] = color(r, g, b);
    }
  }
  dst.updatePixels();

  return dst;
}
