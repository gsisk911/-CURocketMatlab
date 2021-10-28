function A_R = calcRocketArea(r,n_f,t_f,span_f)

% A_fin = t_f*span_f*0;
A_fin = 0;
A_R = (pi*r^2 + n_f*A_fin); %The rocket tube plus the fins 
%A_R = A_R*0.66; %adjusted to 2/3 of the value, as it comes closer to RAS Aero II
                 %relaxation due to nose cone
end