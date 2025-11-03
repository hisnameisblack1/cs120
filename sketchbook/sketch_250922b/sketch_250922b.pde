//Henry Wrede Black
//Small circle random walk

float x; //x pos
float y; //y pos

void setup() {
  size(500, 500);

  //Initializes variables
  x = width/2;
  y = height/2;
}

void draw() {
  ellipseMode(CENTER);
  background(255);

  fill(255, 0, 0); //red
  ellipse(x, y, 50, 50);
  
  x = x + random(-5, 5); //changes x at a random speed between -5 and 5
  y = y + random(-5, 5); //changes y at a random speed between -5 and 5
}
