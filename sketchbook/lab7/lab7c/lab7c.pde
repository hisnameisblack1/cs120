//Henry Wrede Black
//single log cabin block, drawn with one loop, works with any size window

void setup() {
  size(240, 240);
}
void draw() {
  background(255);
  //important to note that in this loop, x and y represent the changes in the x and y position of the rectangle
  for (int x = 0, y = 0, s = height; x < width/2-20; x += 20, y += 20, s += -40) {
    fill(255, 225, 50); 
    rect((width-20) + -x, y, 20, s); //right
    fill(200, 0, 125);
    rect(x, (height-20) + -y, s, 20); //bottom
    fill(255, 50, 100);
    rect(x, y, 20, s); //left
    fill(255, 125, 50); 
    rect(x, y, s, 20); //top
  }
}
