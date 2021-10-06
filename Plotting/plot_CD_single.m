function plot_CD_single(CD,t)

% figure
plot(t,CD,'LineWidth',1)
grid on
xlabel("time t in seconds")
ylabel("C_D")
title("Coefficient of Drag")
end