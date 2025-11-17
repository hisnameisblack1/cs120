//testing perlin noise

float t;
float c;
float x;

void setup() {
  size(1000, 800);
  background(255);

  x = 0;
  t = 0;
}

void draw() {
  float y = map(noise(t), 0, 1, 0, 800);


  if (float x = width) {
    x = 0;
    y += -1;
    stroke(0);
    fill(c, c, c);
    ellipse(x, y, 2, 2);
  }




  frameRate(1000);
  t += .005;
  x += 1;
}
