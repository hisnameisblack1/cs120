// fractal clouds for use in capstone project

void setup() {
  size(800, 500);
}

void draw() {
  background(0, 0, 200);
  randomSeed(0);


  drawClouds(0, 0, width, 10, 255, 75, 10, 255);


  drawTerrain(0, height*0.75, width, height*0.75, 50, 0, 0, 0);
}

// drawing function for fractal clouds
// (x,y) determines position, (s) determines width and height of rectangles
// (c1), (c2), (c3), (c4) represent the color values at each corner of the rectangle
// (maxd) is maximum displacement, which affects the level of contrast in the clouds
void drawClouds(float x, float y, float s, float c1, float c2, float c3, float c4, float maxd) {
  if (s < 0.75) {
    noStroke();
    float c = (c1+c2+c3+c4)/4;
    fill(c, c, 255);
    rect(x, y, s, s);
  } else {
    {
      float d = random(-maxd, maxd);
      drawClouds(x, y, s/2, c1, (c1+c2)/2, ((c1+c2+c3+c4)/4)+d, (c1+c4)/2, maxd/2);             // top left rect
      drawClouds(x+(s/2), y, s/2, (c1+c2)/2, c2, (c2+c3)/2, ((c1+c2+c3+c4)/4)+d, maxd/2);       // top right rect
      drawClouds(x+(s/2), y+(s/2), s/2, ((c1+c2+c3+c4)/4)+d, (c2+c3)/2, c3, (c3+c4)/2, maxd/2); // bottom right rect
      drawClouds(x, y+(s/2), s/2, (c1+c4)/2, ((c1+c2+c3+c4)/4)+d, (c3+c4)/2, c4, maxd/2);       // bottom left rect
    }
  }
}

// drawing function for terrain elements using fractals
//  (x1, y1), (x2, y2) specify the endpoints for the midpoint displacement math
//  (maxd) is the maximum displacement, which controls the "jaggedness" of the terrain
//  (r), (g), and (b) control the color of the resulting terrain
void drawTerrain(float x1, float y1, float x2, float y2, float maxd, int r, int g, int b) {
  if (dist(x1, y1, x2, y2) < 25) {
    stroke(r, g, b);
    fill(r, g, b);
    quad(x1, y1, x2, y2, x2, height, x1, height);
  } else {
    {
      float d = random(-maxd, maxd);
      drawTerrain(x1, y1, (x1+x2)/2, (y1+y2)/2+d, maxd/2, r, g, b);
      drawTerrain((x1+x2)/2, (y1+y2)/2+d, x2, y2, maxd/2, r, g, b);
    }
  }
}
