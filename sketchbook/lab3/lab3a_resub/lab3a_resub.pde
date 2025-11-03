//Henry Wrede Black
//a tall building in a grassy field, with a cloud floating by

// CORRECTIONS -- cloud starts off the screen, made cloud closer to reference

float cloudX; //x position for the clouds

void setup() {
  size(400, 400);

  cloudX = -75; // initializes the variable and sets it off screen
}

void draw() {
  background(0, 200, 200); //light blue
  rectMode(CENTER);
  ellipseMode(CENTER);
  noStroke();

  //moving cloud
  fill(245); //light gray
  ellipse(cloudX, 100, 60, 60); //big circle
  ellipse(cloudX + 20, 120, 40, 40); //little circle
  ellipse(cloudX - 30, 110, 50, 50); //medium circle

  //tower
  fill(0);
  rect(333, 250, 66, 300);

  //grassy field
  fill(0, 200, 0);
  rect(width/2, 390, 400, 20);

  cloudX = cloudX + 1; //moves the cloud one pixel to the left every frame
}

void mouseClicked() {
  cloudX = -75; //resets the position of the cloud to it's original value when the mouse is clicked
}
