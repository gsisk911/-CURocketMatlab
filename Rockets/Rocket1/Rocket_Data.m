%% Rocket Geometry
%Model 1
%This script defines necessary data of the rocket for calculation

%% Mission parameters:
apogee_d = 30000 * ft2m; %desired apogee in m
launch_angle =  0; % in degrees
theta_0 = (90-launch_angle) *deg2rad; % angle of rocket to ground

%% Propulsion
m_0 = 74 * lb2kg; %zero mass of rocket m_0 = m_PL + m_S + m_P;
m_P = 11.272; % Propulsionmass at t0
t_BO = 6.3; %Burnout in seconds
%m_dot = m_P/t_BO; %average massflow in kg/s

%data from motor test:
t_motor = [0, 0.04, 0.052, 0.101, 0.19, 0.38, 0.965, 2.176, 2.887,3.658, 4.17, 4.493, ...
    4.881, 5.483, 6.137, 6.322];
m_motor = 1e-3.*[11272, 11229.6, 11202.6, 11085.2, 10872.1, 10423.7, 9039.12, 6073.35, 4303.95,...
    2482.87,1511.85,1043.46, 609.199, 207.979, 12.3006, 0];
f_motor = [0, 3959.81, 4432.62, 4515.37, 4420.8, 4391.25, 4444.44, 4698.58, 4592.2, 4225.77,...
    2854.61, 2559.1, 1619.38, 868.794, 248.227, 0];

%% Geometry 
%TO DO: Nose cone

%rocket body
    d = 6*in2m; %diameter of the tube
    l = 98*in2m; %length of the complete rocket
    
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
    
    %active aero - consider trapezoidal shape of fins    
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
    
    phi_0 = 0; %initial position of the AA Fins after Burnout
    phi_const = 90*deg2rad; %constant position of the AA Fins after Burnout
    
%% Drag
if(~flag_analytical)
    %load test data from RAS Aero
    load('Testflight_data.mat');
    C_DR = data_mat(:,6); %from simulation
    t_data = data_mat(:,1); %time from simulation
else
    C_DR = 0; %Call analytica function
end
C_DAA = 1; %Coefficient of drag, random estimate