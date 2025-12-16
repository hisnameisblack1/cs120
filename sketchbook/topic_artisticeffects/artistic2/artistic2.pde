// Henry Wrede Black
// Artistic effect 2: pencil sketch

PImage img;

void setup() {
  size(750, 750);
  noSmooth();

  // load image
  img = loadImage("seaturtle.jpg");
}
void draw() {
  background(0);
  randomSeed(0);

  drawPencilSketch(img, 25, 25, width, 50, 45, 10000);
}
// pencil sketch drawing function
// (src) - source image
// (x, y) - position of image
// (s) - size of drawing area
// (len), (a), (num) - lengt, angle (in degrees), and number of lines to draw
void drawPencilSketch(PImage src, int x, int y, int s, float len, float a, float num) {
  // load pixels of source image
  src.loadPixels();

  // draw lines
  for (float xL = x, yL = y, count = 0; count <= num; xL = random(x, x+s), yL = random(y, y+s), count++) {
    // compute pixel colors
    int row = (x+int(xL))*img.width/s;
    int col = (y+int(yL))*img.height/s;
    int loc = constrain(row*src.width+col, 0, width);
    // compute r, g, b
    float r = red(src.pixels[loc]);
    float g = green(src.pixels[loc]);
    float b = blue(src.pixels[loc]);
    // set the pixel's color
    src.pixels[loc] = color(r, g, b);

    stroke(r, g, b);

    float w = len*cos(radians(a));        // width spanned by line
    float h = len*sin(radians(a));        // height spanned by line
    line(xL-w/2, yL-h/2, xL+w/2, yL+h/2);
  }
}
