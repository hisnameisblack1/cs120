//Henry Wrede Black, Joey Burvis
//bouncing balls


float yR; //y position of red ellipse
float yB; //y position of blue ellipse

float g; //gravity
float air; //air resistance
float damp; //energy lost due to friction
float yspeedB;
float yspeedR;

void setup() {
  size(300, 600);
  g = 0.5;
  air = 0.005;
  damp = 0.9;
  yR = 10;
  yB = 10;
  yspeedR = 0;
  yspeedB = 0;
}
void draw() {
  background(255);
  ellipseMode(CENTER);
  {
    fill(255, 0, 0);
    ellipse(width/3, yR, 20, 20);
    yR += yspeedR;
    yspeedR += g;
    if (yR >= height-10) {
      yspeedR = -1*yspeedR;
    }
  }
  {
    fill(0, 0, 255);
    ellipse(width-width/3, yB, 20, 20);
    yB += yspeedB;
    yspeedB += g - air*yspeedB;
    if (yB >= height-10) {
      yspeedB = -damp*yspeedB;
    }
  }
}
