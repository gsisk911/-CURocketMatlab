function A_R = calcRocketArea(r,n_f,t_f,span_f)

A_fin = t_f*span_f*0;
A_R = (pi*r^2 + n_f*A_fin)*0.66;
end