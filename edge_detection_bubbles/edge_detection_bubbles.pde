// https://twitter.com/DlSPUTED/status/1543357702180446208

class Bubble {
  Bubble(int x, int y, int rmin, int rmax) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.rmin = rmin;
    this.rmax = rmax;
    this.inc = 1;

  }

  int x;
  int y;
  int r;
}

ArrayList<Bubble> bubbles = new ArrayList<Bubble>();

PImage img;
PGraphics offs;

void setup() { 
  size(800, 800);

  bubbles.add( new Bubble(width/2, height/2, 50) );
  bubbles.add( new Bubble(width/2 + 20, height/2+20, 30) );
  bubbles.add( new Bubble(width/2 - 20, height/2+10, 20) );

  offs = createGraphics(800,800);

}

void update_offs() {
  offs.beginDraw();
  offs.background(0);
  offs.noStroke();
  offs.fill(255);
  offs.rect(width/2, height/2, 50,50);
  for (int i=0; i < bubbles.size(); i++) {
    Bubble b = bubbles.get(i);
    offs.ellipse(b.x, b.y, b.r,b.r);
    b.r = b.r - 1;
    b.y = b.y - 2;

    if (b.r < 0) {
      b.r = int(random(70));
      b.x = width/2 + int(random(30));
      b.y = height/2 + int(random(30));
    }

  }
  offs.filter(BLUR, 2);
  offs.endDraw();
}

void draw() {
  update_offs();
  offs.loadPixels();
  
  background(0);
  fill(255);
  noStroke();

  for (int y=0; y < height; y++) {
    boolean toggle = false;
    for (int x=0; x < width; x++) {
      float current_pixel = red(offs.pixels[ x + y * width]);

      // white and inside
      if ( current_pixel > 90 && toggle == true) {
        // do nothing
      } else if ( current_pixel < 90 && toggle == true) {
        // we just left a solid white area so put a pixel back one
        ellipse(x-1,y, 2,2);
        toggle = false; 
      } else if ( current_pixel > 90 && toggle == false) {
        // we just hit a new edge
        ellipse(x,y,2,2);
        toggle = true;
      }
    }
  }

  // now do it vertically
  for (int x=0; x < width; x++) {
    boolean toggle = false;
    for (int y=0; y < height; y++) {
      float current_pixel = red(offs.pixels[ x + y * width]);

      // white and inside
      if ( current_pixel > 90 && toggle == true) {
        // do nothing
      } else if ( current_pixel < 90 && toggle == true) {
        // we just left a solid white area so put a pixel back one
        ellipse(x-1,y, 2,2);
        toggle = false; 
      } else if ( current_pixel > 90 && toggle == false) {
        // we just hit a new edge
        ellipse(x,y,2,2);
        toggle = true;
      }
    }
  }
}
