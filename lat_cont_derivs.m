function [Y_delta,l_delta,N_delta] = lat_cont_derivs(aircraft,h,v)
%LAT_CONT_DERIVS Lateral Dimensional Control Derivatives
%   Inputs are:
%   aircraft   :a struct aircraft data in SI
%   h          :a numeric array of 1xN altitude in m
%   v          :a numeric array of 1xN velocity in m/s
% 
%   Outputs are:
%   Y_delta   :a numeric array of 1xN tail lateral force components in SI
%   l_deltae   :a numeric array of 1xN tail rolling moment components in SI
%   N_deltae   :a numeric array of 1xN tail yawing moment components in SI
    
    arguments
        aircraft {mustBeA(aircraft,"struct")}
        h (1,:) {mustBeNumeric, mustBeReal}
        v (1,:) {mustBeNumeric, mustBeReal}
    end
    
    S = aircraft.S_w;
    b = aircraft.b;
    
    Cy_deltaa = aircraft.Cy_deltaa;
    Cy_deltar = aircraft.Cy_deltar;
    
    Cl_deltaa = aircraft.Cl_deltaa;
    Cl_deltar = aircraft.Cl_deltar;
    
    Cn_deltaa = aircraft.Cn_deltaa;
    Cn_deltar = aircraft.Cn_deltar;
    
    [~,~,rho] = stdatm(h);
    
    Y_deltaa = 0.5.*rho.*(v.^2).*S.*Cy_deltaa;
    Y_deltar = 0.5.*rho.*(v.^2).*S.*Cy_deltar;
    Y_delta = [Y_deltaa,Y_deltar];
    
    l_deltaa = 0.5.*rho.*(v.^2).*S.*b.*Cl_deltaa;
    l_deltar = 0.5.*rho.*(v.^2).*S.*b.*Cl_deltar;
    l_delta = [l_deltaa,l_deltar];
    
    N_deltaa = 0.5.*rho.*(v.^2).*S.*b.*Cn_deltaa;
    N_deltar = 0.5.*rho.*(v.^2).*S.*b.*Cn_deltar;
    N_delta = [N_deltaa,N_deltar];
end

