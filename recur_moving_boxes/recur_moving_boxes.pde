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

  if (id !=4) {
  strokeWeight(c);
  stroke(255);
  noFill();
  rect(x+gap,y+gap,w-gap,h-gap);
  }

  if (c == 0) { 
    return; 
  }

  rdraw(x,y, w/2, h/2, shift, 1, c-1);
  rdraw(x+w/2,y, w/2, h/2, shift, 2,c-1);
  rdraw(x+w/2,y+h/2, w/2, h/2, shift, 3,c-1);
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
