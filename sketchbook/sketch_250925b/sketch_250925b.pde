//spiral

float theta;
float r;

void setup(){
  size(500, 500);
  background(255);
  
  theta = 0;
  r = 1;
  
}

void draw(){
  ellipseMode(CENTER);
  
  float x = r*cos(theta);
  float y = r*sin(theta);
  
  fill(0);
  ellipse(x+ width/2, y+ height/2, 15, 15);
  
  theta += 0.01;
  r += 0.05;
  
}
  
  
