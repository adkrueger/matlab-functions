function [v0,v_f] = cw_rndz(r,t,x0,mu)
%CW_RNDZ Find rendezvous velocities using Clohessy–Wiltshire equations
%   Inputs are:
%   r       :a scalar orbital radius in m
%   t       :a scalar rendezvous time in seconds
%   x0      :a vector (3x1) initial relative position in m
%   mu      :an optional scalar gravitational parameter in m^3/s^2 (default
%           earth)
%   Outputs are:
%   v0      :a vector 3x) initial velocity for rendezvous in m/s
%   v_f     :a vector of 3x1 final relative velocity in m/s

    arguments
        r {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        t {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        x0 (3,1) {mustBeNumeric, mustBeReal}
        mu {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal} = 3.98600442e14
    end
    
    [phi_rr,phi_rv,phi_vr,phi_vv] = clohessy_wiltshire(r,t,mu);
    
    v0 = -phi_rv\phi_rr*x0;
    
    v_f=(phi_vr-phi_vv/phi_rv*phi_rr)*x0;
end

