//Henry Wrede Black
/*
Controllable spaceship w, a, s, d... spacebar zeroes out velocities
 when the ship goes off the twice, an asteroid comes down the left side of the screen
 */
//Position variables
float x;
float y;
int yA;
float hV; //horizontal velocity
float vV; //vertical velocity
//State variables
int count;
void setup() {
  size(1250, 800);
  x = width/2;
  y = height/2;
  hV = 0;
  vV = 0;
  yA = -100;
}
void draw() {
  background(0);
  randomSeed(count);
  // DRAWING
  stars(); //draws stars on the background
  spaceship(x, y); //draws the spaceship at position (x,y)
  //Animation Values
  x += hV; //x changes positon by the horizontal velocity
  y += vV; //y changes position by the vertical velocity
  //sets the min and max values for horizontal and vertical velocity
  hV = min(5, hV);
  hV = max(-5, hV);
  vV = min(5, vV);
  vV = max(-10, vV);
  // CONDITIONALS
  //Keeps the car on the screen, sends it to the other side
  if (x >= width + 10) {
    x = -10;
  } else if (x <= -10) {
    x = width + 10;
  }
  if (y >= height + 50) {
    y = -50;
  } else if (y <= -50) {
    y = height + 50;
    count += 1; //adds 1 to count every time ship goes off top of the screen
    print(count); //dispays current count value whenever it goes up
  }
  //when count is greater than 2, draw an asteroid that comes down the screen
  if (count >= 2) {
    fill(100);
    ellipse(100, yA, 150, 150);
    fill(75);
    ellipse(120, yA-30, 50, 50);
    yA += 1;
  }
  //when the asteroid is fully off-screen, reset it's position and reset the count value
  if (yA >= height+50) {
    count = 0;
    yA = -50;
    print(count);
  }
}
// -- INTERACTION --
void keyPressed() {
  if (key == 'd' || key == 'D') { //if D is pressed, accelerate to the right
    hV = hV + 0.1;
  }
  if (key == 'a' || key == 'A') { //if A is pressed, accellerate to the left
    hV = hV - 0.1;
  }
  if (key == 's' || key == 'S') { //if S is pressed, accelerate down
    vV = vV + 0.1;
  }
  if (key == 'w' || key == 'W') { //if W is pressed, accelerate up
    vV = vV - 0.2;
  }

  if (key == ' ') { // if space bar is pressed, horizontal and vertical velocity becomes 0
    hV = 0;
    vV = 0;
  }
}
// -- DRAWING VARIABLES --
//draws a spaceship with position (x,y)
void spaceship(float xS, float yS) {
  rectMode(CENTER);
  ellipseMode(CENTER);
  //ship "wings"
  fill(200, 0, 0);
  arc(xS-(25/2), yS+25, 20, 30, HALF_PI+QUARTER_PI, PI+HALF_PI);
  arc(xS+(25/2), yS+25, 20, 30, PI+HALF_PI, TWO_PI+QUARTER_PI);
  //middle of ship
  noStroke();
  fill(255, 0, 0); //red
  rect(xS, yS, 25, 50); //center body
  arc(xS-3, yS, 25, 75, radians(135), radians(225), CHORD); //left side-curve
  arc(xS+3, yS, 25, 75, radians(315), radians(405), CHORD); //right side-curve
  //top of ship
  stroke(150, 0, 0); //darker red
  ellipse(xS, yS-25, 25, 5); //ring around nose-cone
  noStroke();
  triangle(xS-(25/2), yS-25, xS+(25/2), yS-25, xS, yS-55); //nose-cone
  rect(xS, yS-55, 2, 15); //nose-cone rod
  fill(200, 0, 0);
  ellipse(xS, yS-(55+(15/2)), 5, 5); //nose-cone ball
  //bottom of ship
  ellipse(xS, yS+25, 25, 5); //ring around the bottom of the ship

  if (key == 'w' || key == 'W') { //when the W key is pressed, the ship shoots some fire from the bottom, dissapears when other keys are pressed.
    //exhaust plume
    fill(0, 200, 255, 100); //slightly opaque blue
    triangle(xS-11, yS+25, xS+11, yS+25, xS, yS+100); //big plume
    bezier(xS-11, yS+25, xS-30, yS+60, xS, yS+55, xS, yS+100);
    bezier(xS+11, yS+25, xS+30, yS+60, xS, yS+55, xS, yS+100);
    fill(200, 200, 0); //yellow
    triangle(xS-6, yS+25, xS+6, yS+25, xS, yS+100); //smaller plume
    bezier(xS-5, yS+25, xS-16, yS+50, xS, yS+50, xS, yS+100);
    bezier(xS+5, yS+25, xS+16, yS+50, xS, yS+50, xS, yS+100);
  }
}
//draws a starry space background, makes use of the loop function
void stars() {
  float x = random(0, width); //these values need to designated as floats because they use the random() function
  float y = random(0, height); //but because I want to use a counting loop, the variables declare as integers
  float c = random(0, 255);
  float d = random(1, 10);
  for (int count = 0; count < 500; count+=1, x = random(0, width), y = random(0, height), c = random(0, 255), d = random(1, 10)) {
    ellipseMode(CENTER);
    noStroke();
    fill(c);
    ellipse(x, y, d, d);
  }
}
