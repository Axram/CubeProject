%% Accelerometer
clear all
clc
close all
%a = arduino('/dev/tty.usbmodem1411');
% a.serial
%a.pinMode('SDA', 'input')
% i = 1;
s1 = serial('/dev/tty.usbmodem1411', 'BaudRate', 9600);
fopen(s1)
while i == 1
    test = fscanf(s1)
%     print test
end
