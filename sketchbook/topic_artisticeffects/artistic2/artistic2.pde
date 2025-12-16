// Henry Wrede Black
// Artistic effect 2: pencil sketch

PImage img;

void setup() {
  size(500, 500);
  noSmooth();

  // load image
  img = loadImage("seaturtle.jpg");
}
void draw() {
  background(0);
  randomSeed(0);

  drawPencilSketch(img, 25, 25, width-50, 5, 30, 100000, 5);
}
// pencil sketch drawing function
// (src) - source image
// (x, y) - position of image
// (s) - size of drawing area
// (len), (a), (num) - length of lines, angle (in degrees)of lines, and number of lines to draw
// (weight) - stroke width of lines
void drawPencilSketch(PImage src, int x, int y, int s, float len, float a, float num, int weight) {
  // load pixels of source image
  src.loadPixels();

  // draw lines
  for (float xL = x, yL = y, count = 0; count <= num; xL = random(x, x+s), yL = random(y, y+s), count++) {
    // (row, col) corresponding to the random position of a line
    int row = (int(xL)-x)*img.height/s;
    int col = (int(yL)-y)*img.width/s;
    // location in pixels array corresponding to (row, col)
    int loc = row*src.width+col;
    // compute r, g, b
    float r = red(src.pixels[loc]);
    float g = green(src.pixels[loc]);
    float b = blue(src.pixels[loc]);
    // set the pixel's color
    src.pixels[loc] = color(r, g, b);

    strokeWeight(weight);
    stroke(r, g, b);
    
    float w = len*cos(radians(a));        // width spanned by line
    float h = len*sin(radians(a));        // height spanned by line
    line(xL-w/2, yL-h/2, xL+w/2, yL+h/2);
  }
}
