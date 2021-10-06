function plot_thrust_single(F_T,t,metric)

lb2kg = 0.45359237; %pound to kilogram
if(~metric)
    F_T = F_T/(9.81*lb2kg); %Thrust in Pounds
    [max_FT,idx] = max(F_T);
    str2 = ['Maximumg thrust at ', num2str(max_FT),' pounds'];
    str = "Thrust force in lb";
else
    [max_FT,idx] = max(F_T);
    str2 = ['Maximumg thrust at ', num2str(max_FT),' Newton'];
    str = "Thrust force in newton";
end

% figure
plot(t,F_T,'LineWidth',1)
grid on
xlabel("time t in seconds")
ylabel(str)
title("Thrust Force")
hold on
plot(t(idx),max_FT,'rx','LineWidth',1);
disp(str2);
end