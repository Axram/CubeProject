intPWM_out_pin=9; // Mustbeoneof3,5,6,9,10,or11 // for Arduino Uno
void setup() {
pinMode(PWM_out_pin, OUTPUT);
}
void loop() {
byte PWM_out_level;
PWM_out_level = ...  //  Code logic to set output level
analogWrite( PWM_out_pin, PWM_out_level);
}
