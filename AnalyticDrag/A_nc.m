function A = A_nc(L,R)

posA = area(L,L,R);
negA = area(0,L,R);
A = posA-negA;

end

function a = area(x,L,R)

rho = (R^2+L^2)/(2*R);
a=0.5*((x-L)*sqrt(rho^2 - (L-x)^2) + rho^2 * atan((x-L)/sqrt(rho^2-(L-x^2)))) + L* (R-rho);
a=a*2*pi;
end