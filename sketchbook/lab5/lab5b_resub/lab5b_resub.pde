//Henry Wrede Black

//second quilt

void setup() {
  size(700, 700);
}

void draw() {
  background(255, 191, 13); //orange

  pattern(150, 150, 200, 225, 25); //top left
  pattern(350, 150, 200, 225, 25); //top middle
  pattern(550, 150, 200, 225, 25); //top right
  pattern(150, 350, 200, 225, 25); //left middle 
  pattern(150, 550, 200, 225, 25); //left bottom
  pattern(550, 350, 200, 225, 25); //right middle
  pattern(550, 550, 200, 225, 25); //right bottom
  pattern(350, 550, 200, 225, 25); //bottom middle
  pattern(width/2, height/2, 400, 191, 13); //bigger center pattern
  pattern(width/2, height/2, 200, 118, 13); //center pattern
}


//draws a quilt pattern
void pattern(float x, float y, float size, int g, int b) {
  fill(255, g, b);
  quad(x-size/2, y, x, y+size/2, x+size/2, y, x, y-size/2);
  fill(255, 118, 13); //darker orange
  triangle(x-size/4, y-size/4, x-size/2, y, x-size/2, y-size/2);
  triangle(x-size/4, y+size/4, x-size/2, y+size/2, x, y+size/2);
  triangle(x+size/4, y+size/4, x+size/2, y, x+size/2, y+size/2);
  triangle(x+size/4, y-size/4, x, y-size/2, x+size/2, y-size/2);
  fill(255, 227, 206); //eggshell white
  triangle(x-size/4, y-size/4, x-size/2, y-size/2, x, y-size/2);
  triangle(x+size/4, y-size/4, x+size/2, y-size/2, x+size/2, y);
  triangle(x+size/4, y+size/4, x+size/2, y+size/2, x, y+size/2);
  triangle(x-size/4, y+size/4, x-size/2, y, x-size/2, y+size/2);
}
