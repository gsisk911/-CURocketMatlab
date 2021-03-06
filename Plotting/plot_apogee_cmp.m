function plot_apogee_cmp(h_wo,h_AA,t_wo,t_AA,metric)

if(~metric)
    ft2m = 0.3048; %feet to meters
    h_wo = h_wo.*(1/ft2m);
    h_AA = h_AA.*(1/ft2m);
    str = "height h in feet";
else
    
    str = "height h in meter";
end
figure
plot(t_wo,h_wo)
hold on
plot(t_AA,h_AA)
grid on
xlabel("time t in seconds")
ylabel(str)
legend("No Active Aero", "With Active Aero");
end