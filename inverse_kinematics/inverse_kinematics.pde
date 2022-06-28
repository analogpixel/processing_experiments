// 2 section arm

PVector Target;
PVector Joint0;
PVector Joint1;
int arm_len = 600;

void setup() {
  size(800,800);

  Target = new PVector(arm_len,arm_len);
  Joint0 = new PVector(0,0);
  Joint1 = new PVector(arm_len,arm_len);
}

void draw() {

  Target.x = mouseX;
  Target.y = mouseY;

  float q2 =  acos( ((Target.x * Target.x) + (Target.y * Target.y) - (arm_len * arm_len) - (arm_len * arm_len) )/(2 * arm_len * arm_len)) ;

  // q2 == NaN
  if ( q2 != q2) {
     q2 =  -acos( ((Target.x * Target.x) + (Target.y * Target.y) - (arm_len * arm_len) - (arm_len * arm_len) )/(2 * arm_len * arm_len)) ;
  }

  float q1 =  atan(Target.y/Target.x) - atan( (arm_len * sin(q2)) / (arm_len + arm_len * cos(q2) ) ) ;

  background(0);
  pushMatrix();
  translate(0, 0);
  rotate( q1 );
  fill(255);
  rect(0,0, arm_len, 10);
  translate(arm_len,0);
  rotate(q2);
  rect(0,0, arm_len, 10);
  popMatrix();
  stroke(255);
}

