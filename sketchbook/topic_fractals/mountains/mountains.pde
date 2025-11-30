// Henry Wrede Black
// fractal mountain range

void setup() {
  size(1000, 500);
}
void draw() {
  randomSeed(0);
  background(255);
  drawTerrain(0, height/2, width, height/2, 175);
}

void drawTerrain(float x1, float y1, float x2, float y2, float maxd) {
  if (dist(x1, y1, x2, y2) < 5) {
    fill(0);
    quad(x1, y1, x2, y2, x2, height, x1, height);
  } else {
    {
      float d = random(-maxd, maxd);
      drawTerrain(x1, y1, (x1+x2)/2, (y1+y2)/2+d, maxd/2);
      drawTerrain((x1+x2)/2, (y1+y2)/2+d, x2, y2, maxd/2);
    }
  }
}
