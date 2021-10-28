%% Analytic function to calculate the zero lift drag coefficient
%we follow a guide found online called " Drag Coefficient Prediction"
function [CD,M] = DragCoefficient(h_met,v_met,l,l_b,l_nc,d,d_b,S_B,l_rootchord, l_tipchord,S_F,X_tc,t_fins,nf)
%Inputs:
%h_met - height in meter
%v_met - velocity vector in metric units
%l - length of the rocket
%d - maximum rocket diameter (tube diameter)
%S_B - total wetted surface of the body of the rocket in stream
%l_rootchord - length of the fins rootchord
%l_tipchord - length of the fins tip chord
%S_F - total wetted surface of the fins
%X_tc - distance form fin leading edge to maximum distance, also denoted LE
%n_f - number of fins

%Outputs
% CD - total coefficient of drag
% M - mach number

Conversions %to get all necessary conversion factors
h = h_met/ft2m;
v = v_met./ft2m;
v_abs = norm(v); 


l=l/ft2m;
l_b = l_b/ft2m;
l_nc = l_nc/ft2m;
d=d/ft2m;
d_b=d_b/ft2m
S_B = S_B/(ft2m^2);
l_rootchord = l_rootchord/ft2m;
l_tipchord = l_tipchord/ft2m;
S_F = S_F/(ft2m^2);
X_tc = X_tc/ft2m;
t_fins = t_fins/ft2m;


if(abs(v_abs) < 1e-6)
    CD = 0;
    M = 0;
    return;
end
%% friction drag

    %speed of sound
    v_sound = -0.004*h + 1116.45; %h is height in ft (valid if h <= 37000)
    
    %current Mach number
    M = abs(v_abs./v_sound);
%     M = 143.4*0.0008957066031914082  %Ideal mach number
    
    %kinematic viscosity
    if(h <= 15000)
        a = 0.00002503;
        b = 0.0;
    elseif(h<=30000)
        a = 0.00002760;
        b = -0.03417;
    else % h >= 30000 ft
        a = 0.00004664;
        b = -0.6882;
    end
    nu = 0.000157* exp(a*h+b);
    
 %Body Tube
    
    K = 0.0008; %Standard Camouflage Paint
    [Cf_final,Re,Re_comp] = SkinFrictionCoef(l,K,M,nu,v_sound);   
    %Body Coefficient of drag due to skin fricion
    CD_f_body = Cf_final * (1+ 60/((l/d)^3) + 0.0025 * (l/d)) * 4* S_B/(pi*d^2);
    
 %Fins
 
   % Get final skin friction coefficient
   K = 0.0008; %Standard Camouflage Paint
   [Cf_final_fins,Re_fins,Re_comp_fins] = SkinFrictionCoef(l_rootchord,K,M,nu,v_sound);   
    
   %ratio of tip and root chord
   lambda = l_tipchord/l_rootchord;
   
   %Average flat plate skin friction coefficient for each fin panel
        %Cf_lambda = Cf_final_fins * (1+ 0.5646/(log10(Re_fins)))
   Cf_lambda = Cf_final_fins * ((log10(Re_fins))^2.6)/(lambda^2-1) * ...
               (lambda^2/(log10(Re_fins*lambda)^2.6) - 1/(log10(Re_fins)^2.6) + ...
               0.5646 * (lambda^2/(log10(Re_fins*lambda)^3.6) - 1/(log10(Re_fins)^3.6)));
           
        
   %Body Coefficient of drag due to skin fricion
   CD_f_fins= Cf_lambda * (1 + 60* (t_fins/l_rootchord)^4 + ...
                            0.8 * (1+5* (X_tc/l_rootchord)^2)...
                            *(t_fins/l_rootchord))*4*nf*S_F/(pi*d^2);
      
    
    
 %Protuberances
%      K = 0.0012;
%      [Cf_final_P,Re_P,Re_comp_P] = SkinFrictionCoef(l_P,K,M,nu,v_sound)   
%      %Friction Coefficient of protuberance
%      Cf_p = 0.8151 * Cf_final_P * (d_p/l_p)^(-0.1243);
%      %need distance from nose d_p, length of protuberance l_p 
%      
%      %Drag Coefficient of Protuberance
%      CD_f_p = Cf_p * (1+1.798*(sqrt(A_p)/l_p)^(3/2))* 4 * S_P/(pi*d^2);
%      
     %total wetted area S_P, Maximum Crosssection Area of Protuberance
     %Omitted for now
     S_P = 0;
     CD_f_p  = 0;
     
 % Drag due to Excrescencies
    S_R = S_B + S_F *nf + S_P; %total wetted area of the rocket
 
    if(M < 0.78)
        K_e = 0.00038;
    elseif(M <= 1.04)
        K_e = -0.4501*M^4 + 1.5954*M^3 - 2.1062*M^2 + 1.2288*M - 0.26717;
    else
        K_e = 0.0002 * M^2 - 0.0012*M + 0.0018;
    end
    CD_f_e = K_e * 4 * S_R / (pi*d^2);
    
% Total friction and interference drag coefficient

K_F = 1.04; %mutual interference factor of fins and launch log with body
CD_f = (CD_f_body + K_F * CD_f_fins + K_F * CD_f_p + CD_f_e);


%% Base Drag
%typically described as inversely proportional to the square root of the
%total skinfriction drag coefficient


    %chose second configuration from paper -> L0 = length of body tube
    K_b = 0.0274 * atan2(l_b,d + 0.0116);
    n = 3.6542 * (l_b/d)^(-0.2733); 
    CD_b = K_b * ((d_b/d)^n)/sqrt(CD_f);
    %K_b - constant of proportionality, d_b - base diameter, n - some
    %exponent
if(M>0.6)
    if(M<1)
        f_b = 1 + 215.8*(M-0.6)^6;
    elseif(M<2)
        f_b=2.088*(M-1)^3-3.7938*(M-1)^2+1.4618*(M-1) + 1.883917;
    else
        f_b = 0.297*(M-2)^3 - 0.7937 * (M-2)^2 - 0.1115 * (M-2) + 1.64006;
    end
    CD_b = f_b*CD_b;
end
    


%% Transonic Wave Drag Coefficient
%only use the following function if length of the nose/length of rocket
%Consider Config 2 to be our type -> l_effective = l of whole rocket
    %Transonic drage divergence Mach Number
    M_D = -0.0156 * (l_nc/d)^2 + 0.136 * (l_nc/d) + 0.6817;
    
    %Final Mach Number of Transonic Region
    ratio = l_nc / l;
    if(ratio < 0.2)
        a = 2.4;
        b = -1.05;
    else
        a = -321.94 * ratio^2 + 264.07*ratio - 36.348;
        b = 19.634 * ratio^2 - 18.369 * ratio + 1.7434;
    end
    
    M_F = a* (l/d)^b + 1.0275;
    
    %Maximum drag rise over transonic region
    c = 50.676 * ratio^2 - 51.734 * ratio + 15.642;
    g = -2.2538 * ratio^2 + 1.3108 * ratio - 1.7344;
    if(l/d >= 6)
        Del_CD_max = c * (l/d)^g;
    else
        Del_CD_max = c * 6^g;
    end

    % Transonic drag rise for given drag number
    
    if(M > M_F || M < M_D)
        Del_CD_T = 0;
    else
        x = (M-M_D)/(M_F-M_D);
        F = -8.3474*x^5 + 24.543 * x^4 - 24.946*x^3 + 8.6321*x^2 + 1.1195*x;
        Del_CD_T = Del_CD_max * F;
    end
    
    
%% Supersonic Wave Drag Coefficient
    if(M < M_F)    
        Del_CD_S = 0;
    else
        Del_CD_S = Del_D_max;
    end
    
%% Total Drag Coefficient

CD = CD_f + CD_b + Del_CD_T + Del_CD_S;
end


%% ADDITIONAL FUNCTIONS
    function [Cf_fin,Re,Re_comp] = SkinFrictionCoef(L,K,M,nu,v_sound)   
    %L: characteristic length
    %K: Factor for skin smoothness
        %Smooth Surface: 0.0, Polished Metal or Wood: 0.00002 to 0.00008,
        %Natural Sheet metal: 0.00016, Smoth Matte Paint: 0.00025
        %Standard Camouflage Paint: 0.0004 to 0.0012
    %M: Machnumber
    %nu: kinematic viscosity
    %v_sound: speed of sound
    
    
    %Incompressible Reynoldsnumber
    Re = (v_sound * M * L)/ (12*nu);
    
    %Compressible ReynoldsNumber
    Re_comp = Re * (1 + 0.0283 * M - 0.043*M^2 + 0.2107*M^3 - 0.03829*M^4 + 0.002709 * M^5);
    
    %Incompressible skin friction Coefficient
    Cf_star = 0.037036 * Re_comp^(-0.155079);
    
    %Compressible Skin Friction Coefficient
    Cf = Cf_star * (1 + 0.00798 * M - 0.1813*M^2 + 0.0632*M^3 - 0.00933*M^4 + 0.000549 * M^5);
    
    %Incompressible skin friction coefficient with roughness
    Cf_star_term = 1/((1.89 + 1.62*log10(L/K))^2.5);
    
    %Compressible skin friction coefficient with roughness
    Cf_term = Cf_star_term/(1+0.2044*M^2);
    
    %Final Skinfriction Coefficient
    Cf_fin = max([Cf,Cf_term]); %choose the bigger value
    end