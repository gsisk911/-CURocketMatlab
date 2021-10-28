function plot_h_v_single(v,h,metric)

if(~metric)
    %ft2m = 0.3048; %feet to meters
    %mach = mach.*(1/ft2m);
    str = "altitude";
else
    str = "altitude";
end
% figure
plot(v,h,'LineWidth',1)
grid on
xlabel("velocity")
ylabel(str)
title("")
hold on
end