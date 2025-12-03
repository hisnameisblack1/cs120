// Henry Wrede Black, Joey Burvis

PImage img;      // the image to display

void setup () {
  size(640, 480);

  // load image
  img = loadImage("dragon.jpg");

  // load image pixels so they can be accessed
  img.loadPixels();
}

void draw () {
  background(0);
  imageMode(CORNER);

  // draw image - takes up whole window
  image(img, 25, 25, width-50, height-50);

  // draw colored spot following the mouse - color is taken from the image pixel
  //  under the mouse
  {
    if (mouseX >= 25 && mouseX <= 25+width-50 && mouseY >= 25 && mouseY <= 25+height-50) {
      // (row,col) corresponding to the mouse's location in the image
      //   row = (y-iy)*img.height/dh, col = (x-ix)*img.width/dw
      //  (x,y) is the mouse position
      //  image's corner (ix,iy) is at (0,0),
      //  image's displayed size dw x dh is width x height
      int row = (mouseY-25)*img.height/(height-50);
      int col = (mouseX-25)*img.width/(width-50);
      // location in pixels array corresponding to (row,col)
      int loc = row*img.width+col;

      fill(red(img.pixels[loc]), 0, 0);
      stroke(0);
      ellipse(mouseX, mouseY, 40, 40);
    }
  }
}
