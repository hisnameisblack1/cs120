//Henry Wrede Black
//learning arrays

float[] y; //declare the array variable

void setup() {
  size(400, 400);

  y = new float[10]; //initialize an array variable, # of array compartments
  for (int i = 0; i < y.length; i++) {
    y[i] = random(0, height); // for each compartment in the array, choose a random y value
  }
}
void draw() {
  background(255);

  for (int i = 0; i < y.length; i++) {
    fill(255, 0, 0);
    ellipse(width/2, y[i], 20, 20);
  }
  for (int i = 0; i < y.length; i++)
  {
    y[i]++;
  }
}
