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
figure;
hold on;
while 1
    test = fscanf(s1);
    data = strsplit(test);
    %data = cell2mat(data);
    accX = str2num(cell2mat(data(3)))
    accY = str2num(cell2mat(data(5)))
    accZ = str2num(cell2mat(data(7)))
    plot3(accX, accY, accZ, 'o')
    %plot(accX, 'o')
    drawnow
end

fclose(s1);
delete(s1);
clear s1
fclose(instrfind)
