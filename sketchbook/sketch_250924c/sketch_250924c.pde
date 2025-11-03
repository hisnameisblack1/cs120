//Henry Wrede Black

float t;

void setup(){
  size(400, 400);
  
}

void draw(){
  ellipseMode(CENTER);
  background(255);
  
  float x = 300 + 50*cos(t);
  float y = 100 + 50*sin(t);
  
  fill(255, 0, 0);
  ellipse(x, y, 10, 10);
  
  t += 0.01;
}
