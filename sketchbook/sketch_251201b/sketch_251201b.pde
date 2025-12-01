// Henry Wrede Black, Joey Burvis
// animated image

PImage img;
float x;

void setup(){
  size(800, 800);
  
  img = loadImage("butterfly.jpg");
  
  x = 0-img.width/2;
}

void draw(){
  background(0);
  imageMode(CENTER);
  
  image(img, x, height/2);
  if (x >= width+img.width/2){
    x = 0-img.width/2;
  }
  x += 10;
  
}
