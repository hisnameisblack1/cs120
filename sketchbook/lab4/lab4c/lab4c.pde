//Henry Wrede Black


float cx;
float cy;
float t;
float R;
float r;
float a;
float x;
float y;

void setup(){
  size(400, 400);
  background(255); //white
  
  cx = width/2;
  cy = height/2;
  t = 0;
  R = 140;
  r = 20;
  a = 3;
  
}

void draw(){
  ellipseMode(CENTER);
  
  x = (R-r)*cos(t) + a*r*cos(t*(R-r)/r) + cx; //parametric equation for x pos
  y = (R-r)*sin(t) - a*r*sin(t*(R-r)/r) + cy; //parametric equation for y pos
  
  noStroke();
  fill(255, 0, 0); //red
  ellipse(x, y, 10, 10);
  
  t += 0.01;
}

void mousePressed(){
  background(255); //resets background to white
}
