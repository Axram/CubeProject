#include <Wire.h>
#include <Kalman.h> // Source: https://github.com/TKJElectronics/KalmanFilter


// KALMAN VARIABLES 
#define RESTRICT_PITCH // Comment out to restrict roll to ±90deg instead - please read: http://www.freescale.com/files/sensors/doc/app_note/AN3461.pdf

Kalman kalmanX; // Create the Kalman instances
Kalman kalmanY;

/* IMU Data */
double accX, accY, accZ;
double gyroX, gyroY, gyroZ;
int16_t tempRaw;

double gyroXangle, gyroYangle; // Angle calculate using the gyro only
double compAngleX, compAngleY; // Calculated angle using a complementary filter
double kalAngleX, kalAngleY; // Calculated angle using a Kalman filter
double startXangle; // Starting angle

uint32_t timer;
uint8_t i2cData[14]; // Buffer for I2C data
float kalAngle;
double gyroXrate;   //Global variable, is not defined in MPU



// PWM VARIABLES

int IN = 3;  // PWM out on pin
int DIS = 10; // DIGITAL out//PWM out
int INV = 12; // Digital out

int SF  =2; // digital in
int FB = A0;  // analog in pin A0

double desired_voltage;

//Ska va samma som INV sätts till
int INVdir;


int desired_duty;

int counter_i=0;
long pwmtimer = 0;
long pwmtimer_old;
volatile int state = HIGH;


//Interrupt function to stop for 
void stateFlagHigh() {
  OCR2B = 0;
  digitalWrite(DIS, HIGH);
  digitalWrite(13, HIGH);
while(1) {
 OCR2B = 0;
 digitalWrite(DIS, HIGH); 
}
}



// Control variables

double startControlAngle;
 //Feedback
  double l1 = -3*27;
  double l2 = 0;
  double l3 = 0;
  
  //Output
  
  double reference = 0;




//Output
float y;
//input
float u;

// Pid stuff from some nisse
unsigned long lastTime;
double input, output, setpoint;
double errSum, lastErr;
double kp, ki, kd;



// Encoder
float phi=0;



void setup() {
  imu_setup();
  pwm_setup();
  pid_set(3.5, 0 , 0);
  
}


void loop() {
  imu_loop();        // IMU kalman loop
  //kalAngle = imu_loop();
  //Serial.println(kalAngleX); Serial.print("\t");
  //Serial.print(gyroXrate); Serial.print("\t");
  
  // Control loop
  startControlAngle = kalAngleX-startXangle+46;
  Serial.println(startControlAngle); Serial.print("\t");
  //desired_voltage = control_loop();
  desired_voltage = pid_compute();
  
  // PWM THINGS
  
  if((millis()-pwmtimer)>=40)  // Main loop runs at 50Hz
  {
    //counter++;
    pwmtimer_old = pwmtimer;
    pwmtimer=millis();
      
   //counter_i +=1;
   if (startControlAngle < reference + 8 && startControlAngle > reference -8) {
    // För desired riktning
    if (desired_voltage < 0) {
      //Beroende på tidigare riktning
      if (INVdir == HIGH){
       digitalWrite(INV, HIGH); // direction of motor
       INVdir = HIGH;
       desired_duty = (desired_voltage * -1)*100/35;
       pwm_write(desired_duty);
      }
      else if (INVdir == LOW) {
        secureBrake();
        desired_duty = (desired_voltage * -1)*100/35;
        pwm_write(desired_duty);
        digitalWrite(INV,HIGH);
        INVdir = HIGH;
      }
    }
    if (desired_voltage > 0 ) {
      if (INVdir == HIGH) {
        secureBrake();
        desired_duty = (desired_voltage)*100/35;
        pwm_write(desired_duty);
        digitalWrite(INV, LOW);
        INVdir = LOW; 
      }
      else if (INVdir == LOW) {
       digitalWrite(INV, LOW); // direction of motor
       INVdir = LOW;
       desired_duty = (desired_voltage)*100/35;
       pwm_write(desired_duty);
      }
    }
   //counter_i = 0;
   //Serial.println("GOOOO");
   }
  else {
  OCR2B = 0;
  //Serial.println("NOOOT");
  }
  }
  Serial.print("desired "); Serial.print(desired_voltage); Serial.print("\t");
  // Serial.print(DIS);
  
  
  delay(10);
  
  
}
