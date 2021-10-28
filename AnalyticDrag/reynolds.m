%Function to calculate the reynolds number
function Re = reynolds(rho,v,l,mu)
%rho - density of fluid, 
%v - free stream velocity of the fluid about the vehicle,
%l - characteristic lenght of the vehicle
%mu - absolute coefficient of viscosity
Re = (rho*v*l)/mu;
end