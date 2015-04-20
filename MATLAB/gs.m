clc
clear all
close all
%% Maxon 148877  DC
max_voltage = 48;       %[V]
max_current = 4;        %[A]       THIS IS THE PROBLEM
Kt = 60.3E-3;           %[Nm/A]
etaGear = 0.8;          %Gear efficiency
Gear = 5.2;             %Gear ratio
alu_mass = 0.2;         %Weight of the frame [Kg]
motor_mass = 0.5;       %Weight of the motor [Kg]
motor_power = 0.2;      %Weight of the motor control [Kg]
arduino_mass = 0.05;    %Weight of the Arduino [Kg]
extra = 0.2;            %Miscellanious weight [Kg]
M_s = 0.2;              %Flywheel weight [Kg]
Mtot = alu_mass + motor_mass + motor_power + arduino_mass + extra + M_s  %Total mass of cube [Kg]
Ms = M_s;               % massa svänghjul [kg]
l = 0.17;               %Length of the cube frame [m]
g = 9.82;               %Gravitation [Kg*m/s^2]
nf = 7580;              %No load speed [rpm]
V = 48;                 %Nominal voltage [V]
K_emf = 1/158;          %Voltage constant [V/rpm]
eta = 0.9;              %Motor efficiency
Rm = 1.16;              %Motor resistance [Ohm]
rs = l/2-0.01;          %Radius flywheel [m]
Ik = 0.015; %0.004;     %Inertia cube [kgm^2]
Is = Ms*rs^2/2;         %Inertia flywheel [kgm^2]
L = 0.329E-3;           %Motor inductance [H]
J = 138E-7;             %Inertia rotor [kgm^2]

%State space modelling
% Assembly of A matrix
a11 = 0;
a12 = 1;
a13 = 0;

a21 = Mtot * g * l / (sqrt(2) * Ik);
a22 = -Kt * Gear * etaGear * K_emf * eta / (Rm * Ik);
a23 = K_emf * Kt * Gear * etaGear * eta / (Rm * Ik);

a31 = 0;
a32 = Kt * Gear * etaGear * K_emf * eta / (Rm * Is);
a33 = -Kt * Gear * etaGear * K_emf * eta / (Rm * Is);

A = [a11, a12, a13; a21, a22, a23; a31, a32, a33];

% Assembly of B matrix
b1 = 0;
b2 = -Kt * Gear * etaGear * eta / (Rm * Ik);
b3 = Kt * Gear * etaGear * eta / (Rm * Is);

B = [b1; b2; b3];
% "Assembly" of C matrix
%C = [1, 0,0; 0,1,0;0,0,1];
C = [1 0 0; 0 1 0; 0 0 1];

% "Assembly" of D matrix
%D = [0, 0, 0; 0 0 0; 0 0 0];
D = [0; 0; 0];

% Simulink Definitions och annat troll

theta_start = 15 %Startvillkor i grader
rad_start = 0
x0 = [theta_start*pi/180, rad_start, 0]; %startvillkor
X0 = x0;
t = 0:0.01:5;
U = zeros(size(t));





states = {'theta' 'theta_dot' 'phi_dot'};
inputs = {'u'};
outputs = {'theta' 'theta_dot' 'phi_dot'};
% Väljer godtyckliga poler
p0 = -5+5i;
p1 = -5-5i;
p2 = -20;

K = place(A, B, [p0, p1, p2]);
% p = 500;
% Q = p*C'*C
% R = 3;
% [K] = lqr(A,B,Q,R)

% sys_cl = ss(A-B*K,B,C,D, 'statename',states,'inputname',inputs,'outputname',outputs) 
% lsim(sys_cl,U,t,x0)
% 
% % Control Theory
% poles = eig(A)
% sys = ss(A,B,C,D)
% rank(ctrb(sys))
% min_current = Mtot*g*l*sin(theta_start*pi/180)/(sqrt(2)*Kt*eta*etaGear*Gear)


% %% Model validation
% close all
% Motorval = figure
% time = 5;
% t=0:time/length(vel):time-time/length(vel);
% subplot(1,2,1)
% plot (t, vel)
% title('Motor speed')
% xlabel('Time [s]')
% ylabel('Speed [rpm]')
% hold on
% subplot(1,2,2)
% plot(t, Current)
% title('Motor current')
% xlabel('Time [s]')
% ylabel('Current [A]')
