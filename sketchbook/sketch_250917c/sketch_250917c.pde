//Henry Wrede Black, Joey Burvis
//circle goes from black to red

float r;

void setup() {
  size(400, 400);
  r = 0;
}

void draw() {
  background(255);
  ellipseMode(CENTER);
  
  noStroke();
  fill(r, 0, 0);
  
  ellipse(width/2, height/2, 100, 100);
  
  r = r + 1;
  
}
