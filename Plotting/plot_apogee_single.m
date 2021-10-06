function plot_apogee_single(h,t,metric)

if(~metric)
    ft2m = 0.3048; %feet to meters
    h = h.*(1/ft2m);
    [max_h,idx] = max(h);
    str2 = ['Apogee at ', num2str(max_h),' feet'];
    str = "height h in feet";
else
    [max_h,idx] = max(h);
    str2 = ['Apogee at ', num2str(max_h),' meter'];
    str = "height h in meter";
end
% figure
plot(t,h,'LineWidth',1)
grid on
xlabel("time t in seconds")
ylabel(str)
title("Apogee plot")
hold on
plot(t(idx),max_h,'rx','LineWidth',1);
disp(str2);

end