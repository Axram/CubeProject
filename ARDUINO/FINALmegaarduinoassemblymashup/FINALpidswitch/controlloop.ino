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
  timeChange = (double)(now-lastTime);
  
  //
  //double error = setpoint - input;
  error = reference - startControlAngle;
  errSum += (error* timeChange);
  
  dErr = (error - lastErr) / timeChange;
  dErr = (dErr+ lastdErr)/2;
  lastdErr = dErr;
  //double dErr = (lastErr - error) / timeChange;

  //
  output = kp * error + ki * errSum + kd * dErr;
  if (abs(output - lastOutput) > 2) {
    output = output*0.5;
  }
  lastOutput = output;
  //
  lastErr = error;
  lastTime = now;
  
    // Dangerous stuff
  if( output> 24 ){
    output = 24;
  }
  if(output<-24) {
    output = -24;
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
