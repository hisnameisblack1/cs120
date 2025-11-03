//Henry Wrede Black
//Ball moving away from mouse, ball will always be at least 100 pixels away

int x;
int y;

void setup() {
  size(400, 400);

  x = width/2;
  y = height/2;
}

void draw() {
  background(255);
  fill(255, 0, 0);

  ellipse(x, y, 25, 25);

  if ((mouseX-x) > 0 && (mouseX-x) < 100) {
    x+=-1;
  }
  if ((x - mouseX) > 0 && (x - mouseX) < 100) {
    x+=1;
  }

  if ((mouseY-y) > 0 && (mouseY-y) < 100) {
    y+=-1;
  }
  if ((y - mouseY) > 0 && (y - mouseY) < 100) {
    y+=1;
  }
}

void mousePressed() {
  x = width/2;
  y = height/2;
}
