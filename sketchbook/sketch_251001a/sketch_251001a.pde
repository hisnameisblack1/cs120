//Henry Wrede Black, Joey Burvis

void setup(){
  size(1000, 600);
}

void draw(){
  background(70);
  snowman(width/2, height-125);
  snowman(width-700, height-135);
  snowman(width-900, height-50);
  snowman(mouseX, mouseY);
}

void snowman(int x, int y){
  ellipseMode(CENTER);
  
  fill(255);
  ellipse(x, y, 250, 250);
  ellipse(x, y-200, 150, 150);
  ellipse(x, y-315, 80, 80);
}
