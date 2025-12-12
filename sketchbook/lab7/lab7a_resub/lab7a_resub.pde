//Henry Wrede Black
//Repeating blue triangle, works with any size window
//repeat-as-long-as loop

void setup() {
  size(800, 100);
  background(255);
}
void draw() {
  for (int x = 0; x <= width; x = x + height/2) {
    fill(0, 0, 200);
    triangle(x, 0, x, height, x+height/2, height/2);
  }
}
