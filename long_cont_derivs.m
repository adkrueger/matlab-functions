function [X_deltae,Z_deltae,M_deltae] = long_cont_derivs(aircraft,h,v)
%LONG_CONT_DERIVS Longitudinal Dimensional Control Derivatives
%   Inputs are:
%   aircraft   :a struct aircraft data in SI
%   h          :a numeric array of 1xN altitude in m
%   v          :a numeric array of 1xN velocity in m/s
% 
%   Outputs are:
%   X_deltae   :a numeric array of 1xN elevator axial force in N
%   Z_deltae   :a numeric array of 1xN elevator vertical force in N
%   M_deltae   :a numeric array of 1xN elevator M pitching moment in Nm
    
    arguments
        aircraft {mustBeA(aircraft,"struct")}
        h (1,:) {mustBeNumeric, mustBeReal}
        v (1,:) {mustBeNumeric, mustBeReal}
    end
    
    S = aircraft.S;
    c = aircraft.c;
    
    Cl_deltae = aircraft.Cl_deltae;
    Cd_deltae = aircraft.Cd_deltae;
    Cm_deltae = aircraft.Cm_deltae;
    
    [~,~,rho] = stdatm(h);
    
    X_deltae = -0.5.*rho.*(v.^2).*S.*Cd_deltae;
    Z_deltae = -0.5.*rho.*(v.^2).*S.*Cl_deltae;
    M_deltae = 0.5.*rho.*(v.^2).*S.*c.*Cm_deltae;
end

