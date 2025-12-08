// duck for capstone project

PVector duckpos, duckvel; // position and velocity
float radius, angle; // what the ducks can see
float maxforce, maxspeed; // motion parameters

void setup() {
  size(500, 500);

  // start with random position and velocities
  duckpos = new PVector(random(0, width), random(0, height*0.6));
  duckvel = new PVector(random(-1, 1), random(-1, 1));
  //  other duck properties
  radius = 60;
  angle = radians(135);
  maxforce = .3;
  maxspeed = 3;
}
void draw() {
  background(255);

  drawBoid(duckpos, duckvel, 255, 0, 0);

  drawDuck(width/2, height/2);
  
  crosshair();
}
void crosshair(){
  strokeWeight(4);
  stroke(255, 0, 0);
  fill(255, 0, 0);
  ellipse(mouseX, mouseY, 5, 5);
  line(mouseX, mouseY-10, mouseX, mouseY-25);
  line(mouseX, mouseY+10, mouseX, mouseY+25);
  line(mouseX-10, mouseY, mouseX-25, mouseY);
  line(mouseX+10, mouseY, mouseX+25, mouseY);
}
void drawDuck( int x, int y) {
  pushMatrix();
  translate(x, y);

  noStroke();
  // wings
  fill(0);
  triangle(-20, 0, -25, 40, 0, 15);
  // body
  fill(175);
  // rotate(radians(45));
  ellipse(0, 0, 40, 60);
  // head
  //  rotate(radians(-90));
  fill(0, 190, 0);
  ellipse(-18, -30, 30, 40);





  popMatrix();
}
