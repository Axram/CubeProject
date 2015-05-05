// Control loop for ze cube



void control_setup(){  
  reference = 0;
  
}
float control_loop() {
  y = l1*startControlAngle*DEG_TO_RAD + l2*gyroXrate*DEG_TO_RAD + l3*phi;     // Ska nog vara radianer
  u = reference - y;
  
  
  // Dangerous stuff
  if( u> 35 ){
    u = 35;
  }
  if(u<-35) {
    u = -35;
  }
  
  return u;
}
