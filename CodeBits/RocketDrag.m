function C_D = RocketDrag(T,data,time)
% this is an interpolation of the drag coefficient of a simulation with RAS
% Aero II
%Inputs: Time T to evaluate, dragdata, time vector of the recorded data
%Output: coefficient of drag C_D

if(T>max(time))
    C_D = mean(data);
    return;
end


    % interpolate:
    t_delta = T-time;
    [min_t,idx] = min(abs(t_delta));
    
    if t_delta(idx) < 0
        p1 = idx-1;
        p2 = idx;
    elseif min_t > 0
        p1 = idx;
        p2 = idx + 1;
    else
        C_D = data(idx);
        return;
    end
    
    C_D = data(p1) + (data(p2)-data(p1))*(T-time(p1))/(time(p2)-time(p1));
end
    