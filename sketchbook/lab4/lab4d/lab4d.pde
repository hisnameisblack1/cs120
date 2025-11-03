//Henry Wrede Black

/*
Playground sketch
 pressing mouse button will reset animations
 */

//extra credit: I added motion along a general position ellipse

float t1; //time 1, for slide animation
float t2; //time 2, for swingset animation
float t3; //time 3, for spiraling bird
float t4; //time 4, for perlin noise

float r; //radius for spiraling bird
float x; //starting x of 0 - using for birds
float slowX; //starting x value or slower bird

float s; //speed of bird
float a; //accelleration of bird


void setup() {
  size(1000, 600);

  t1 = 0;
  t2 = HALF_PI; //starts the stick figure at the bottom of the swingset
  t3 = 0;
  t4 = 0.01;
  r = 0;
  x = 0;
  slowX = -10;

  s = 0.1;
  a = 0.001;
}

void draw() {
  ellipseMode(CENTER);
  rectMode(CENTER);

  background(0, 225, 225); //sky blue

  //using drawing variables to set up background
  park();
  slideBuilding();
  swingset();

  {
    float sizeC = map(noise(t4), 0, 1, 0, 10);
    cloud(100, 200, 50+sizeC);
    cloud(250, 150, 80+sizeC);
    cloud(450, 175, 60+sizeC);
    cloud(500, 100, 90+sizeC);
    cloud(650, 160, 55+sizeC);
    cloud(800, 175, 60+sizeC);
  }

  {
    //kiddo using slide, moves from top to bottom at a constant speed, stops at bottom
    float x0 = 200; //starting x
    float y0 = 425; //starting y

    float w = 150; //width of path of descent
    float h = 125; //height of path of descent

    float x = x0 + t1*w; //calculates the x position
    float y = y0 + t1*h;

    x = min(350, x);
    y = min(550, y);

    stickFig(x, y, 60, 255, 255, 255);

    t1 += 0.01;
  }

  {
    //kiddo using the swingset
    rectMode(CENTER);
    float s = 0.05;
    float a = 0.02;

    float x = 835 + 200*cos(t2); //calculates position on elliptical path
    float y = 345 + 175*sin(t2);

    float c = map(y, 170, 520, 0, 255); //makes stick figures face red when higher up

    stickFig(x, y, 60, 255, c, c);
    fill(50); //gray
    rect(x, y, 20, 10);
    fill(0); //black
    line(825, 355, x-10, y); //swing lines
    line(845, 355, x+10, y);

    /*Below is a quick fix for something I couldn't quite figure out.
     I initially wanted the swing to move back and forth like a pendulum
     but I couldn't quite figure out how to outline the parameters. So
     instead the swing slows down when x is greater than 834, and speeds up
     when x is less than 835.
     */
    if ( x > 834) {
      t2 += s - a;
      s += -a;
    }
    if ( x < 835) {
      t2 += s + a;
    }
  }

  {
    // bird moving in a growing spiral
    float x = width/2 + r*cos(t3);
    float y = 150 + r*(0.5)*sin(t3);

    bird(x, y);

    t3 += 0.01;
    r += 0.5;
  }

  {
    //bird moving straight across screen
    bird(x, 225);
    x+=1; //increments bird over by 1
  }

  {
    //bird moving across screen according to perlin noise
    float birdY = map(noise(t4), 0, 1, 50, 150); //pseudo-randomly varies the y position between 50 and 150
    bird(x+10, birdY);

    t4 += 0.01;
  }
  {
    //slower bird that speeds up to catch up to the others, then slows down
    bird(slowX, 200);
    slowX += s;
    s += a;
    s = min(1.5, s+a);
  }
}

//INTERACTION

void mousePressed() { //resets positions when then mouse is clicked
  t1 = 0; //resets position of slide stick figure
  t2 = HALF_PI; //resets position of stick figure on swingset
  r = 0; //resets position of spiraling bird
  x = 0; //resets x position of birds
  slowX = 0; //resets x pos of the slower bird
  s = 0; //resets speed of the slower bird
}

//DRAWING VARIABLES

void park() {
  noStroke();
  fill(0, 150, 0); //green
  rect(width/2, 450, width, 300);
  //dirt playgroundplatform
  fill(155, 50, 0); //orange-brown
  ellipse(width/2, 510, width-20, 150);
}

//draw stick figure
//"x" - x position, "y" - y position
//"size" - relative size
//"r", "g", "b" - color values for head

void stickFig(float x, float y, float size, float r, float g, float b) { //drawing variable for stick figures
  stroke(0); //black
  fill(r, g, b);
  line(x-size*0.17, y, x, y-size*0.42); //left leg
  line(x+size*0.17, y, x, y-size*0.42); //right leg
  line(x, y-size*0.42, x, y-size*0.92); //"body"
  line(x-size*0.25, y-size*0.67, x+size*0.25, y-size*0.67); //arms
  ellipse(x, y-size, size*0.42, size*0.42); //head
}

//draws a building with a slide at a set position
void slideBuilding() {
  //slide hut
  noStroke();
  //back hut supports
  fill(170, 65, 0); //darker brown
  rect(110, 470, 10, 80);
  rect(290, 470, 10, 80);

  //structure
  fill(255, 125, 0); //orange
  rect(200, 350, 220, 150); //building
  fill(0, 0, 100); //dark blue
  triangle(75, 275, 325, 275, 200, 200); //roog
  fill(230, 100, 0); //darker orange
  arc(200, 425, 150, 270, PI, TWO_PI, CHORD); //doorway

  //base and front supports
  fill(180, 75, 0); //brown
  rect(200, 430, 220, 10);
  rect(95, 480, 10, 100); //left front leg
  rect(305, 480, 10, 100); //right front leg

  //slide
  stroke(255, 0, 0); //red
  fill(230, 230, 0); //slightly darker yellow
  quad(125, 430, 275, 430, 425, 552, 275, 552); //quad underneath the slide to give it some depth
  fill(240, 240, 0); //yellow
  quad(125, 425, 275, 425, 425, 550, 275, 550); //slide itself
}

//draws a swingset at a set postion
void swingset() {
  noStroke();
  fill(70); //gray
  quad(650, 550, 660, 550, 760, 350, 750, 350); //left left leg
  quad(775, 550, 785, 550, 760, 350, 750, 350); //right left leg
  quad(800, 550, 810, 550, 910, 350, 900, 350); //left right leg
  quad(975, 550, 985, 550, 910, 350, 900, 350); //right right leg
  rectMode(CORNER);
  rect(760, 350, 150, 10); //top bar
}

void cloud(float x, float y, float size) {
  noStroke();
  fill(255);
  ellipse(x, y, size, size);
  ellipse(x-10, y+5, size-2, size-2);
  ellipse(x+15, y+3, size-3, size-3);
}

void bird(float x, float y) {
  noStroke();
  fill(75); //gray
  arc(x-25, y, 50, 50, radians(225), radians(360), CHORD);
  arc(x+25, y, 50, 50, radians(180), radians(315), CHORD);
}
