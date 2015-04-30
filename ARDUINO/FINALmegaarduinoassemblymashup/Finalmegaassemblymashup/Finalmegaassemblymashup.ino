#include <Wire.h>
#include <Kalman.h> // Source: https://github.com/TKJElectronics/KalmanFilter

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

uint32_t timer;
uint8_t i2cData[14]; // Buffer for I2C data
float kalAngle;
double gyroXrate;   //Global variable, is not defined in MPU

void setup() {
  imu_setup();
  
  
  
}


void loop() {
  imu_loop();        // IMU kalman loop
  //kalAngle = imu_loop();
  Serial.println(kalAngleX); Serial.print("\t");
  Serial.print(gyroXrate); Serial.print("\t");
  
  
  
  desired_voltage = (int8_t)Serial.read(); // Volt
    if (desired_voltage ==-1)
       {
        desired_voltage = previous_voltage; 
       }
    previous_voltage = desired_voltage;
    if (desired_voltage < 0) {
     digitalWrite(INV, HIGH); // direction of motor
     desired_duty = (desired_voltage * -1)*100/35;
     pwm_write(desired_duty);
    }
    if (desired_voltage > 0 ) {
   digitalWrite(INV, LOW); // direction of motor
     desired_duty = (desired_voltage)*100/35;
     pwm_write(desired_duty);
  
  
  
  
  delay(2);
  
  
}
