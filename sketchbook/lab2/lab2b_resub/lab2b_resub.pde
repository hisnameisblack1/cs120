//Henry Wrede Black
//Hot air balloon moving along the y-axis based on mouse position

//CORRECTIONS; bottom of basket now follows mouseY

void setup() {
  size(400, 400);
}

void draw() {
background(0, 255, 255);
ellipseMode(CENTER); //CORRECTED TYPO
rectMode(CENTER);

//Ropes
line(100-(25/2), mouseY-25, 70, mouseY-100); //balloon rope left
line(100+(25/2), mouseY-25, 130, mouseY-100); //balloon rope right
line(100-(25/2), mouseY-(25/2), 75, 375); //rope to ground

//Balloon
fill(255, 0, 255);
ellipse(100, mouseY-100, 60, 60);

//Box
fill(100, 130, 60);
rect(100, mouseY-(25/2), 25, 25);

//Ground
rectMode(CORNER);
fill(0, 255, 0);
rect(0, 375, 400, 25);
}
