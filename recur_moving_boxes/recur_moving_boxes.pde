import java.util.*;
import megamu.shapetween.*;

int gap=10;
float shift=0;

// https://leebyron.com/shapetween/tween.html



void setup() {

  size(800,800);
  background(0);

}


void rdraw(float x, float y, float w, float h, float shift, int id, int c) {

  if (c == 0) { 
    return; 
  }

  strokeWeight(c);
  stroke(255);
  noFill();

  float nx=0;
  float ny=0;
  
  if (shift < 1) {
    nx = (shift * w/2);
    ny = 0;
  } else if (shift >= 1 && shift < 2) {
    nx = w/2;
    ny = ((shift-1) * h/2);
  } else if (shift >=2 && shift < 3) {
    nx = (w/2) - ((shift-2) * w/2);
    ny = h/2;
  } else if (shift >=3 && shift < 4) {
    nx = 0;
    ny = (h/2) - ((shift-3) * h/2);
  } 

  //rect(x+gap,y+gap,w-gap,h-gap);
  rect(gap+x+nx,gap+y+ny,w-gap,h-gap);

  rdraw(x+nx,y+ny, w/2, h/2, shift, 1, c-1);
  rdraw(nx+x+w/2,ny+y, w/2, h/2, shift, 2,c-1);
  rdraw(nx+x+w/2,ny+y+h/2, w/2, h/2, shift, 3,c-1);
  //rdraw(nx+x,ny+y+h/2, w/2, h/2, shift, 4,c-1);

}

void draw() {
  background(0);
  fill(255);

  rdraw(0,0, width, height, shift, 1, 4);
  shift+=.01;
  if (shift > 4) { shift = 0; }
}

void keyPressed() {
}
