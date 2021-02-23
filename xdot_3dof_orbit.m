function xdot = xdot_3dof_orbit(x,mu)
%XDOT_3DOF_ORBIT Equations of motion for orbiting body with 3DOF
%   Inputs are:
%   x      :a numeric array of Mx1 current state vector in m and m/s
%   mu     :an optional scalar gravitational parameter in m^3/s^2 (default
%           earth)
%   
%   Output is:
%   xdot   :a numeric array of Mx1 current xdot vector in m/s and m/s^2

    arguments
        x (:,1) {mustBeNumeric, mustBeReal}
        mu {mustBeNumeric, mustBeReal} = 3.986004418e14
    end
    
    r = norm([x(1),x(2),x(3)]);
    
    xdot = [x(4);
        x(5);
        x(6);
        (-mu*x(1))/(r^3);
        (-mu*x(2))/(r^3);
        (-mu*x(3))/(r^3)];
end

