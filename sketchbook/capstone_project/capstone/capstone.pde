// Henry Wrede Black
// CPSC 120 Capstone Project
//    Duck-Hunt Inspired Interactive Animation

void setup() {
  size(1500, 800);
}
void draw() {
  randomSeed(0);
  background(100, 150, 200);

  // elements in the foreground of the sketch
  front_grass();
  drawTerrain(0, height*0.85, width, height*0.85, 20, 150, 100, 15);
}
// -- DRAWING FUNCTIONS
// drawing function for the grass
void front_grass() {
  for (float x = 0, count = 0; count < 3000; x+= 0.5, count++) {
    stroke(0, random(150, 225), 50);
    strokeWeight(random(1, 5));
    line(x, height*0.9, x+random(-10, 10), height*0.9-random(50, 175));
  }
}
// drawing function for terrain elements using fractals
//  (x1, y1), (x2, y2) specify the endpoints for the midpoint displacement algorithm
//  (maxd) is the maximum displacement, which controls the "jaggedness" of the terrain
//  (r), (g), and (b) control the color of the resulting terrain
void drawTerrain(float x1, float y1, float x2, float y2, float maxd, int r, int g, int b) {
  if (dist(x1, y1, x2, y2) < 5) {
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
// drawing function for the tree
void tree(){
  // tree for the background, either an L-system (complicated), or a composite shape using fat lines for wood parts and whatever looks good for leafy bits
}

/* 
NEED TO ADD
- clouds
- rain
- lightning
- tree
    - could be fractal tree or composite shape
- bush/rock
    - rock could be interesting if I use fractals to get some cool surface detail
- variety in front terrain, rocks and small shrubs
- shooting mechanic
    - crosshair linked to mouse position
    - "bullet"
- boid ducks
    - draw out (or use png image???)
    - behaviour first 
    - implement shoot-down mechanic later, (particle system spatter effect or is that too much?)
- dog
    - draw out
    - pop-up mechanic
*/
