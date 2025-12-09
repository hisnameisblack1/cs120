// dog drawing for capstone project

void setup() {
  size(500, 500);
}
void draw() {
  background(200);

  dog(width/2, height/2);
}

void dog(float x, float y) {
 // ears
 pushMatrix();
 translate(x, y);
 ellipseMode(CORNER);
 fill(0);
 rotate(radians(-35));
 ellipse(115, -135, 50, 100);
 rotate(radians(70));
 ellipse(-165, -135, 50, 100);
 popMatrix();
  // duck on point at end of arm
  drawDuck(x+140, y-120); // draws the duck on the dog's right arm
  // arms
  noFill();
  ellipseMode(CORNER);
  stroke(200, 85, 0);
  strokeWeight(20);
  line(x+50, y-45, x+125, y-125); // right arm
  arc(x-95, y-40, 75, 250, PI+radians(20), PI+HALF_PI); // left arm
  // body
  ellipseMode(CENTER);
  noStroke();
  fill(200, 90, 0);
  ellipse(x, y, 125, 350); // bottom layer of body
  fill(229, 115, 0);
  ellipse(x, y+5, 115, 345); // top layer of body
  // head
  ellipse(x, y-100, 115, 75); // bottom head section
  ellipse(x, y-145, 100, 115); // top head section
  fill(50);
  arc(x, y-115, 85, 50, 0-QUARTER_PI/2, PI+QUARTER_PI/2); // mouth
  fill(229, 84, 0);
  ellipse(x, y-100, 50, 15);
  // eyes
  fill(255);
  arc(x-10, y-155, 50, 65, HALF_PI, PI+HALF_PI); // left white
  arc(x+10, y-155, 50, 65, PI+HALF_PI, TWO_PI+HALF_PI); // right white
  fill(0);
  arc(x-10, y-155, 20, 35, HALF_PI, PI+HALF_PI); // left pupil
  arc(x+10, y-155, 20, 35, PI+HALF_PI, TWO_PI+HALF_PI); // right pupil
  // nose
  fill(25);
  ellipse(x, y-120, 35, 25); // big part of nose
  fill(200);
  ellipse(x+3, y-120, 15, 10); // shiny bit of nose
}
void drawDuck( float x, float y) {
  ellipseMode(CENTER);
  pushMatrix();
  translate(x, y);
  noStroke();
  // back wing
  fill(0);
  triangle(-20, 0, -30, 55, 0, 15);
  // body 1
  fill(175);
  ellipse(0, 0, 40, 60);
  // right wing
  fill(100);
  triangle(-20, 0, -20, 65, 0, 15);
  // body 2
  fill(200);
  ellipse(-5, 0, 30, 50);
  // bill
  fill(255, 200, 0);
  quad(-23, -45, -15, -65, -10, -65, -11, -45);
  // head
  fill(0, 190, 0);
  ellipse(-18, -30, 30, 40);
  // eyes
  fill(255);
  ellipse(-20, -40, 15, 10); // white part
  fill(0);
  ellipse(-20, -41, 7, 3); // pupil
  popMatrix();
}
