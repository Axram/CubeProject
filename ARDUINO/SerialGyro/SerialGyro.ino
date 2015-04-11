// Gyro readings for Z-axis

#include <Wire.h>
#include <L3G.h>

L3G gyro;

double starttime;
double waittime = 0;
double inittime;

void setup() {
  Serial.begin(115200); //What should we set this for? (Considering errors and such..)
  Wire.begin();

  if (!gyro.init())
  {
    Serial.println("Failed to autodetect gyro type!");
    while (1);
  }

  gyro.enableDefault();
  //gyro.writeReg(L3G::CTRL_REG5,0X2);   // 95 Hz, Low pass filter of 13 Hz
  inittime = micros(); // Microseconds since the program started 
}

void loop() {
  starttime = micros();
  gyro.read();
  Serial.println((int)gyro.g.z);  //Only sends gyro Z axis deviation
  waittime = waittime + 10500;
  //delay(100);
  while (micros() - inittime < waittime) {  }       // Short delay before next reading
}

