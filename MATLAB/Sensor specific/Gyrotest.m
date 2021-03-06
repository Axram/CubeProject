%% Gyro Z-axis
clear all
clc
close all
s = serial('/dev/cu.usbmodem1411', 'BaudRate', 115200); % Enough Baudrate to get all the readings from the sensor at this sensetivity 
fopen(s); % Open the serial port

%%
%Adjust power savings....
Hz = 440; %Samplerate
min = 30/60;  % Antal minuter vi k�r
disp('start')
tic
NumberSamples = Hz*60*min;
for i = 1:NumberSamples   % 17100 samples, about 3 minutes
    %%AccelData(i) = fscanf(s, '%f');
    GyroData(i) = fscanf(s, '%f');
    %Input(i) = fscanf(s, '%f');
    %%Kalmandata(i) = fscanf(s, '%f');
end
time2 = toc
%timer = time2-time1;
time = 0:1/Hz:(NumberSamples-1)/Hz;  %Time vector for the measurements. 95 Hz, 17099 readings.
time =0:(time2)/NumberSamples:time2-(time2/NumberSamples);
bias = mean(GyroData); % Unit counts
biasdgs = bias * 0.00875;
GyroDataNoBias = GyroData-bias;
%Clearing the port in all ways....
fclose(s);
delete(s);
clear s
%fclose(instrfind)
plot(time, GyroData)
%% 
figure
 plot(time, AccelData-AccelData(1))
 title('90-degree turn comparison')
 ylabel('Angle [degrees]')
 xlabel('Time [s]')
 
 hold on
 plot(time, Kalmandata-Kalmandata(1))
 hold on
 plot(time, GyroData-GyroData(1))
 legend('Accelerometer', 'Kalman', 'Gyroscope')
