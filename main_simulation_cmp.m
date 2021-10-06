%% Rocket Simulation
%This script is a quick & dirty simulation of a rocket model
restoredefaultpath; %to delete all added paths and avoid unnecessary conflicts with data
clc; close all; clear all;

rocket_no = 2; %choose the rocket to test

addpath([pwd, '\CodeBits']); %adds in the folder with necessary functions etc
addpath([pwd, '\Rockets', '\Rocket',num2str(rocket_no)]); %adds in the folder with necessary functions etc


%% Simulation Parameters & Choices

T_s = 0.01; %sample time
flag_D = 1; %consider drag - 0: no, 1: yes with interpolation of data, 2: yes with analytical data
flag_analytical = 0; %if set, than drag is calculated analytical, else a RAS Aero File is loaded in
flag_AA = 0; %consider active aero - 0: no, 1: yes


%% Variables
% Call several scripts

Conversions %for different types of conversions like feet to meter
Environment %loads environmental data like air density
Rocket_Data %loads the specific rocket data as specified in Rockets/Rocket+"rocket_no"


%% Run simulation
%without AA drag
flag_AA = 0;
out_wo = sim('RocketSim');
h_wo = out_wo.SimData.pos.Data(:,2);
F_D_wo = out_wo.SimData.F_D.Data(:,1);
t_wo = out_wo.SimData.pos.Time(:,1);

%with AA drag
flag_AA = 1;
A_AAsmall = t_finAA * span_finAA;
A_AAbig = span_finAA * (l_botAA + l_topAA)/2; %trapezoidal!!
out_AA = sim('RocketSim');
h_AA = out_AA.SimData.pos.Data(:,2);
F_D_AA = out_AA.SimData.F_D.Data(:,1);
t_AA = out_AA.SimData.pos.Time(:,1);

plot_apogee_cmp(h_wo,h_AA,t_wo,t_AA,0);
plot_FD_cmp(F_D_wo,F_D_AA,t_wo,t_AA,0);