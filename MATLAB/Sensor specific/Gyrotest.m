%% Gyro Z-axis
clear all
clc
close all
s = serial('/dev/cu.usbmodem1411', 'BaudRate', 115200); % Enough Baudrate to get all the readings from the sensor at this sensetivity 
fopen(s); % Open the serial port

%%
%Adjust power savings....
Hz = 95; %Samplerate
min = 60*7;  % Antal minuter vi kör

NumberSamples = Hz*60*min;
for i = 1:NumberSamples   % 17100 samples, about 3 minutes
    GyroData(i) = fscanf(s, '%d');
end

time = 0:1/95:(NumberSamples-1)/95;  %Time vector for the measurements. 95 Hz, 17099 readings.
bias = mean(GyroData); % Unit counts
biasdgs = bias * 0.00875;
GyroDataNoBias = GyroData-bias;
%Clearing the port in all ways....
fclose(s);
delete(s);
clear s
%fclose(instrfind)
