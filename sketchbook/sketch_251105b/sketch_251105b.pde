// Henry Wrede Black
// 20 ellipses, moving right with a random speed

float[] x;
float[] xspeed;  // position and speed of ellipse

void setup () {
  size(400, 400);

  x = new float[20];
  for (int i = 0; i < x.length; i++){
   x[i] = 10; 
  }
  xspeed = new float[20];
  for (int i = 0; i < xspeed.length; i++){
    xspeed[i] = random(0,10);
  }
}
void draw () {
  background(255);
  ellipseMode(CENTER);

  // draw ellipse
  for (int i = 0, y = 10; i < x.length; i++, y += 20){
  fill(255, 0, 0);
  ellipse(x[i], y, 20, 20);
  }
  for (int i = 0; i < x.length && i < xspeed.length; i++){
  x[i] = x[i]+xspeed[i];
  }
}
