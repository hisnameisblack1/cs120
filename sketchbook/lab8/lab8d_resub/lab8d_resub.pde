//Henry Wrede Black
//sunset on a beach

float y;
float t;

void setup() {
  size(1000, 500);

  y = height-50;
  t = 0;
}
void draw() {
  background(0);
  randomSeed(0);
  noStroke();
  //counting loop - draws the stars in the background
  for (float count = 0; count <= 1000; count++) {
    float dim = random(0, 5);
    ellipseMode(CENTER);
    fill(random(0, 255));
    ellipse(random(0, width), random(0, height*0.6), dim, dim);
  }
  //nested loop and repeat-as-long-as loop - draws the gradients on either side of the sun
  for (int y = 0, opacity = 0; y <= height*0.6; y += 10, opacity += 15) {
    for (int x = 0, red = 0, blue = 100; x < width/2; x += 10, red += 5, blue += -2) {
      fill(red, 0, blue, opacity);
      rect(x, y, 10, 10);
    }
  }
  //more than one property (excluding counter) varies from one repition to the next - flipped version of the above loop
  for (int y = 0, opacity = 0; y <= height*0.6; y += 10, opacity += 15) {
    for (int x = width/2, red = 255, blue = 0; x <= width; x += 10, red += -5, blue += 2) {
      fill(red, 0, blue, opacity);
      rect(x, y, 10, 10);
    }
  }
  //red sun
  noStroke();
  fill(255, 0, 0);
  ellipse(width/2, height*0.55, 250, 250);
  { //beach
    noStroke();
    rectMode(CORNER);
    fill(200, 200, 0);
    rect(0, height*0.6, width, height*0.6);
    // loop where only one property varies to the next - draws border on beach
    for (int x = 0; x <= width; x += 40) {
      ellipseMode(CENTER);
      fill(200, 200, 0);
      ellipse(x, height*0.6+3, 50, 20);
    }
    //counting loop - draws rocks on the beach
    for (int count = 0; count <= 10; count++) {
      rock1(random(0, width), random(height*0.6, height));
    }
    // draws water on beach
  }  // animation and loop variables are different properties - moves water up and down
     // animation variables involve same property as loop variable - moves water side to side
  for (float x = 0; x <= width; x += 20) {
    fill(0, 0, 255, 100);
    arc(x+map(noise(t), 0, 1, -20, 20), y+map(noise(t), 0, 1, -10, 10), 20, 10, PI, TWO_PI);
    rectMode(CORNER);
    rect(x-10+map(noise(t), 0, 1, -20, 20), y+map(noise(t), 0, 1, -10, 10), 20, height);
  }

  t+= 0.01;
}
//draws a rock at position (x, y)
void rock1 (float x, float y) {
  rectMode(CENTER);
  noStroke();
  fill(100);
  ellipse(x, y, 50, 25);
  fill(200, 200, 0);
  rect(x, y+15, 50, 25 );
}
