//Henry Wrede Black

void setup() {
  size(500, 500);
}

void draw(){
  background(255);
  
  for (float x = 5, size = 10; size < width; x+=5, size+=10){
    noFill();
    stroke(0);
    ellipse(x, height/2, size, size);
  }
}
