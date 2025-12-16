// Henry Wrede Black
// elementary 1D cellular automation

boolean[] cells;
boolean[] ruleset = { false, true, false, true, true, false, true, false };

void setup() {
  size(510, 500);
  cells = new boolean[width/10];
}
void draw() {
  background(255);
  randomSeed(0);
  // set all cells to false except for the middle cell
  for (int i = 0; i < cells.length; i++) {
    //cells[i] = false;
    //cells[cells.length/2] = true;
    if ( random(1.0) < 0.5) {
      cells[i] = true;
    } else {
      cells[i] = false;
    }
  }
  // draw cells down screen
  for (int y = 0; y < height; y += 10) {
    // -- draw one row
    for (int i = 0, x = 0; i < cells.length; i++, x += 10) {
      { // draw current generation
        stroke(0);
        if (cells[i]) { // if cells is true, make indexed square black
          fill(0);
        } else {
          fill(255);
        }
        rect(x, y, 10, 10);
      }
    }
    // -- update row
    boolean[] newcells = new boolean[cells.length];

    for (int i = 0; i < cells.length; i++) {
      // compute next generation
      if ( i == 0 || i == cells.length-1) { // if cells are on edges, do not update
        newcells[i] = false;
      } else {
        boolean left = cells[i-1];
        boolean middle = cells[i];
        boolean right = cells[i+1];
        boolean newstate;
        if ( left && middle && right ) {
          newstate = ruleset[0];
        } else if ( left && middle && !right ) {
          newstate = ruleset[1];
        } else if ( left && !middle && right ) {
          newstate = ruleset[2];
        } else if ( left && !middle && !right ) {
          newstate = ruleset[3];
        } else if ( !left && middle && right ) {
          newstate = ruleset[4];
        } else if ( !left && middle && !right ) {
          newstate = ruleset[5];
        } else if ( !left && !middle && right ) {
          newstate = ruleset[6];
        } else { // !left && !middle && !right
          newstate = ruleset[7];
        }
        newcells[i] = newstate;
      }
    }
    // -- update previous generation with new generation, all at once
    cells = newcells;
  }
}
