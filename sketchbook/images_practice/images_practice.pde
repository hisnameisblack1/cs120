// Henry Wrede Black
// in-class image practice

PImage field;

void setup(){
 size(500, 500); 
 
 field = loadImage("windows.jpg");
}

void draw(){
  background(255);
  imageMode(CORNER);
  
  image(field, 0, 0);
}
