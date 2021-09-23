%Plot Coefficient of drag
load('Testflight_data.mat');

%over time
figure
plot(data_mat(:,1),data_mat(:,6))
grid on
xlabel("Time t")
ylabel("Draf Coefficient C_D")

%over velocity
figure
plot(data_mat(:,18),data_mat(:,6))
grid on
xlabel("velocity v")
ylabel("Coefficient of Drag C_D")

%over Mach number
figure
plot(data_mat(:,4),data_mat(:,6))
grid on
xlabel("Machnumber Ma")
ylabel("Coefficient of Drag C_D")
