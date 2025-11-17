//Henry Wrede Black
//Motion tests

float x;
float xspeed;

void setup(){
  size(1000, 400);
  
  x = width/2;
  xspeed = 0;
}

void draw() {
  ellipseMode(CENTER);
  background(255);
  
  fill(255, 0, 0);
  ellipse(x, height/2, 50, 50);
  
  x = x + xspeed;
  xspeed = xspeed + random(-.5, .5);
  
}
