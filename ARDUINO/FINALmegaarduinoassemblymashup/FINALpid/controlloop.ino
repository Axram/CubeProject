// Control loop for ze cube

void pid_set(double Kp, double Ki, double Kd)
{
  kp = Kp;
  ki = Ki;
  kd = Kd;  
}

double pid_compute(){
  //
  unsigned long now = millis();
  double timeChange = (double)(now-lastTime);
  
  //
  //double error = setpoint - input;
  double error = reference - startControlAngle;
  errSum += (error* timeChange);
  double dErr = (error - lastErr) / timeChange;

  //
  output = kp * error + ki * errSum + kd * dErr;

  //
  lastErr = error;
  lastTime = now;
  
    // Dangerous stuff
  if( output> 35 ){
    output = 35;
  }
  if(output<-35) {
    output = -35;
  }
  
 
  
  
  return output;
}
// Ze olde state space

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
