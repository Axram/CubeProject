%% Gyro Z-axis
clear all
clc
close all
s = serial('/dev/cu.usbmodem1411', 'BaudRate', 115200); % Enough Baudrate to get all the readings from the sensor at this sensetivity 
fopen(s); % Open the serial port

%%
%Adjust power savings....
Hz = 1/0.002; %Samplerate
min = 1/60;  % Antal minuter vi kör
disp('start')
tic
NumberSamples = Hz*60*min;
for i = 1:NumberSamples   % 17100 samples, about 3 minutes
    AccelData(i) = fscanf(s, '%f');
    GyroData(i) = fscanf(s, '%f');
    Kalmandata(i) = fscanf(s, '%f');
end
toc
time = 0:1/Hz:(NumberSamples-1)/Hz;  %Time vector for the measurements. 95 Hz, 17099 readings.
bias = mean(GyroData); % Unit counts
biasdgs = bias * 0.00875;
GyroDataNoBias = GyroData-bias;
%Clearing the port in all ways....
fclose(s);
delete(s);
clear s
%fclose(instrfind)
figure
plot(time, AccelData)
title('90 degree turn comparison')
ylabel('angle [degrees]')
xlabel('time [s]')

hold on
plot(time, Kalmandata)
hold on
plot(time, GyroData)
legend('Accelerometer', 'Kalman', 'Gyroscope')
