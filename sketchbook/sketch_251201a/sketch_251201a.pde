// Henry Wrede Black, Joey Burvis
// display image

PImage img;

void setup(){
  size(800, 800);
  
  img = loadImage("butterfly.jpg");
}

void draw(){
  background(0);
  imageMode(CENTER);
  
  image(img, width/2, height/2);
  
}
