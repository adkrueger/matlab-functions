function v_stall = stall_velocity(aircraft,h)
% STALL_VELOCITY Computes the stall velocity below which, lift 
%   becomes less than weight.
%   Inputs are:
%   aircraft   :a struct aircraft data in SI
%   h          :a numeric array of 1xN aircraft altitude in m
%
%   Output is:
%   v_stall    :a numeric array of 1xN stall velocity in m/s

    arguments
        aircraft {mustBeA(aircraft,"struct")}
        h (1,:) {mustBeNumeric, mustBeReal}
    end
    
    W = aircraft.W;
    S_w = aircraft.S_w;
    Cl_max = aircraft.Cl_max;

    [~,~,rho] = stdatm(h); % atmospheric density at altitude (kg/m^3)
    
    v_stall = sqrt(2.*W./(rho.*S_w.*Cl_max));
end

