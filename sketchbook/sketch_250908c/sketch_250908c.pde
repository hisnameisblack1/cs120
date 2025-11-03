//Henry Wrede Black, Joey Burvis

size(600,400);

background(100); //light-ish grey

rectMode(CENTER);
ellipseMode(CENTER);

//House
  //body
  fill(255,0,0);
  stroke(0);
  rect(200,200,275,275);
  //roof
  fill(160,70,20);
  triangle(200,20,62.5,62.5,337.5,62.5);
//Snowman
  fill(255);
  ellipse(337.5,325,150,150); //bottom circle
  ellipse(337.5,200,100,100); //middle circle
  ellipse(337.5,125,50,50); //top circle
  
//tree
  //trunk
  fill(160,70,20); //brown
  noStroke();
  rectMode(CORNERS);
  rect(475,325,500,225);
  //top
  fill(0,75,0); //forest green
  triangle(450,225,525,225,487.5,35);
