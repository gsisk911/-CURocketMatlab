function plot_FD_single(FD,t,metric)

lb2kg = 0.45359237; %pound to kilogram
if(~metric)
    FD = FD/(9.81*lb2kg); %Drag in Pounds
    [max_FD,idx] = max(FD);
    str2 = ['Maximum Drag Force at ', num2str(max_FD),' pounds'];
    str = "Drag force in lb";
else
    [max_FD,idx] = max(FD);
    str2 = ['Maximum Drag Force at ', num2str(max_FD),' Newton'];
    str = "Drag force in newton";
end

% figure
plot(t,FD,'LineWidth',1)
grid on
xlabel("time t in seconds")
ylabel(str)
title("Drag Force")
hold on
plot(t(idx),max_FD,'rx','LineWidth',1);
disp(str2);
end