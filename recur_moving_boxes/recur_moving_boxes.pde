import java.util.*;
import megamu.shapetween.*;

int gap=10;
float shift=0;

// https://leebyron.com/shapetween/tween.html



void setup() {

  size(800,800);
  background(0);

}


void rdraw(float x_offset, float y_offset, float w, float h, float shift, int c,int id) {

  shift =  (shift % 4) ;
  float x=0;
  float y=0;

  if (width != w) {

    if (c == 0) { 
      return; 
    }

    strokeWeight(c);
    stroke(255);
    noFill();

    if (id == 1) {
      if (shift < 1) {
        x = x_offset + (shift * (w));
        y = y_offset;
      } else if (shift >= 1 && shift < 2) {
        x = x_offset + w;
        y = y_offset + ((shift-1) * h);
      } else if (shift >=2 && shift < 3) {
        x = x_offset + (w) - ((shift-2) * w);
        y = y_offset + h;
      } else if (shift >=3 && shift < 4) {
        x = x_offset;
        y = y_offset + (h) - ((shift-3) * h);
      } 
    }
  }
  //rect(x+gap,y+gap,w-gap,h-gap);
  rect(x,y,w,h);

  rdraw(x,y, w/2, h/2, shift,  c-1,3);
  rdraw(x ,y, w/2, h/2, shift+1, c-1,2);
  rdraw(x,y, w/2, h/2, shift+2, c-1,1);
  // rdraw(x, y+h/2, w/2, h/2, shift, c-1);

}

void draw() {
  background(0);
  rdraw(0,0, width, height, shift, 2,0);
  shift+=.01;
}

void keyPressed() {
}
