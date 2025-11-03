//Henry Wrede Black, Joey Burvis

float t;

void setup() {
  size(400, 400);

  t = 0;
}

void draw() {
  ellipseMode(CENTER);
  background(255);

  fill(0);
  triangle(100, 100, 100, height, 300, height);

  {
    float w = 200;
    float h = 300;
    float x0 = 100;
    float y0 = 100;
    
    float x = x0 + t*w; //calcs the x pos of the ellipse
    float y = y0 + t*h; //calcs the y pose of the ellipse
    
    fill(255, 0, 0);
    ellipse(x, y-29, 30, 30);
   
  }
  t += 0.001;
}
