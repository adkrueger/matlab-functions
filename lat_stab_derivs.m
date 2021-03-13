function [Y,l,N] = lat_stab_derivs(aircraft,h,v)
%LAT_STAB_DERIVS Lateral Dimensional Stability Derivatives
%   Inputs are:
%   aircraft   :a struct aircraft data in SI
%   h          :a numeric array of 1xN altitude in m
%   v          :a numeric array of 1xN velocity in m/s
% 
%   Outputs are:
%   Y          :a numeric array of 1xN lateral force components in SI
%   l          :a numeric array of 1xN rolling moment components in SI
%   N          :a numeric array of 1xN yawing moment components in SI
    
    arguments
        aircraft {mustBeA(aircraft,"struct")}
        h (1,:) {mustBeNumeric, mustBeReal}
        v (1,:) {mustBeNumeric, mustBeReal}
    end
    
    S = aircraft.S_w;
    b = aircraft.b;
    
    Cy_beta = aircraft.Cy_beta;
    Cy_p = aircraft.Cy_p;
    Cy_r = aircraft.Cy_r;
    
    Cl_beta = aircraft.Cl_beta;
    Cl_p = aircraft.Cl_p;
    Cl_r = aircraft.Cl_r;
    
    Cn_beta = aircraft.Cn_beta;
    Cn_p = aircraft.Cn_p;
    Cn_r = aircraft.Cn_r;
    
    [~,~,rho] = stdatm(h);
    
    Y_v = 0.5.*rho.*v.*S.*Cy_beta;
    Y_p = 0.25.*rho.*v.*S.*b.*Cy_p;
    Y_r = 0.25.*rho.*v.*S.*b.*Cy_r;
    Y = [Y_v,Y_p,Y_r];
    
    l_v = 0.5.*rho.*v.*S.*b.*Cl_beta;
    l_p = 0.25.*rho.*v.*S.*(b.^2).*Cl_p;
    l_r = 0.25.*rho.*v.*S.*(b.^2).*Cl_r;
    l = [l_v,l_p,l_r];
    
    N_v = 0.5.*rho.*v.*S.*b.*Cn_beta;
    N_p = 0.25.*rho.*v.*S.*(b.^2).*Cn_p;
    N_r = 0.25.*rho.*v.*S.*(b.^2).*Cn_r;
    N = [N_v,N_p,N_r];
end

