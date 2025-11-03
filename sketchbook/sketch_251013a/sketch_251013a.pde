//Henry Wrede Black
//conditionals practice

void setup(){
  size(400, 400);
}
void draw(){
  background(255);
  
  if (((mouseX > 50 && mouseX < 150) && (mouseY > 50 && mouseY < 150)) || ((mouseY > 250 && mouseX < 350) && (mouseY > 250 && mouseY < 350))){
    fill(255, 0, 0);
  } else if (mouseY <= height/2){
    fill(0, 0, 255);
  } else {
    fill(0, 255, 0);
  }
  
  rect(100, 100, 100, 100);
  rect(300, 300, 100, 100);
  
}
  
  
