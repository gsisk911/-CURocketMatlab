function F_T = thrust(T,t_BO)
% this is an interpolation of the thrust for a certain rocket motor:
% O3400
%Inputs: Time T to evaluate, time of burnout of motort
%Output: thrust at time T in N:  F_T(T)
F_T = 0;
    if(T <= t_BO)
        %data:
        t = [0, 0.04, 0.052, 0.101, 0.19, 0.38, 0.965, 2.176, 2.887,3.658, 4.17, 4.493, ...
            4.881, 5.483, 6.137, 6.322];
        f = [0, 3959.81, 4432.62, 4515.37, 4420.8, 4391.25, 4444.44, 4698.58, 4592.2, 4225.77,...
            2854.61, 2559.1, 1619.38, 868.794, 248.227, 0];


        % interpolate:
        t_delta = T-t;
        [min_t,idx] = min(abs(t_delta));

        if t_delta(idx) < 0
            p1 = idx-1;
            p2 = idx;
        elseif min_t > 0
            p1 = idx;
            p2 = idx + 1;
        else
            F_T = f(idx);
            return;
        end

        F_T = f(p1) + (f(p2)-f(p1))*(T-t(p1))/(t(p2)-t(p1));
    end
end
    