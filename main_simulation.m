%% Rocket Simulation
%This script is a quick & dirty simulation of a rocket model
clc; close all; clear all;
ft2m = 0.3048; %feet to meters
in2m = 0.0254; %inch to meter
lb2kg = 0.45359237; %pound to kilogram
deg2rad = pi/180; %degree to rad
T_s = 0.01; %sample time

%% considering certain parameters
flag_D = 1; %consider drag - 0: no, 1: yes with interpolation of data, 2: yes with analytical data
flag_AA = 0; %conider active aero - 0: no, 1: yes

%% Variables
%load test data
load('Testflight_data.mat');

% mission parameters:
apogee_d = 30000 * ft2m; %desired apogee in m

% Rocket parameters
m_0 = 74 * lb2kg; %zero mass of rocket m_0 = m_PL + m_S + m_P;
m_P = 11.272; % Propulsionmass at t0
t_BO = 6.3; %Burnout in seconds
%m_dot = m_P/t_BO; %average massflow in kg/s
launch_angle = 0; % in degrees
theta_0 = (90-launch_angle) *deg2rad; % angle of rocket to ground

    %rocket body
    d = 6*in2m;
    l = 98*in2m;
    C_DR = data_mat(:,6); %from simulation
    t_data = data_mat(:,1); %time from simulation
    
    %fins
    n_f = 4;
    t_f = 0.25*in2m;
    span_f = 5.75*in2m;
    tip_chord = 3.8333*in2m;
    d_sweep = 9.2*in2m;
    d_tubebase = 11.5*in2m;
    d_protuberance = 0.5*in2m;
    h_protuberance = 0.5*in2m;
    
    % Area of attack
    A_R = calcRocketArea(d/2,n_f,t_f,span_f);
    
    %active aero - consider trapezoidal shap of fins    
    n_finAA = 4; %for total fins
    t_finAA = 0.25*in2m;
    span_finAA = 2*in2m;
    l_botAA = 2*in2m;
    l_topAA = 1*in2m;
    if(flag_AA)
        A_AAsmall = t_finAA * span_finAA;
        A_AAbig = span_finAA * (l_botAA + l_topAA)/2; %trapezoidal!!
    else
        A_AAsmall = 0;
        A_AAbig = 0;
    end
    C_DAA = 1; %Coefficient of drag, random estimate
    phi_0 = 0;
    phi_const = 90*deg2rad;
    


% environmental parameters
    % air density model based on CIRA-72, below 25km
    rho_0 = 1.225; %kg/m^3, density at sea level
    H_0 = 7249000; %m, scale height below 10km, earth radius
    h_0 = 0; %starting height
    R_E = 6378136; %radius of the earth in meter
    g_0 = 9.798; %m/s^2, gravity acceleration parameter
    
    
    
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

plot_apogee(h_wo,h_AA,t_wo,t_AA,1);
plot_FD(F_D_wo,F_D_AA,t_wo,t_AA);