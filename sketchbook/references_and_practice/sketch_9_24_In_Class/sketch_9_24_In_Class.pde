//henry in-class testing

float t1;
float t2;




void setup() {
  size(400, 400);

  t1 = 0;
  t2 = 1;
}

void draw() {
  ellipseMode(CENTER);
  background(255);
  {

    float cx = 200;
    float cy = 200;
    float r = 50;

    float x = cx + r*cos(t1);
    float y = cy + r*sin(t1);

    float xchange = noise(t1);
    float ychange = noise(t2);
    fill(255, 0, 0);
    ellipse(x + xchange, y + ychange, 30, 30);
  }
  t1 += 0.01;
  t2 += 0.01;
}
