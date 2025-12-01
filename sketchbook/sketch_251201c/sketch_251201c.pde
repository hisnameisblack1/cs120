// Henry Wrede Black, Joey Burvis
// animated image

PImage img;
float x;
float alpha;

void setup(){
  size(800, 800);
  
  img = loadImage("butterfly.jpg");
  
  x = 0-img.width/2;
  alpha = 255;
}

void draw(){
  background(0);
  imageMode(CENTER);
  
  tint(255, alpha);
  image(img, x, height/2);
  if (x >= width+img.width/2){
    x = 0-img.width/2;
    alpha = 255;
  }
  x += 10;
  alpha += -2;
  
}
