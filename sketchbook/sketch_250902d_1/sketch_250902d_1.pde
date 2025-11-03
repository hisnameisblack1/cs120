//Henry Wrede Black - Piet Mondrian

//Trying to sketch out the painting by doing the border, lines, then squares, in that order

//Setup
size(1000,600);
background(255);

//Border
fill(50);
noStroke();
rectMode(CENTER);

rect(0,300,20,600); //left
rect(1000,300,20,600); //right
rect(500,600,1000,20); //bottom
rect(500,0,1000,20); //top

//Intersecting Lines
rect(500,300,5,600); //center vertical
rect(
