//Henry Wrede Black
//Hot air balloon moving along the y-axis based on mouse position

void setup() {
  size(400, 400);
}

void draw() {
  background(0, 255, 255);
  ellipseMode(CENTER);
  rectMode(CENTER);

  //Ropes
  line(100-(25/2), mouseY+75, 70, mouseY); //balloon rope left
  line(100+(25/2), mouseY+75, 130, mouseY); //balloon rope right
  line(100-(25/2), mouseY+100, 75, 375); //rope to ground

  //Balloon
  fill(255, 0, 255);
  ellipse(100, mouseY, 60, 60);

  //Box
  fill(100, 100, 60);
  rect(100, mouseY+75+(25/2), 25, 25);

  //Ground
  rectMode(CORNER);
  fill(0, 255, 0);
  rect(0, 375, 400, 25);
}
