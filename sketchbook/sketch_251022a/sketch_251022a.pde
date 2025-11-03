//Henry Wrede Black

void setup(){
  size(500, 500);
}

void draw(){
  background(255);
  
  for (float size = 10; size <= width; size += 10){
    noFill();
    stroke(0);
    ellipse(width/2, height/2, size, size);
  }
}
