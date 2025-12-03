// Henry Wrede Black, Joey Burvis

PImage img;      // the image to display

void setup () {
  size(640, 480);
  background(0);

  // load image
  img = loadImage("dragon.jpg");

  // load image pixels so they can be accessed
  img.loadPixels();
}

void draw () {

  imageMode(CORNER);

  // draw image - takes up whole window
  //image(img, 25, 25, width-50, height-50);

  // draw colored spot following the mouse - color is taken from the image pixel
  //  under the mouse
  {
    int random_X = int(random(50, width-50)); // store random point within bounds of image
    int random_Y = int(random(50, height-50));
    // (row,col) corresponding to the mouse's location in the image
    //   row = (y-iy)*img.height/dh, col = (x-ix)*img.width/dw
    //  (x,y) is the mouse position
    //  image's corner (ix,iy) is at (25,25),
    //  image's displayed size dw x dh is width x height
    int row = (random_Y-(50))*img.height/(height-50);
    int col = (random_X-(50))*img.width/(width-50);
    // location in pixels array corresponding to (row,col)
    int loc = row*img.width+col;

    fill(img.pixels[loc]);
    stroke(0);
    ellipse(random_X, random_Y, 10, 10); // draw ellipse
  }
}
