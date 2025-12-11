// footsteps for use in capstone project

void setup() {
  size(500, 200);
}
void draw() {
  background(255);
  drawFootsteps(0, height/2);
}

// drawing function for footprints that go across screen
//  position (x, y)
void drawFootsteps(float x, float y) {
  ellipseMode(CENTER);
  rectMode(CENTER);
  noStroke();

  for (int x_change = 0, a = 255; x <= width; x += 115, a += -10) {
    fill(0, 0, 0, a);
    // left footprint
    // heel of foot
    rect(x + x_change, y, 10, 20);
    ellipse(x-5 + x_change, y, 20, 20);
    // front part of foot
    rect(x+25 + x_change, y, 30, 20);
    ellipse(x+40 + x_change, y, 20, 20);
    // right footprint
    // heel of foot
    rect(x+50 + x_change, y+30, 10, 20);
    ellipse(x+45 + x_change, y+30, 20, 20);
    // front part of foot
    rect(x+75 + x_change, y+30, 30, 20);
    ellipse(x+90 + x_change, y+30, 20, 20);
  }
}
