function plot_v_single(v,t,metric)

if(~metric)
    ft2m = 0.3048; %feet to meters
    v = v.*(1/ft2m);
    [max_v,idx] = max(v);
    str2 = ['Maximum velocity at ', num2str(max_v),' ft/s'];
    str = "velocity v in feet/s";
else
    [max_v,idx] = max(v);
    str2 = ['Maximum velocity at ', num2str(max_v),' m/s'];
    str = "velocity v in meter/s";
end
% figure
plot(t,v,'LineWidth',1)
grid on
xlabel("time t in seconds")
ylabel(str)
title("Velocity")
hold on
plot(t(idx),max_v,'rx','LineWidth',1);
disp(str2);
end