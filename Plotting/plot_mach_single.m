function plot_mach_single(mach,t,metric)

if(~metric)
    %ft2m = 0.3048; %feet to meters
    %mach = mach.*(1/ft2m);
    [max_mach,idx] = max(mach);
    str2 = ['Maximum Mach Number ', num2str(max_mach)];
    str = "velocity v in feet/s";
else
    [max_mach,idx] = max(mach);
    str2 = ['Maximum Mach Number ', num2str(max_mach)];
    str = "Mach Number";
end
% figure
plot(t,mach,'LineWidth',1)
grid on
xlabel("time t in seconds")
ylabel(str)
title("Mach Number")
hold on
plot(t(idx),max_mach,'rx','LineWidth',1);
disp(str2);
end