%% Accelerometer
clear all
clc
close all
% a = arduino('/dev/tty.usbmodem1411');
% % a.serial
% a.pinMode('SDA', 'input')

s1 = serial('/dev/tty.usbmodem1411', 'BaudRate',9600)
fopen(s1)
fprintf(s1, 'SDA')
out = fscanf(s1)
