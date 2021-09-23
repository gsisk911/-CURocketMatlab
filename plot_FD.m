function plot_FD(FD_wo,FD_AA,t_wo,t_AA)


figure
plot(t_wo,FD_wo)
hold on
plot(t_AA,FD_AA)
grid on
xlabel("time t in seconds")
ylabel("Drag force in newton")
legend("No Active Aero", "With Active Aero");
end