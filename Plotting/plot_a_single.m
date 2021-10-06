function plot_a_single(a,t,metric)

if(~metric)
    ft2m = 0.3048; %feet to meters
    a = a.*(1/ft2m);
    str = "acceleration a in feet/s^2";
else
    
    str = "acceleration a in meter/s^2";
end
% figure
plot(t,a,'LineWidth',1)
grid on
xlabel("time t in seconds")
ylabel(str)
title("Acceleration")
end