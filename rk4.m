function x = rk4(func,h,x)
%RK4 4th Order Runge-Kutta solver
%   Inputs are:
%   func   :a function handle xdot of system
%   dt     :a scalar timestep in seconds
%   x      :a numeric array of Mx1 current state vector
%   
%   Output is:
%   x      :a numeric array of Mx1 updated state vector

    arguments
        func
        h {mustBeNumeric, mustBeReal}
        x (:,1) {mustBeNumeric, mustBeReal}
    end

    k1 = h * func(x);
    k2 = h * func(x + (k1 / 2));
    k3 = h * func(x + (k2 / 2));
    k4 = h * func(x + k3);

    x = x + ((1/6) * (k1 + 2*k2 + 2*k3 + k4));

end

