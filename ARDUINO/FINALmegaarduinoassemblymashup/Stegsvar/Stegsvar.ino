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

volatile float startControlAngle;
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
int i;
volatile float hej;

void setup() {
  imu_setup();
  pwm_setup();
  pid_set(2.8, 0 , 0);  //Bästa K om broms används = 3.5
  i = 0;
  desired_voltage = 0;
Serial.begin(9600);
}
  
//46.14
void loop() {
  hej = 5;
  imu_loop();        // IMU kalman loop
  startControlAngle = kalAngleX-startXangle+46;
  //kalAngle = imu_loop();
  //Serial.println(kalAngleX); Serial.print("\t");
  //Serial.print(gyroXrate); Serial.print("\t")
    Serial.write((const char*)&startControlAngle, 4);
    
    i +=1;
    if(i>100){
      desired_voltage = 6.5;
    }
    
    digitalWrite(INV, HIGH); // direction of motor
    INVdir = HIGH;
    desired_duty = (desired_voltage * 1)*100/24;
    pwm_write(desired_duty);
    //Serial.println(desired_voltage);
    delay(100);
    
  }

