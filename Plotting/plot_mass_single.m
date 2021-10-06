function plot_mass_single(m,t,metric)

lb2kg = 0.45359237; %pound to kilogram
if(~metric)
    m = m/(lb2kg); %mass in Pounds
    str = "mass in lb";
else
    str = "mass in kilogram";
end

% figure
plot(t,m,'LineWidth',1)
grid on
xlabel("time t in seconds")
ylabel(str)
title("Mass of the rocket")
end