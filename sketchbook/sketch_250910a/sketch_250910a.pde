//Henry Wrede Black
//3-ellipse following mouse position

void setup() {
  size(400,400);
}
void draw() {
background(255); // white

ellipseMode(CENTER);

stroke(0);
fill(255,0,0);

//circles
ellipse(mouseX,mouseY,50,50);
ellipse(mouseX-40,mouseY,30,30);
ellipse(mouseX+40,mouseY,30,30);
}
