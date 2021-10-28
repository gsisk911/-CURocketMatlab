function plot_mach_single(mach,t)

[max_mach,idx] = max(mach);
str2 = ['Maximum Mach Number:', num2str(max_mach)];
str = "Mach Number";

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