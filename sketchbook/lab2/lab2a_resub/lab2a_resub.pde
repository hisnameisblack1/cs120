//Henry Wrede Black
//Hot air balloon

size(400, 400);
background(0, 255, 255);

ellipseMode(CENTER); //CORRECTED TYPO
rectMode(CENTER);

//Ropes
line(100-(25/2), 175, 70, 100); //balloon rope left
line(100+(25/2), 175, 130, 100); //balloon rope right
line(100-(25/2), 200, 75, 375);

//Balloon
fill(255, 0, 255);
ellipse(100, 100, 60, 60);

//Box
fill(100, 130, 60);
rect(100, 200-(25/2), 25, 25);

//Ground
rectMode(CORNER);
fill(0, 255, 0);
rect(0, 375, 400, 25);
