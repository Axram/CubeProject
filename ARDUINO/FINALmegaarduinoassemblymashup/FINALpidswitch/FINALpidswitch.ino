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

float lastOutput = 0;


// PWM VARIABLES

int IN = 3;  // PWM out on pin
int DIS = 10; // DIGITAL out//PWM out
int INV = 12; // Digital out

int SF  =2; // digital in
int FB = A0;  // analog in pin A0

double desired_voltage;

//Ska va samma som INV sätts till
int INVdir;

double timer2 = 0;
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
double calibrateAngle = 44;
 //Feedback
double l1 = -3*27;
double l2 = 0;
double l3 = 0;

  //Output

double reference = 0;
double timeChange;
double dErr;
double error;




//Output
float y;
//input
float u;

// Pid stuff from some nisse
unsigned long lastTime;
double input, output, setpoint;
double errSum, lastErr, lastdErr;
double kp, ki, kd;



// Encoder
float phi=0;

int statecase = 1;


void setup() {
  kp = 3;
  ki = 0;
  kd = 0;
  imu_setup();
  pwm_setup();
  pid_set(3, 0.00001 , 2);
  pid_set(kp, ki , kd);
}


void loop() {
  
  switch (statecase) {

    case 1:
    //Serial.print("case 1 ");
    //Serial.println(micros()-timer2);
    //timer2 = micros();
    imu_loop();
    startControlAngle = kalAngleX-startXangle+calibrateAngle;
    errSum = 0;
    lastErr = 0;
    lastdErr = 0;
    //Serial.println(startControlAngle); Serial.print("\t");
    Serial.println(startControlAngle);
    if (startControlAngle < (reference + 1) && startControlAngle > (reference - 1)){
      digitalWrite(DIS , LOW);
      statecase = 2;
    }
    break;
    
    case 2:
    //Serial.println(micros()-timer2);
    //timer2 = micros();
      kd = 5;
      kp = 1;
      //ki = 0.02;
      pid_set(kp, ki , kd);
      
      // prints
      //Serial.print("Time "); Serial.print(timeChange); Serial.print("\t");
      //Serial.print("case 2 "); Serial.print("\t");
      //Serial.print("Kp volt "); Serial.print(kp * error); Serial.print("\t");
      //Serial.print("KD volt "); Serial.print(kd * dErr); Serial.print("\t");
        
         imu_loop();        // IMU kalman loop
        // Control loop
         startControlAngle = kalAngleX-startXangle+calibrateAngle;
         
       //desired_voltage = control_loop();
         desired_voltage = pid_compute();
         Serial.println(startControlAngle);
         //Serial.println(startControlAngle); Serial.print("\t");
         //Serial.print("desired volt "); Serial.print(desired_voltage); Serial.print("\t");

    // PWM THINGS

    //if((millis()-pwmtimer)>=5)  // Main loop runs at 50Hz
    //{
   
      if (startControlAngle < reference + 4 && startControlAngle > reference - 4) {
      // För desired riktning
        if (desired_voltage < 0) {
        //Beroende på tidigare riktning
          if (INVdir == HIGH){
            digitalWrite(INV, HIGH); // direction of motor
            INVdir = HIGH;
            desired_duty = (desired_voltage * -1)*100/24;
            pwm_write(desired_duty);
          }
          else if (INVdir == LOW) {
            secureBrake();
            desired_duty = (desired_voltage * -1)*100/24;
            pwm_write(desired_duty);
            digitalWrite(INV,HIGH);
            INVdir = HIGH;
          }
        }
        if (desired_voltage > 0 ) {
          if (INVdir == HIGH) {
            secureBrake();
            desired_duty = (desired_voltage)*100/24;
            pwm_write(desired_duty);
            digitalWrite(INV, LOW);
            INVdir = LOW; 
          }
          else if (INVdir == LOW) {
            digitalWrite(INV, LOW); // direction of motor
            INVdir = LOW;
            desired_duty = (desired_voltage)*100/24;
            pwm_write(desired_duty);
          }
        }

      }
      
      else if (startControlAngle < reference + 15 && startControlAngle > reference - 15) {
        statecase = 3;
      }
      
      else {
        digitalWrite(DIS , HIGH);
        OCR2B = 0;
        
        statecase = 1;
      }
    break;
    
    case 3:
    //Serial.println(micros()-timer2);
    //timer2 = micros();
      kd = 10; //kd = 20;
      kp = 2; //kp = 2;
      //ki = 0.02;
      pid_set(kp, ki , kd);
      
      //prints
      //Serial.print("Time "); Serial.print(timeChange); Serial.print("\t");
      //Serial.print("case 3 "); Serial.print("\t");
      //Serial.print("Kp volt "); Serial.print(kp * error); Serial.print("\t");
      //Serial.print("KD volt "); Serial.print(kd * dErr); Serial.print("\t");
        
         imu_loop();        // IMU kalman loop
        // Control loop
         startControlAngle = kalAngleX-startXangle+calibrateAngle;
         
       //desired_voltage = control_loop();
         desired_voltage = pid_compute();
         //Serial.println(startControlAngle); Serial.print("\t");
         //Serial.print("desired volt "); Serial.print(desired_voltage); Serial.print("\t");
    Serial.println(startControlAngle);
    // PWM THINGS


      if (startControlAngle < reference + 15 && startControlAngle > reference - 15) {
      // För desired riktning
        if (desired_voltage < 0) {
        //Beroende på tidigare riktning
          if (INVdir == HIGH){
            digitalWrite(INV, HIGH); // direction of motor
            INVdir = HIGH;
            desired_duty = (desired_voltage * -1)*100/24;
            pwm_write(desired_duty);
          }
          else if (INVdir == LOW) {
            secureBrake();
            desired_duty = (desired_voltage * -1)*100/24;
            pwm_write(desired_duty);
            digitalWrite(INV,HIGH);
            INVdir = HIGH;
          }
        }
        if (desired_voltage > 0 ) {
          if (INVdir == HIGH) {
            secureBrake();
            desired_duty = (desired_voltage)*100/24;
            pwm_write(desired_duty);
            digitalWrite(INV, LOW);
            INVdir = LOW; 
          }
          else if (INVdir == LOW) {
            digitalWrite(INV, LOW); // direction of motor
            INVdir = LOW;
            desired_duty = (desired_voltage)*100/24;
            pwm_write(desired_duty);
          }
        }

      }
      
      
      else {
        OCR2B = 0;
        statecase = 1;
      }
     //}
    if (startControlAngle < reference + 3 && startControlAngle > reference - 3) {
        statecase = 2;
      } 
      break;    
  }
}
