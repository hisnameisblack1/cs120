//Henry Wrede Black  

void setup(){
  size(500, 500);
}

void draw(){
  background(255);
  for (int count = 0, y = height-75, d = 150; count < 3; count+= 1, d+= -50, y+= -d-25){
    noFill();
    stroke(0);
    ellipse(width/2, y, d, d);
  }
}
  
