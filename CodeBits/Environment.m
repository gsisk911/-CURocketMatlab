%% Environmental parameters
    % air density model based on CIRA-72, below 25km
    rho_0 = 1.225; %kg/m^3, density at sea level
    H_0 = 7249000; %m, scale height below 10km, earth radius
    h_0 = 0; %starting height
    R_E = 6378136; %radius of the earth in meter
    g_0 = 9.798; %m/s^2, gravity acceleration parameter
    
    initial_temp = 29+273; %ground Temp in C
    temp_increase = -9.8/1000; %degree per meter
    gamma = 1.4; %ratio of specific heats
    R = 286; % (m^2/s^2/K)