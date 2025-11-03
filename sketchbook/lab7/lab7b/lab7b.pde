//Henry Wrede Black
//single rail fence block built with loops and drawing functions

void setup() {
  size(400, 400);
  background(255);
}
void draw() {
  hsp(width/2, 0);
  hsp(0, height/2);
  vsp(0, 0);
  vsp(width/2, height/2);
}
//places horizontal stripe pattern at position (x,y)
void hsp(int x, int y) {
  rectMode(CORNER);
  //yH is used to represent the change in y over each loop, g and b represent green and blue
  for (int yH = 0, g = 50, b = 200; yH < height/2; yH += height/8, g += 50, b += -50) {
    fill(0, g, b);
    rect(x, y+yH, width/2, height/8);
  }
}
//places vertical stripe pattern at positon (x,y)
void vsp(int x, int y){
  rectMode(CORNER);
  //xV is used to represent the change in x over each loop, g and b represent green and blue
  for (int xV = 0, g = 50, b = 200; xV < width/2; xV += width/8, g += 50, b += -50){
    fill(0, g, b);
    rect(x+xV, y, width/8, height/2);
  }
}
