//testing an example from the reading (4.6-4.7) where random variables are used to create a sketch of randomly placed circles with random colors

float r;
float g;
float b;
float a;

float diam;
float x;
float y;
float z;
float k;

void setup() {
  size(500, 500);
  background(255);
}

void draw() {
  r = random(255);
  g = random(255);
  b = random(255);
  a = random(255);
  
  diam = random(30);
  x = random(width);
  y = random(height);
  z = 0;
  k = 0;
  
  z = z + random(-10, 10);
  k = k + random(-10, 10);


noStroke();
fill(r, g, b, a);
ellipse(x+z, y+k, diam, diam);

println();

}
