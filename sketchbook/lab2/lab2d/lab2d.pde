//Henry Wrede Black

/* Fancy Car driving along the highway at night
 The car follows mouseX to move across the screen.
 Depending on mouseY, the background will lighten/darken and the car and road lights
 will turn on and off.
 */

/* Found the function colorMode() while reading through a page in the API. I use it in the code to
 set a linear scale for the values to follow according to mouseY. Without changing the GRAY scale to
 0-600, it defaults to 0-255, giving me only 255 pixels on the screen for mouseY to change the color.
 To get around this I use the following
 colorMode(GRAY, 0, 600) to set to grayscale, then colorMode(RGB, 600, 600, 600) or colorMode(RGB) to return to
 the default mode and scale.
 */

//General Variables
float buildingH;
int buildingW;
int lightDepth;

//Variables for road stripe components
int topQuad;
int bottomQuad;
int qx1;
int qx2;
int qx3;
int qx4;

void setup() {
  size(1000, 600);
  rectMode(CENTER);
  ellipseMode(CENTER);

  //Initializning Variables
  lightDepth = 575; //changes how far down the light reaches
  buildingW = 150; //sets width of the background buildings
  
  topQuad = 520; //sets top y-coord of the road stripes
  bottomQuad = 530; //sets bottom y-coord of the road stripes
  qx1 = 50; //sets top left X coord
  qx2 = 100; //sets top right X coord
  qx3 = 97; //sets bottom right X coord
  qx4 = 47; //sets bottom left X coord
}

void draw() {
  colorMode(RGB, 600, 600, 600); //changes RGB scale to 0-600 to scale better with mouseY
  background(0, 0+mouseY/4, 0+mouseY/3); //blue dependent on mouseY, if B is larger than G, the resulting blue will be more "ocean"
  colorMode(GRAY, 600); //sets GRAY color scale to 0-600 to better adjust to mouseY values
  //Background
  fill(60+mouseY/4); //deep background, starts dark gray but increases GRAY value according to mouseY
  rect(225, 300, buildingW, 525);//background building
  rect(625, 300, buildingW, 500);
  rect(825, 300, buildingW, 475);
  fill(70+mouseY/4); //middle background, GRAY dependent on mouseY
  rect(150, 300, buildingW, 430);
  rect(450, 300, buildingW, 325);
  rect(950, 300, buildingW, 450);
  fill(80+mouseY/4); //close background, GRAY dependent on mouseY
  rect(325, 400, buildingW, 200);
  rect(550, 400, buildingW, 225);
  rect(715, 400, buildingW, 175);

  //street-lamp poles
  colorMode(RGB, 255, 255, 255); //sets color mode back to default
  fill(60); //dark gray

  rect(100, 315, 15, 350); //left pole
  rect(700, 315, 15, 350); //right pole

  //Road Components
  fill(50); //middling gray
  rect(500, 450, 1000, 50); //rear road bulwark
  fill(60); //lighter than middling gray
  rect(500, 470, 1000, 5); //road curb
  fill(30); //darker gray

  rect(500, 525, 1000, 100); //asphalt

  //Stripes
  fill(125, 125, 0); //darker yellow

  quad(50, topQuad, 100, topQuad, 97, bottomQuad, 47, bottomQuad); //road stripe
  quad(qx1+100, topQuad, 100+100, topQuad, 97+100, bottomQuad, 47+100, bottomQuad); //stripes continued
  quad(50+200, topQuad, 100+200, topQuad, 97+200, bottomQuad, 47+200, bottomQuad);
  quad(50+300, topQuad, 100+300, topQuad, 97+300, bottomQuad, 47+300, bottomQuad);
  quad(50+400, topQuad, 100+400, topQuad, 97+400, bottomQuad, 47+400, bottomQuad);
  quad(50+500, topQuad, 100+500, topQuad, 97+500, bottomQuad, 47+500, bottomQuad);
  quad(50+600, topQuad, 100+600, topQuad, 97+600, bottomQuad, 47+600, bottomQuad);
  quad(50+700, topQuad, 100+700, topQuad, 97+700, bottomQuad, 47+700, bottomQuad);
  quad(50+800, topQuad, 100+800, topQuad, 97+800, bottomQuad, 47+800, bottomQuad);
  quad(50+900, topQuad, 100+900, topQuad, 97+900, bottomQuad, 47+900, bottomQuad);

  /*I tried to shortcut this by writing "int topQuad = topQuad + 100;"
   but that moves the stripe to the right instead of copying it across the full road.
   Is there an easy way to repeat shapes across a horizontal plane?
   */


  //right car headlights
  fill(255, 255, 0, 100-mouseY/5); //light opaque yellow
  triangle(mouseX-150, 424, mouseX-350, 530, mouseX-650, 530); //light coming out of headlight

  //VW Bug Car Components
    //Car body
  noStroke();
  fill(150, 0, 0); //Dark-ish red
  rect(mouseX, 450, 200, 100); //middle body
  arc(mouseX-100, 500, 200, 200, radians(180), radians(270), PIE); //front body
  triangle(mouseX+100, 400, mouseX+100, 500, mouseX+200, 500); //back body
  //door outline
  stroke(0);
  line(mouseX+30, 400, mouseX+30, 490);
  line(mouseX-90, 455, mouseX-90, 410);
  line(mouseX+30, 490, mouseX-55, 490);
  arc(mouseX-90, 490, 70, 70, radians(270), radians(360));
  //door handle
  stroke(150, 0 ,0);
  fill(75, 75, 75);
  ellipse(mouseX+10, 420, 20, 10);

    //Car top
  fill(150, 0, 0); //Dark-ish red
  noStroke();
  bezier(mouseX-100, 400, mouseX-50, 300, mouseX+50, 350, mouseX+100, 400); //roof
  fill(0, 175, 175); //light blue
  bezier(mouseX-90, 400, mouseX-50, 310, mouseX+50, 360, mouseX+90, 400); //windows
  fill(150, 0, 0); //Dark-ish red
  rectMode(CORNERS);
  rect(mouseX+30, 400, mouseX+40, 360); //window bezel

    //wheels
  fill(125, 0, 0); //darker red
  arc(mouseX-125, 500, 100, 100, radians(180), radians(360), CLOSE); //front wheelwell
  arc(mouseX+115, 500, 100, 100, radians(180), radians(360), CLOSE); //rear wheelwell
  fill(0); //black
  ellipse(mouseX-125, 500, 80, 80); //left wheel
  ellipse(mouseX+115, 500, 80, 80); //right wheel
  fill(60); //dark gray
  ellipse(mouseX-125, 500, 50, 50); //left wheel hub
  ellipse(mouseX+115, 500, 50, 50); //right wheel hub

    //front car headlights
  fill(135, 0, 0); //darker red than then car body
  ellipse(mouseX-150, 425, 25, 25); //headlight body
  fill(255, 255, 0, 100-mouseY/5); //light opaque yellow
  triangle(mouseX-150, 425, mouseX-350, 540, mouseX-650, 540); //light coming out of headlight

  //Things in front of the car
    //Street lamp-lights
  fill(200, 200, 0, 100-mouseY/5); //slightly dark opaque yellow
  triangle(100, 140, 0, lightDepth, 200, lightDepth); //left side light
  triangle(700, 140, 800, lightDepth, 600, lightDepth); //right side light
    //Street lamp covers
  fill(60); //dark gray
  rectMode(CENTER);
  rect(100, 150, 40, 30); //left cover
  rect(700, 150, 40, 30); //right color

    //front road bulwark
  fill(50); //middling gray
  rect(500, 580, 1000, 50); //front road bulwark
}
