//testing perlin noise

float t;
float x;

void setup(){
  size(1000, 800);
  background(255);
  
  x = 0;
  t = 0;
}

void draw(){
  float y = map(noise(t), 0, 1, 0, 800);
  
  point(x, y);
  
  frameRate(1000);
  t += 100;
  x += .01;
}                
