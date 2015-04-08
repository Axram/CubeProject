%% Gyro all axizes. 
clear all
clc
close all
%a = arduino('/dev/tty.usbmodem1411');
% a.serial
%a.pinMode('SDA', 'input')
% i = 1;
s1 = serial('/dev/tty.usbmodem1411', 'BaudRate', 9600);
fopen(s1)
%figure;
%hold on;
%%
uncalX = [];
uncalY = [];
uncalZ = [];
%timer = tic;
%timer2 = 0;
i = 0;
while i < 250;
    test = fscanf(s1);
    data = strsplit(test);
    %data = cell2mat(data);
    accX = str2num(cell2mat(data(3)));
    %accX = accX + 51.821;
    accY = str2num(cell2mat(data(5)));
    accZ = str2num(cell2mat(data(7)));
    %plot3(accX, accY, accZ, 'o')
    %plot(accX, 'o')
    %drawnow
    uncalX = [uncalX, accX];
    uncalY = [uncalY, accY];
    uncalZ = [uncalZ, accZ];
    i = i +1 ;
end
biasX = mean(uncalX);
biasY = mean(uncalY);
biasZ = mean(uncalZ);

%Unfiltered stable X
t = [1:250];
plot (t, uncalX-biasX)

fclose(s1);
delete(s1);
clear s1
fclose(instrfind)
