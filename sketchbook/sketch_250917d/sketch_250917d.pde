//Henry Wrede Black, Joey Burvis
//four circles moving in different directions

float x1;
float y1;
float x2;
float y2;
float x3;
float y3;
float x4;
float y4;

float diam;

void setup(){
  size(600, 600);
  x1 = (.25)*width;
  y1 = (.25)*height;
  x2 = (.75)*width;
  y2 = (.25)*height;
  x3 = (.75)*width;
  y3 = (.75)*height;
  x4 = (.25)*width;
  y4 = (.75)*height;
  
  diam = 100;
}

void draw(){
  background(255);
  ellipseMode(CENTER);
  
  fill(255,0,0);
  ellipse(x1, y1, diam, diam);
  ellipse(x2, y2, diam, diam);
  ellipse(x3, y3, diam, diam);
  ellipse(x4, y4, diam, diam);
  
  x1 = x1 + 1;
  y2 = y2 + 1;
  x3 = x3 - 1;
  x4 = x4 + 1;
  y4 = y4 - 1;
  
  
}
