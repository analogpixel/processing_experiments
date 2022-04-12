import java.util.*;
import megamu.shapetween.*;

int gap=10;
int shift=0;

// https://leebyron.com/shapetween/tween.html



void setup() {

  size(800,800);
  background(0);

}


void rdraw(float x, float y, float w, float h, int shift, int id, int c) {

  /*
     no x/y, just x 
     amt = base - shift
     if x is between 0(base) and w/2  you are in section 1 moving right amt
     if x is between w/2(base) and (w/2)*2 you are in section 2 moving down amt
     if x is between (w/2)*3(base) and (w/2)*3 you are in section 3 moving right amt
     if x is between (w/2)*3(base) and (w/2)*4 you are in section 4 moving up amt
     if x > (w/2)*4  reset x to 0
     */

  if (id !=4) {
  strokeWeight(c);
  stroke(255);
  noFill();
  rect(shift + x+gap,shift + y+gap,w-gap,h-gap);
  }

  if (c == 0) { 
    return; 
  }

  rdraw(shift+x,shift+y, w/2, h/2, shift, 1, c-1);
  rdraw(shift+x+w/2,shift+y, w/2, h/2, shift, 2,c-1);
  rdraw(shift+x+w/2,shift+y+h/2, w/2, h/2, shift, 3,c-1);
  // rdraw(x,y+h/2, w/2, h/2, shift, 4,c-1);

}

void draw() {
  background(0);
  fill(255);

  rdraw(0,0, width, height, shift, 1, 4);
  shift++;
}

void keyPressed() {
}
