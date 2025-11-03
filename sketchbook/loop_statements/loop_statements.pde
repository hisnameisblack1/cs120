//Henry Wrede Black

void setup() {
  size(500, 500);
}

void draw() {
  background(255);


  //ONE LOOP VARIABLE
  /*
   for(float y = height-25; y >= 0; y = y-50){
   fill(255, 0, 0);
   stroke(0);
   ellipse(width/2, y, 50, 50);
   }
   */

  //>1 LOOP VARIABLE
 /*
  for (float x = 5, y = 5; x+5 <= width && y+5 <= height; x += 10, y += 10) {
    fill(255, 0, 0);
    stroke(0);
    ellipse(x, y, 10, 10);
  }
  */
  
  //COUNTING LOOPS - unfinished//
/*
for (int count = 0, x = 5*5; count < 10; count+=1, x+=10){
    fill(255, 0, 0);
    stroke(0);
    ellipse(x, height/2, 10, 10);
  }
  for (int count = 0, x = 5, y = height/2; count < 5; count+=1, x+=10, y+=5, y+=-5){
        fill(255, 0, 0);
    stroke(0);
    ellipse(x, height/2, 10, 10);
  }
  */
}
