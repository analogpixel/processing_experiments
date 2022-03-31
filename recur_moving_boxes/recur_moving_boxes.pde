import java.util.*;

/*
   have a function to call with x,y,w,h,id

   and this is what draws a pattern;

   the smallest set of quads will be calling this function on their area

   quads.update should move the squares around x+=inc y+inc....etc

 */

void drawShape(int x, int y, int w, int h ) {
  strokeWeight(2);
  stroke(90);
  fill(200);
  rect(x+10, y+10, w-10, h-10);
}

class quad {
  ArrayList<quad> quads = new ArrayList<quad>();
  boolean isShape;
  int x;
  int y;
  int w;
  int h;
  int xinc=1;
  int yinc=0;

  quad(int x, int y, int w, int h, int depth, boolean isShape) {

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.isShape = isShape;

    if(depth > 0 ) {
      // depth == 1  just retrns true on the last item
      quads.add( quad(x,y,x/2,y/2, depth -1, depth == 1) ); 
      quads.add( quad(x+w/2,y,x/2,y/2, depth -1, depth == 1) ); 
      quads.add( quad(x+w/2,y+h/2,x/2,y/2, depth -1, depth == 1) ); 
      quads.add( quad(x,y+h/2,x/2,y/2, depth -1, depth == 1) ); 
    }
  }

  public void update() {
    x+=xinc;
    y+=yinc;

    // top row, right side, move down 
    if( x >= w/2 && y == 0) {
      yinc=1;
      xinc=0;
    // bottom row, right side, move left
    } else if (x >= w/2 && y >= h/2) {
      xinc=-1;
      yinc=0;
    // bottom row, left side, move up
    } else if (x == 0 && y >= h/2) {
      xinc=0;
      yinc=-1;
    // top row, left, move right
    } else if (x==0 && y == 0) {
      xinc=1;
      yinc=0;
    }

    if (isShape) {
      drawShape(x,y,w,h);
    }

  }

}

quad parent_quad;

void setup() {

  size(800,800);
  background(0);
  parent_quad = new quad(0,0,width, height, 2);
}


void draw() {
}

void keyPressed() {
  background(0);
  parent_quad.update();
}


