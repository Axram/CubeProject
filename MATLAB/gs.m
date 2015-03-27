clc
clear all
close all
% %% Maxon 148877  DC
% Kt = 60.3E-3;
% alu_mass = 0.2;
% motor_mass = 0.5;
% motor_power = 0.2;
% arduino_mass = 0.05;
% extra = 0.2;
% M_s = 0.4;   % Svänghjul massa
% Mtot = alu_mass + motor_mass + motor_power + arduino_mass + extra + M_s  %Kub massa
% I_kub = 0.003856;
% 
% l = 0.15;    % sida på kuben
% w_prickkub = 1;  % omegaprick kub
% g = 9.82;
% theta = 15;
% centerl = l * sqrt(2) / 2
% r = 0.15/2-0.01
% % Tröghetsmoment
% I_s = M_s * r^2/2
% 
% I_kub = 0.001856
% Itot = I_s + Mtot* centerl^2/2 + I_kub % M_s* centerl^2 / 2
% 
% Torque_g = (Mtot) * g* l * sind(theta) / sqrt(2)
% Torque_inertia = Itot*w_prickkub
% 
% Moment_needed =  Torque_g + Torque_inertia
% current_needed = Moment_needed / Kt 
% 



% Constatnts
%% Maxon 148877  DC
max_voltage = 48;
max_current = 1;
Kt = 60.3E-3;
alu_mass = 0.2;
motor_mass = 0.5;
motor_power = 0.2;
arduino_mass = 0.05;
extra = 0.2;
M_s = 0.4;   % Svänghjul massa
Mtot = alu_mass + motor_mass + motor_power + arduino_mass + extra + M_s  %Kub massa
Ms = 0.2;           % massa svänghjul [kg]
%Mk = 1.2;           % massa kub [kg]
l = 0.17;           % sidlängd [m]
%Mtot = Ms+Mk;       % totalvikt [kg]
g =9.82;            % gravitation [kg*m/s^2]
nf = 7580;          % no load speed [rpm]
V = 48;             % nätspänning [V]
K_emf = 1/158;          % spänningskonstant [V/rpm]
Kt = 60.3*10^-3;% momentkonstant [N/A]
eta = 0.9;          % verkningsgrad []
Rm = 1.16;          % inre resistans [Ohm]
rs = l/2-0.01;      % radie svänghjul [m]
Ik = 0.004;         % tröghetsmoment kub []
Is = Ms*rs^2/2;     % tröghetsmoment svänghjul []
L = 0.329E-3;        % Induktans motor [H]
J = 138E-7;             % Inertia rotor
% Assembly of A matrix
a11 = 0;
a12 = 1;
a13 = 0;

a21 = Mtot * g * l / (sqrt(2) * Ik);
a22 = -Kt * K_emf * eta / (Rm * Ik);
a23 = K_emf * Kt * eta / (Rm * Ik);

a31 = 0;
a32 = Kt * K_emf * eta / (Rm * Is);
a33 = -Kt * K_emf * eta / (Rm * Is);

A = [a11, a12, a13; a21, a22, a23; a31, a32, a33];

% Assembly of B matrix
b1 = 0;
b2 = -Kt * eta / (Rm * Ik);
b3 = Kt * eta / (Rm * Is);

B = [b1; b2; b3];
% "Assembly" of C matrix
%C = [1, 0,0; 0,1,0;0,0,1];
C = [1 0 0; 0 1 0; 0 0 1];

% "Assembly" of D matrix
%D = [0, 0, 0; 0 0 0; 0 0 0];
D = [0; 0; 0];

% Simulink Definitions och annat troll

theta_start = 35 %Startvillkor i grader
rad_start = 1
x0 = [theta_start*pi/180, rad_start, 0]; %startvillkor
X0 = x0;
t = 0:0.01:5;
U = zeros(size(t));





states = {'theta' 'theta_dot' 'phi_dot'};
inputs = {'u'};
outputs = {'theta' 'theta_dot' 'phi_dot'};
% Väljer godtyckliga poler
p0 = -10+10i;
p1 = -10-10i;
p2 = -40;

%K = place(A, B, [p0, p1, p2]);
p = 500;
Q = p*C'*C
R = 3;
[K] = lqr(A,B,Q,R)

sys_cl = ss(A-B*K,B,C,D, 'statename',states,'inputname',inputs,'outputname',outputs) 
lsim(sys_cl,U,t,x0)

% Control Theory
poles = eig(A)
sys = ss(A,B,C,D)
rank(ctrb(sys))


    