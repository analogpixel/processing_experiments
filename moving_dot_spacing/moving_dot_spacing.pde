
// TODO 
// https://natureofcode.com/book/chapter-1-vectors/
// figure out how to make one vector move away from another vector
// maybe give every box an accel of 0,0  and based on things moving toward it they can acel away

// have a start point that the ball always tries to get back to.

class ball {
  PVector location_start;
  PVector location_now;
  PVector accel;
}


ball [] balls;
PVector [] boxes;
int num_per_row = 10;
int box_size = 20;
int thresh = 18;

void setup() {
  size( 200,200);
  boxes = new PVector[ num_per_row * num_per_row];
  balls = new ball[ num_per_row * num_per_row];
  for (int x=0; x < num_per_row; x++) {
    for(int y=0; y< num_per_row; y++) {
      boxes[x + y*num_per_row] = new PVector(x * box_size,y * box_size);
    }
  }
}

void draw() {

  for(int i=0; i < num_per_row*num_per_row; i++) {
    for(int j=0; j < num_per_row*num_per_row; j++) {
      if (i==j || i == 55) { continue;}
      PVector f = PVector.sub( boxes[i], boxes[j]);
      float dist = f.mag();
      if (dist < thresh) {
        f.normalize(); 
        f.mult(1);
        boxes[i].add(f);
      }
    }
  }

  background(255);
  for (int i=0; i < num_per_row*num_per_row; i++) {
    PVector p = boxes[i] ;
    ellipse(p.x, p.y, box_size/2, box_size/2);
  }

}

void keyPressed() {
  boxes[55].x++;
  boxes[55].y++;
}

