function plot_FD_cmp(FD_wo,FD_AA,t_wo,t_AA,metric)

lb2kg = 0.45359237; %pound to kilogram
if(~metric)
    FD_wo = FD_wo/(9.81*lb2kg); %Drag in Pounds
    FD_AA = FD_AA/(9.81*lb2kg); %Drag in Pounds
    str = "Drag force in lb";
else
    str = "Drag force in newton";
end

figure
plot(t_wo,FD_wo)
hold on
plot(t_AA,FD_AA)
grid on
xlabel("time t in seconds")
ylabel(str)
legend("No Active Aero", "With Active Aero");
end