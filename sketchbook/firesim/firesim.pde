// Henry Wrede Black
// Simulation of a spreading forest fire

int[][] cells;
float Pcatch = 0.8;

// if the Pcatch is 20% and the tree generation is 80%, the fire is unlikely to spread.
// similarly, if the Pcatch is 80% and the tree generation is 20%, there aren't enough tree for the fire to spread

void setup() {
  size(500, 500);
  frameRate(10);
  cells = new int[height/10][width/10];

  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells[i].length; j++) {
      if ( random(1.0) < 0.8) {
        if (random(1.0) < 0.01) {
          cells[i][j] = 2; // burning
        } else {
          cells[i][j] = 1;  // tree
        }
      } else {
        cells[i][j] = 0;  // empty
      }
    }
  }
}
void draw() {
  background(255);

  // -- draw current generation
  // row [i], column [j]
  for (int i = 0, y = i; i < cells.length; i++, y += 10) {
    for (int j = 0, x = j; j < cells[i].length; j++, x += 10) {
      stroke(0);
      if (cells[i][j] == 1) {         // if cell is a tree, make it green
        fill(0, 200, 0);
      } else if (cells[i][j] == 2) {  // if cell is on fire, make it red
        fill(255, 0, 0);
      } else if (cells[i][j] == 0) {  // if cell is empty, make it yellow
        fill(255, 255, 0);
      }
      rect(x, y, 10, 10);
    }
  }
  // -- compute next generation
  // row [i], column [j]
  int[][] newcells = new int[cells.length][cells.length];

  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells[i].length; j++) {
      // edge case fix
      if ((i == 0 || i == cells.length-1) || (j == 0 || j == cells.length-1)) {
        newcells[i][j] = 0;
      } else {
        if (cells[i][j] == 0) {        // if cell is empty, it remains empty
          newcells[i][j] = 0;
        } else if (cells[i][j] == 2) { // if cell is burning, it becomes empty
          newcells[i][j] = 0;
        } else if (cells[i][j] == 1 && ( cells[i-1][j] == 2 || cells[i][j-1] == 2 || cells[i][j+1] == 2 || cells[i+1][j] == 2)) {
          // if the cell contains a tree and has at least one burning neighbor (North, East, West, South), it catches fire by probability Pcatch
          if (random(1.0) < Pcatch) {
            newcells[i][j] = 2;
          } else {
            newcells[i][j] = 1;
          }
        } else {                     // otherwise, the cell remains in the same state
          newcells[i][j] = cells[i][j];
        }
      }
    }
  }
  // -- update new generation
  cells = newcells;
}

// reset the simulation if the mouse is clicked
void mouseClicked() {
  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells[i].length; j++) {
      if ( random(1.0) < 0.8) {
        if (random(1.0) < 0.01) {
          cells[i][j] = 2; // burning
        } else {
          cells[i][j] = 1;  // tree
        }
      } else {
        cells[i][j] = 0;  // empty
      }
    }
  }
}
