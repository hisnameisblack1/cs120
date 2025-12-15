// Henry Wrede Black
// elementary 1D cellular automation

// NOT WORKING

boolean[] cells;
// boolean[] newcells = new boolean[cells.length];
boolean[] ruleset = { false, true, false, true, true, false, true, false};

void setup() {
  size(510, 510);
  cells = new boolean[width/10];
}
void draw() {
  background(255);

  for (int i = 0, x = 0; i < cells.length; i++, x += 10) {
    cells[i] = false;
    cells[cells.length/2] = true;

    stroke(0);
    if (cells[i]) {
      fill(0);
    } else {
      noFill();
    }


    for (int y = 0; y <= height-10; y += 10) {
      rect(x, y, 10, 10);


      // edge cases, edges wrap around
      cells[0] = cells[cells.length-1];
      cells[cells.length-1] = cells[0];

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
      } else {
        newstate = ruleset[7];
      } // !left && !middle && !right
      cells[i] = newstate;
    }
  }
}

/*
   for (int i = 0; i < cells.length; i++) {
 if (i == 0 || i == cells.length-1) {
 return;
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
 } else {
 newstate = ruleset[7];
 } // !left && !middle && !right
 newcells[i] = newstate;
 }
 cells = newcells;
 */
