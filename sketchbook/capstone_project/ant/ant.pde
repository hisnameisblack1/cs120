// ant for capstone

void setup(){
  size(500, 500);
}

void draw(){
  background(255);
  drawPede(width/2, height/2);
}

// drawing function for a millipede
// (x, y) determines position
void drawPede(float x, float y){
  for (float xLeg = x-50; xLeg <= x+50; xLeg += 4){
    stroke(95, 95, 95);
    strokeWeight(3);
    line(xLeg, y, xLeg, y+7);
  }
   stroke(178, 0, 0);
  strokeWeight(10);
  line(x-50, y, x+50, y);
}
