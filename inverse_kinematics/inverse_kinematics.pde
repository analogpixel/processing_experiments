// 2 section arm

PVector Target;
PVector Joint0;
PVector Joint1;
int arm_len = 400;

void setup() {
  size(800,800);

  Target = new PVector(arm_len,arm_len);
  Joint0 = new PVector(0,0);
  Joint1 = new PVector(arm_len,arm_len);
}

void draw() {

  Target.x = mouseX;
  Target.y = mouseY;
  /*
  float length0 = Joint0.dist(Joint1);
  float length1 = Target.dist(Joint1);
  float length2 = Joint0.dist(Target);

  float cosAngle0 = ((length2 * length2) + (length0 * length0) - (length1 * length1)) / (2 * length2 * length0);
  float angle0 = degrees( acos(cosAngle0)  );

  float cosAngle1 = ((length1 * length1) + (length0 * length0) - (length2 * length2)) / (2 * length1 * length0);
  float angle1 = degrees( acos(cosAngle1)  );

  PVector diff = Target.sub(Joint0);
  float atan = degrees(atan2(diff.y, diff.x) );

  float jointAngle0 = atan - angle0;    // Angle A
  float jointAngle1 = 180 - angle1;    // Angle B
*/
  // println(jointAngle0, jointAngle1);

  float q2 =  acos( ((Target.x * Target.x) + (Target.y * Target.y) - (arm_len * arm_len) - (arm_len * arm_len) )/(2 * arm_len * arm_len)) ;
  float q1 =  atan(Target.y/Target.x) - atan( (arm_len * sin(q2)) / (arm_len + arm_len * cos(q2) ) ) ;

   // println(degrees(q2),degrees(q1), q2, q1);
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

