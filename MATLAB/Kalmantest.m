%%Kalmantest
clear all
clc
close all
s = serial('/dev/cu.usbmodem1411', 'BaudRate', 115200); % Enough Baudrate to get all the readings from the sensor at this sensetivity 
fopen(s); % Open the serial port
%Random startvariabler
for i = 1:8
    fscanf(s);
end
numbersamples = 500;
Hz = 50
xvec = [1:numbersamples];
kxvec = [1:numbersamples];
figure;
tic
disp begin
% for i = 1:numbersamples
%     gyrox = fscanf(s);
%     gyroy = fscanf(s);
%     gyroz = fscanf(s);
%     kalmanrad = fscanf(s);
%     gyrox = str2num(gyrox);
%     kal = str2num(kalmanrad);
%     %plot(i,gyrox,'o')
%     %drawnow
%     %hold on
%     xvec(i) = gyrox;
%     kxvec(i) = kal;
% end
% toc
% 
% t = 1:numbersamples;
% plot(t, xvec)
% figure
% plot(t, kxvec)

for i = 1:numbersamples
    gyrox = fscanf(s);
    gyroy = fscanf(s);
    gyroz = fscanf(s);
    kalmanrad = fscanf(s);
    gyrox = str2num(gyrox);
    kal = str2num(kalmanrad);
    plot(i,kal)
    drawnow
    hold on
    %plot(i,gyrox,'o')
    %drawnow
    %hold on
    xvec(i) = gyrox;
    kxvec(i) = kal;
end
toc
figure
t = 1:numbersamples;
t=0:0.02:10-0.02;
plot(t, xvec)
hold on
plot(t, kxvec)
title('Kalman comparison')
ylabel('Angle [degrees]')
legend('Measured position','Kalman estimate')
xlabel('Time [s]')
figure
plot(t, kxvec)


% figure
% for i = 1:numbersamples
%     plot(i,gyrox,'o')
%     %drawnow
%     hold on
% end

fclose(s)
fclose(instrfind)


