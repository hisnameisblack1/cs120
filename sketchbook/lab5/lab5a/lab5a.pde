//Henry Wrede Black

//first quilt

void setup(){
  size(400, 400);
  background(255);
}

void draw(){
redHour(width/4, height/4);
redHour(width*0.75, height*0.75);
greenHour(width/4, height*0.75);
greenHour(width*0.75, height/4);

}

void redHour(float x, float y){
  fill(255, 0, 0);
  triangle(x, y, x-100, y-100, x+100, y-100);
  triangle(x, y, x-100, y+100, x+100, y+100);
}

void greenHour(float x, float y){
  fill(0, 255, 0);
  triangle(x, y, x+100, y+100, x+100, y-100);
  triangle(x, y, x-100, y+100, x-100, y-100);
}
