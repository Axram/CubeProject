/*int desired_duty;
int IN = 3;  // PWM out on pin
int DIS = 10; // DIGITAL out//PWM out
int INV = 12; // Digital out

int SF  =2; // digital in
int FB = A0;  // analog in pin A0

int8_t previous_voltage;
double previous_voltage

int duty;
*/
/*volatile int state = HIGH;

void stateFlagHigh() {
  //Serial.print ("STATUS ERROR");
  digitalWrite(13, HIGH);
while(1) {
 OCR2B = 0;
 digitalWrite(DIS, HIGH); 
}

}
*/
void pwm_setup(){
//  delay(1000);

  pinMode(13, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(DIS, OUTPUT);
  pinMode(INV, OUTPUT);
  pinMode(SF, INPUT);
//  pinMode(11, OUTPUT);
digitalWrite(INV, HIGH);
  //analogWrite(IN, LOW);
  digitalWrite(DIS, LOW);
  noInterrupts();
  digitalWrite(2, LOW);
  TCCR2A = _BV(COM2B1) | _BV(WGM21) | _BV(WGM20);// pin 11 PWM Phase Correctrd mode 1 _BV(COM2A1) |
  TCCR2B = _BV(WGM22) | _BV(CS21);// prescaler == 1 och top fix
  // TCCR2B = _BV(CS20);
  //OC2A = 50;

//  OCR2A =B11000111; // top 199
  OCR2A = 100;
  //OCR2A =B01111111; // top
  OCR2B = 0;
  interrupts();
//attachInterrupt(SF, stateFlagHigh, CHANGE);
sei();

}
void pwm_write(int duty)
{
  OCR2B = duty;
}