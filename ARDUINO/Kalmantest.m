%%Kalmantest
clear all
clc
close all
s = serial('/dev/tty.usbmodem1411', 'BaudRate', 115200); % Enough Baudrate to get all the readings from the sensor at this sensetivity 
fopen(s); % Open the serial port