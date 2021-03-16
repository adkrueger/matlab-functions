function [r_t,v_t] = cw_prop(r,t,x0,v0,mu)
%CW_PROP Propogate relative velocity using Clohessy–Wiltshire equations
%   Inputs are:
%   r       :a scalar orbital radius in m
%   t       :a scalar time in seconds
%   x0      :a vector (3x1) initial relative position in m
%   v0      :a vector of 3x1 initial relative velocity in m/s
%   mu      :an optional scalar gravitational parameter in m^3/s^2 (default
%           earth)
%   Outputs are:
%   r_t     :a vector of 3x1 final relative position in m
%   v_t     :a vector of 3x1 final relative velocity in m/s
    
    arguments
        r {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        t {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        x0 (3,1) {mustBeNumeric, mustBeReal}
        v0 (3,1) {mustBeNumeric, mustBeReal}
        mu {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal} = 3.98600442e14
    end
    
    [phi_rr,phi_rv,phi_vr,phi_vv] = clohessy_wiltshire(r,t,mu);
    
    r_t = phi_rr*x0+phi_rv*v0;
    v_t = phi_vr*x0+phi_vv*v0;

end

