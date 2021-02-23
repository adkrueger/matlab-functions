function v_stall = stall_velocity(W,S,Clmax,h)
% STALL_VELOCITY Computes the stall velocity below which, lift 
%   becomes less than weight.
%   Inputs are:
%   W          :a scalar aircraft weight in N
%   S          :a scalar wing area in m^2
%   Clmax      :a scalar maximum lift coefficient
%   h          :a numeric array of Mx1 aircraft altitude in m
%
%   Output is:
%   v_stall    :a numeric array of Mx1 stall velocity in m/s

    arguments
        W {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        S {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        Clmax {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        h (:,1) {mustBeNumeric, mustBeReal}
    end

    [~,~,rho] = stdatm(h); % atmospheric density at altitude (kg/m^3)
    
    v_stall = sqrt(2.*W./(rho.*S.*Clmax));
end

