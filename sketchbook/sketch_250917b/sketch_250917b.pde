//Henry Wrede Black, Joey Burvis
//circle that fills the drawing window

float diam;

void setup(){
  size(400, 400);
  diam = width;
  
}

void draw() {
  background(255);
  ellipseMode(CENTER);
  
  noStroke();
  fill(0);
  
  ellipse(width/2, height/2, diam, diam);
  
  diam = diam - 1;
  
}
