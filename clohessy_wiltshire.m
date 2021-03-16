function [phi_rr,phi_rv,phi_vr,phi_vv] = ...
    clohessy_wiltshire(r,t,mu)
%CLOHESSY_WILTSHIRE Clohessy–Wiltshire equations
%   Inputs are:
%   r       :an optional scalar orbital radius in m
%   t       :an optional scalar time in seconds
%   mu      :an optional scalar gravitational parameter in m^3/s^2 (default
%           earth)
% 
%   Outputs are:
%   phi_rr  :a numeric array of 3x3 Clohessy–Wiltshire rr matrix
%   phi_rv  :a numeric array of 3x3 Clohessy–Wiltshire rv matrix
%   phi_vr  :a numeric array of 3x3 Clohessy–Wiltshire vr matrix
%   phi_vv  :a numeric array of 3x3 Clohessy–Wiltshire vv matrix

    arguments
        r {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal} = NaN
        t {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal} = NaN
        mu {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal} = 3.98600442e14
    end
    
    n = sqrt(mu/r^3);

    phi_rr_func = @(n,t) [4-3.*cos(n.*t),0,0;
        6.*(sin(n.*t)-n.*t),1,0;
        0,0,cos(n.*t)];
    phi_rv_func = @(n,t) [sin(n.*t)./n,2.*(1-cos(n.*t))./n,0;
        2.*(cos(n.*t)-1)./n,(4.*sin(n.*t)-3.*n.*t)./n,0;
        0,0,sin(n.*t)./n];
    phi_vr_func = @(n,t) [3.*n.*sin(n.*t),0,0;
        6.*n.*(cos(n.*t)-1),0,0;
        0,0,-n.*sin(n.*t)];
    phi_vv_func = @(n,t) [cos(n.*t),2.*sin(n.*t),0;
        -2.*sin(n.*t),4.*cos(n.*t)-3,0;
        0,0,cos(n.*t)];
    
    if isnan(t)
        if isnan(n)
            return
        end
        phi_rr = @(t) phi_rr_func(n,t);
        phi_rv = @(t) phi_rv_func(n,t);
        phi_vr = @(t) phi_vr_func(n,t);
        phi_vv = @(t) phi_vv_func(n,t);
    else
        phi_rr = phi_rr_func(n,t);
        phi_rv = phi_rv_func(n,t);
        phi_vr = phi_vr_func(n,t);
        phi_vv = phi_vv_func(n,t);
    end
    
end

