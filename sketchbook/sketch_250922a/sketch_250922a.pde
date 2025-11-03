//Henry Wrede Black
//four small circles

//y-coords for the circles
float y1;
float y2;
float y3;
float y4;
//speed values for the circles
float y3a;
float y4a;

void setup() {
  size(400, 600);

  //Initializes variables
  y1 = height - 5;
  y2 = height - 5;
  y3 = height - 5;
  y4 = height - 5;

  y3a = 0; //starting speed of y3 is 0
  y4a = -10; //starting speed of y4 is -10
}

void draw() {
  ellipseMode(CENTER);
  background(255);

  fill(255, 0, 0); //red
  ellipse(width*.2, y1, 10, 10);
  fill(0, 255, 0); //green
  ellipse(width*.4, y2, 10, 10);
  fill(0, 0, 255); //blue
  ellipse(width*.6, y3, 10, 10);
  fill(255, 0, 255); //magenta
  ellipse(width*.8, y4, 10, 10);


  //Animation variables
  y1 = y1 - 1; //constant speed
  y2 = y2 - random(2); //random value between -1 and up to 2

  y3 = y3 + y3a;
  y3a = y3a - .25; //speed increasing by .25

  y4 = y4 + y4a;
  y4a = y4a + .25; //speed increasing by .25
}
