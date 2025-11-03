//Henry Wrede Black
//quilt made from blocks made in lab7 exercises a, b, c

void setup() {
  size(400, 320);
}
void draw() {
  background(0);

  geese(0, 0); //top strip of geese
  geese(0, height-40); //bottom strip of geese

  fence(0, 40); //top fence strip
  fence(0, height-120); //bottom fence strip

  logs(0, 120); //center row of log cabins
}
// -- DRAWING VARIABLES
//draws line of "geese" at point (xG, yG) to the edge of the window
void geese(int x, int y) {
  //xPos represents the change in x each loop
  for (int xPos = 0; xPos <= width-20; xPos += 20) {
    fill(0, 0, 200);
    triangle(x + xPos, y, x + xPos, y+40, x+20 + xPos, y+20);
  }
}
//draws line of single rail fence blocks at position (x, y)
void fence(int x, int y) {
  //xPos represents the change in x each loop
  for (int xPos = 0; xPos <= width-80; xPos += 80) {
    hsp(x+40 + xPos, y, 80, 80);
    hsp(x + xPos, y+40, 80, 80);
    vsp(x + xPos, y, 80, 80);
    vsp(x+40 + xPos, y+40, 80, 80);
  }
}
//draws the horizontal fence blocks at position (x, y) with width w and height h
void hsp(int x, int y, int w, int h) {
  rectMode(CORNER);
  //yH represents the change in y each loop, and g and b represent green and blue
  for (int yH = 0, g = 50, b = 200; yH < h/2; yH += 10, g += 50, b += -50) {
    fill(0, g, b);
    rect(x, y+yH, w/2, h/8);
  }
}
//draws the vertical fence blocks at position (x, y) with width w and height h
void vsp(int x, int y, int w, int h) {
  rectMode(CORNER);
  //xV represents the change in x each loop, and g and b represent green and blue
  for (int xV = 0, g = 50, b = 200; xV < w/2; xV += 10, g += 50, b += -50) {
    fill(0, g, b);
    rect(x+xV, y, w/8, h/2);
  }
}
//draws a row of log cabin blocks at position (x, y)
void logs(int x, int y) {
  //xPos represents the change in x each loop
  for (int xPos = 0; xPos <= width-80; xPos += 80) {
    singleLog(x + xPos, y);
  }
}
//draws a single log cabin block at position (x, y)
void singleLog(int x, int y) {
  rectMode(CORNER);
   //xPos and yPos represent the changes in x and y each loop, s represents the diminishing size of the logs
  for (int xPos = 0, yPos = 0, s = 80; xPos < 30; xPos += 10, yPos += 10, s += -20) {
    fill(255, 225, 50);
    rect(x+70 + -xPos, y + yPos, 10, s); //right
    fill(200, 0, 125);
    rect(x + xPos, y+70 + -yPos, s, 10); //bottom
    fill(255, 50, 100);
    rect(x + xPos, y + yPos, 10, s); //left
    fill(255, 125, 50);
    rect(x + xPos, y + yPos, s, 10);
  }
}
