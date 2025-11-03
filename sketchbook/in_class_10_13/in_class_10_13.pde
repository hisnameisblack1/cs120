//Henry Wrede Black
//blue box that turns red when the mouse is over it

int x;
int y;

void setup(){
  size(400, 400);
  
  x = width/2;
  y = height/2;
}
void draw(){
  background(255);
  rectMode(CENTER);
  
  if (mouseX <= x + 50 && mouseX >= x -50 && mouseY <= y + 50 && mouseY >= y - 50){
    fill(255, 0, 0);
  } else {
    fill(0, 0, 255);
  }
  rect(x, y, 100, 100);
}
