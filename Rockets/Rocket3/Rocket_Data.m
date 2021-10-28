%% Rocket Geometry
%Model 1
%This script defines necessary data of the rocket for calculation

%% Mission parameters:
apogee_d = 10000 * ft2m; %desired apogee in m
launch_angle =  0; % in degrees
theta_0 = (90-launch_angle) *deg2rad; % angle of rocket to ground

%% Propulsion
m_0 = 60 * lb2kg; %zero mass of rocket m_0 = m_PL + m_S + m_P;
m_P = 9.162; % Propulsionmass at t0
t_BO = 4.85; %Burnout in seconds
%m_dot = m_P/t_BO; %average massflow in kg/s

%data from motor test:
motor_data %calls script that adds mass, force and time vector

%% Geometry 
%TO DO: Nose cone
    d_nc = 6.125*in2m;
    l_nc = 24.5*in2m;
    %Tangent Ogive
%rocket body
    d = 6.125*in2m; %diameter of the tube
    l_t = 66*in2m; %length of the complete rocket
    
    l = l_nc*l_t;
    
    %fins
    n_f = 4;
    t_f = 0.5*in2m;
    span_f = 6*in2m;
    root_chord = 13*in2m;
    tip_chord = 5*in2m;
    d_sweep = 8*in2m;
    d_tubebase = 13*in2m;
    
    %Rail Guide
    d_protuberance = 0.5*in2m;
    h_protuberance = 0.5*in2m;
    %Hex airfoil
   
    
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