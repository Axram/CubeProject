//PWM TEST

int IN = 3;  // PWM out on pin
int DIS = 10; // DIGITAL out//PWM out
int INV = 12; // Digital out

int SF  = 2; // digital in
int FB = A0;  // analog in pin A0
int desired_duty;
int duty;
double desired_voltage;
void setup ()
{
pwm_setup();
desired_voltage = -30;
}


void loop() {
  
      //desired_voltage = Serial.read(); // Volt
    if (desired_voltage <0) {
     digitalWrite(INV, HIGH); // direction of motor
     desired_duty = (desired_voltage * -1)*100/35;
     pwm_write(desired_duty);
    }
    /*if (desired_voltage >0 ) {
   digitalWrite(INV, LOW); // direction of motor
     desired_duty = (desired_voltage)*100/35;
     pwm_write(desired_duty);
    } */
  
  
}

