function plot_FD_single(CD,t)

figure
plot(t,CD)
grid on
xlabel("time t in seconds")
ylabel("C_D")
title("Coefficient of Drag")
end