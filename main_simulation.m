%% Rocket Simulation
%This script is a quick & dirty simulation of a rocket model
restoredefaultpath; %to delete all added paths and avoid unnecessary conflicts with data
clc; close all; clear all;

rocket_no = 2; %choose the rocket to test

addpath([pwd, '\CodeBits']); %adds in the folder with necessary functions etc
addpath([pwd, '\Plotting']); %adds in the folder with necessary functions etc
addpath([pwd, '\Rockets', '\Rocket',num2str(rocket_no)]); %adds in the folder with necessary functions etc


%% Simulation Parameters & Choices

T_s = 0.01; %sample time
flag_D = 1; %consider drag - 0: no, 1: yes with interpolation of data, 2: yes with analytical data
flag_analytical = 0; %if set, than drag is calculated analytical, else a RAS Aero File is loaded in
flag_AA = 0; %consider active aero - 0: no, 1: yes
flag_plotting = 1; %if you want to see plots in the end
metric = 1; %if plotting is to be in metric units, 0 for imperial


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
end