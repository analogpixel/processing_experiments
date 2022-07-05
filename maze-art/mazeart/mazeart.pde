/* 
   created on  Thu May  6 12:15:34 MDT 2021
 */

class grid_item {

  int l=0;
  int r=0;
  int t=0;
  int b=0;
  int x=0;
  int y=0;

  grid_item(int x, int y) {
    this.x = x;
    this.y = y;
  }

}

int gridx=80;
int gridy=80;
int bs=100;
int loc_x = 2;
int loc_y = 2;

grid_item[][] grid;

void setup() {
  size( 800,800 );

  grid = new grid_item[gridx][gridy];
  for (int x=0; x< gridx; x++) {
    for (int y=0; y< gridy; y++) {
      grid[x][y] = new grid_item(x,y);
    }
  }
}

void keyPressed() {

  if (key == 'w') {
    grid[loc_x][loc_y].b = 1;
    grid[loc_x][loc_y+1].t = 1;
    loc_y++;
  } else if (key =='s') {
    grid[loc_x][loc_y].t = 1;
    grid[loc_x][loc_y-1].b = 1;
    loc_y--;
  } else if (key =='a') {
    grid[loc_x][loc_y].l = 1;
    grid[loc_x+1][loc_y].r = 1;
    loc_x--;
  } else if (key =='d') {
    grid[loc_x][loc_y].r = 1;
    grid[loc_x-1][loc_y].l = 1;
    loc_x++;
  }

  if (loc_x >= gridx) {
    loc_x = gridx;
  }

  if (loc_x < 0) {
    loc_x = 0;
  }

  if (loc_y >= gridy) {
    loc_y = gridy;
  }

  if (loc_y < 0) {
    loc_y = 0;
  }

}

void draw() {
  rect(loc_x*bs, loc_y*bs, bs,bs);
  for (int x=0; x< gridx; x++) {
    for (int y=0; y< gridy; y++) {
      if (grid[x][y].t == 0) { line(bs * x-(bs/2), bs* y-(bs/2), bs*x+(bs/2), bs*y-(bs/2)  ); }
      if (grid[x][y].b == 0) { line(bs * x-(bs/2), bs* y+(bs/2), bs*x+(bs/2), bs*y+(bs/2)  ); }
      if (grid[x][y].l == 0) { line(bs * x-(bs/2), bs* y+(bs/2), bs*x-(bs/2), bs*y-(bs/2)  ); }
      if (grid[x][y].l == 0) { line(bs * x+(bs/2), bs* y+(bs/2), bs*x+(bs/2), bs*y-(bs/2)  ); }
    }
  }

}
