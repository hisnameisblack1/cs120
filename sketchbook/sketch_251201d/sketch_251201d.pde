// Henry Wrede Black, Joey Burvis
// tinted images

PImage img;

void setup() {
  size(800, 800);

  img = loadImage("butterfly.jpg");
}

void draw() {
  background(0);
  imageMode(CORNER);

  img.width = 400;
  img.height = 400;
  noTint();
  image(img, 0, 0);
  tint(150);
  image(img, width/2, 0);
  tint(255, 0, 0);
  image(img, 0, height/2);
  tint(0, 0, 255);
  image(img, width/2, height/2);
}
