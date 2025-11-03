//Henry Wrede Black
//small circle that wanders around a blue box

float t1;
float t2;

void setup() {
  size(400, 400);

  t1 = 0;
  t2 = 1;
}

void draw() {
  background(255);

  float x = map(noise(t1), 0, 1, 50, 350);
  float y = map(noise(t2), 0, 1, 150, 250);

  fill(255, 0, 0);
  ellipse(x, y, 25, 25);

  t1 += 0.01;
  t2 += 0.01;
}
