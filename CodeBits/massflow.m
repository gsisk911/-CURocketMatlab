function m_dot = massflow(T,t_BO)
% this is an interpolation of the massflow for a certain rocket motor:
% O3400
%Inputs: Time T to evaluate, time of burnout of motort
%Output: massflow at time T in kg:  m_dot(T)
m_dot = 0;
if(T <= t_BO)
    %data:
    t = [0, 0.04, 0.052, 0.101, 0.19, 0.38, 0.965, 2.176, 2.887,3.658, 4.17, 4.493, ...
        4.881, 5.483, 6.137, 6.322];
    m = 1e-3.*[11272, 11229.6, 11202.6, 11085.2, 10872.1, 10423.7, 9039.12, 6073.35, 4303.95,...
        2482.87,1511.85,1043.46, 609.199, 207.979, 12.3006, 0];

    m_dot_arr = [0];

    for i=2:length(t)
        m_dot_arr = [m_dot_arr, (m(i)-m(i-1))/(t(i)-t(i-1))];
    end

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
        m_dot = m_dot_arr(idx);
        return;
    end
    
    m_dot = m_dot_arr(p1) + (m_dot_arr(p2)-m_dot_arr(p1))*(T-t(p1))/(t(p2)-t(p1));
end
end
    