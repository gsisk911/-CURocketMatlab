%% Rocket Simulation
%This script is a quick & dirty simulation of a rocket model
%restoredefaultpath; %to delete all added paths and avoid unnecessary conflicts with data
clc; close all; clear all;

rocket_no = 3; %choose the rocket to test

% addpath([pwd, '/-CURocketMatlab/CodeBits']); %adds in the folder with necessary functions etc
% addpath([pwd, '/-CURocketMatlab/Plotting']); %adds in the folder with necessary functions etc
% addpath([pwd, '/-CURocketMatlab/Rockets', '/Rocket',num2str(rocket_no)]); %adds in the folder with necessary functions etc
addpath([pwd, '/CodeBits']); %adds in the folder with necessary functions etc
addpath([pwd, '/Plotting']); %adds in the folder with necessary functions etc
addpath([pwd, '/AnalyticDrag']); %adds in the folder with necessary functions etc
addpath([pwd, '/Rockets', '/Rocket',num2str(rocket_no)]); %adds in the folder with necessary functions etc


%% Simulation Parameters & Choices

T_s = 0.01; %sample time
flag_D = 1; %consider drag - 0: no, 1: yes with interpolation of data, 2: yes with analytical data
flag_analytical = 0; %if set, than drag is calculated analytical, else a RAS Aero File is loaded in
flag_AA = 0; %consider active aero - 0: no, 1: yes
flag_plotting = 1; %if you want to see plots in the end
metric =1; %if plotting is to be in metric units, 0 for imperial

%% Variables
% Call several scripts

Conversions %for different types of conversions like feet to meter
Environment %loads environmental data like air density
Rocket_Data %loads the specific rocket data as specified in Rockets/Rocket+"rocket_no"


%% Run simulation

out = sim('RocketSim');
h = out.SimData.pos.Data(:,2);
t = out.SimData.pos.Time(:,1);
v = out.SimData.v.Data(:,1:2);
v_abs = sqrt(v(:,1).^2+v(:,2).^2);
a = out.SimData.a.Data(:,1:2);
a_abs = sqrt(a(:,1).^2+a(:,2).^2);
F_D = out.SimData.F_D.Data(:,1);
C_D = out.SimData.C_D.Data(:,1);
t2 = out.SimData.C_D.Time(:,1);
m = out.SimData.m.Data(:,1);
F_T = out.SimData.thrust.Data(:,1); %along rocket

%% Postprocessing: Additional Calculations
speed_of_sound = (gamma * R .* (h .* temp_increase + initial_temp)).^(1/2);

mach_number = abs(v_abs./speed_of_sound);

%% Plotting
if(flag_plotting)
figure()
subplot(3,1,1)
plot_apogee_single(h,t,metric); %1 indicates: metric scale, 0: imperial
subplot(3,1,2)
plot_v_single(v(:,2),t,metric);
subplot(3,1,3)
plot_a_single(a(:,2),t,metric);

figure()
subplot(2,1,1)
plot_FD_single(F_D,t,metric);
subplot(2,1,2)
plot_CD_single(C_D,t2);

figure()
subplot(2,1,1)
plot_thrust_single(F_T,t2,metric);
subplot(2,1,2)
plot_mass_single(m,t,metric)

figure()
plot_mach_single(mach_number, t)

end


%% Analytic Machnumber Test
num = length(h);
CD_an = zeros(num,1);
M_an = zeros(num,1);

for i = 1:num
[CD_an(i),M_an(i)] = DragCoefficient(h(i),v(i,:),l,l_b,l_nc,d,d_b,S_B,root_chord, tip_chord,S_F,LE,t_f,n_f);

end
figure
plot(t(65:end),CD_an(65:end),'LineWidth',1);
grid on
xlabel("time t")
ylabel("Drag CD")