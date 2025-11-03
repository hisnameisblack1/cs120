//Henry Wrede Black, Joey Burvis

int x;

void setup(){
  size(1000, 600);
  x = 0;
}

void draw(){
  background(70);
  snowman(width/2, height-125, 250);
  snowman(width-700, height-135, 50);
  snowman(width-900, height-100, 150);
  snowman(mouseX, mouseY, 100);
  snowman(mouseX, mouseY-200, 100);
  snowman(x, height/2, 100);
  
  x+=1;
}

//draws a snowman at position int x, int y
void snowman(float x, float y, float diam){
  ellipseMode(CENTER);
  
  float d1 = diam;
  float d2 = diam*0.66;
  float d3 = diam*0.33;
  
  fill(255); //white
  ellipse(x, y, d1, d1);
  ellipse(x, y-(d1/2+d2/2), d2, d2);
  ellipse(x, y-(d1/2+d2/2+d1/2), d3, d3);
}
