//Henry Wrede Black

void setup() {
  size(400, 400);
  background(255);
}

void draw() {
  q4x4(100, 100);
  q4x4(300, 100);
  q4x4(100, 300);
  q4x4(300, 300);
}

void tLeft(int x, int y, float c) {
  rectMode(CENTER);
  ellipseMode(CENTER);
  noStroke();
  if (c > 0.5) {
    fill(200, 150, 255);
  }
  if (c < 0.5) {
    fill(0, 0, 255);
  }
  rect(x, y, 50, 50);
  if (c < 0.5) {
    fill(200, 150, 255);
  }
  if (c > 0.5) {
    fill(0, 0, 255);
  }
  arc(x-25, y-25, 60, 60, 0, HALF_PI);
}

void tRight(int x, int y, float c) {
  rectMode(CENTER);
  ellipseMode(CENTER);
  noStroke();
  if (c > 0.5) {
    fill(200, 150, 255);
  }
  if (c < 0.5) {
    fill(0, 0, 255);
  }
  rect(x, y, 50, 50);
  if (c < 0.5) {
    fill(200, 150, 255);
  }
  if (c > 0.5) {
    fill(0, 0, 255);
  }
  arc(x+25, y-25, 60, 60, HALF_PI, PI);
}

void bLeft(int x, int y, float c) {
  rectMode(CENTER);
  ellipseMode(CENTER);
  noStroke();
  if (c > 0.5) {
    fill(200, 150, 255);
  }
  if (c < 0.5) {
    fill(0, 0, 255);
  }
  rect(x, y, 50, 50);
  if (c < 0.5) {
    fill(200, 150, 255);
  }
  if (c > 0.5) {
    fill(0, 0, 255);
  }
  arc(x-25, y+25, 60, 60, PI+HALF_PI, TWO_PI);
}

void bRight(int x, int y, float c) {
  rectMode(CENTER);
  ellipseMode(CENTER);
  noStroke();
  if (c > 0.5) {
    fill(200, 150, 255);
  }
  if (c < 0.5) {
    fill(0, 0, 255);
  }
  rect(x, y, 50, 50);
  if (c < 0.5) {
    fill(200, 150, 255);
  }
  if (c > 0.5) {
    fill(0, 0, 255);
  }
  arc(x+25, y+25, 60, 60, PI, PI+HALF_PI);
}

void q4x4(int x, int y) {
  //top left
  tRight(x-75, y-75, 1);
  bLeft(x-25, y-75, 0);
  tRight(x-75, y-25, 0);
  tRight(x-25, y-25, 1);
  //top right
  bRight(x+25, y-75, 0);
  bRight(x+75, y-75, 1);
  bRight(x+25, y-25, 1);
  tLeft(x+75, y-25, 0);
  //bottom left
  bRight(x-75, y+25, 0);
  tLeft(x-25, y+25, 1);
  tLeft(x-75, y+75, 1);
  tLeft(x-25, y+75, 0);
  //bottom right
  bLeft(x+25, y+25, 1);
  bLeft(x+75, y+25, 0);
  tRight(x+25, y+75, 0);
  bLeft(x+75, y+75, 1);
}
