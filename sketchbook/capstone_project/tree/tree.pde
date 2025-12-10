// tree for capstone project

void setup() {
  size(500, 500);
}

void draw() {
background(255);

drawTree(width/2, height);

}

void drawTree(float x, float y){
  rectMode(CENTER);
  ellipseMode(CENTER);
  noStroke();
  // tree trunk
  fill(193, 94, 0);
  rect(x, y-150, 50, 300); 
  //branches
  stroke(193, 94, 0);
  strokeWeight(10);
  line(x, y-175, x-100, y-225);
  line(x, y-200, x+100, y-275);
  line(x, y-100, x+50, y-200);
  strokeWeight(8);
  line(x-50, y-200, x-35, y-250);
  // leaves
  noStroke();
  fill(0, 203, 0);
  ellipse(x-10, y-375, 200, 200); // big main green
  ellipse(x+75, y-400, 100, 100);
  ellipse(x-80, y-425, 150, 150);
  ellipse(x+50, y-325, 125, 125);
  ellipse(x-100, y-225, 50, 50); // green on left branch
  fill(0, 175, 0); // darker green for green overlays
  ellipse(x-10, y-375, 185, 185); 
  ellipse(x+75, y-400, 85, 85);
  ellipse(x-80, y-425, 135, 135);
  ellipse(x+50, y-325, 110, 110);
  ellipse(x-100, y-225, 40, 40);
}
