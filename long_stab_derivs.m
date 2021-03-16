function [X,Z,M] = long_stab_derivs(aircraft,h,v,theta)
%LONG_STAB_DERIVS Longitudinal Dimensional Stability Derivatives
%   Inputs are:
%   aircraft   :a struct aircraft data in SI
%   h          :a numeric array of 1xN altitude in m
%   v          :a numeric array of 1xN velocity in m/s
%   theta      :a numeric array of 1xN angle of attack in rad
% 
%   Outputs are:
%   X          :a numeric array of 1xN axial force components in SI
%   Z          :a numeric array of 1xN vertical force components in SI
%   M          :a numeric array of 1xN pitching moment components in SI

    arguments
        aircraft {mustBeA(aircraft,"struct")}
        h (1,:) {mustBeNumeric, mustBeReal}
        v (1,:) {mustBeNumeric, mustBeReal}
        theta (1,:) {mustBeNumeric, mustBeReal}
    end
    
    m = aircraft.W/9.80665;
    S = aircraft.S_w;
    c = aircraft.c;
    
    Cl = aircraft.Cl_0 + aircraft.Cl_alpha*theta;
    Cd = aircraft.Cd_0 + aircraft.Cd_alpha*theta;
    
    Cl_u = aircraft.Cl_u;
    Cl_alpha = aircraft.Cl_alpha;
    Cl_alphadot = aircraft.Cl_alphadot;
    
    Cd_u = aircraft.Cd_u;
    Cd_alpha = aircraft.Cd_alpha;
    
    Cm_u = aircraft.Cm_u;
    Cm_q = aircraft.Cm_q;
    Cm_alpha = aircraft.Cm_alpha;
    Cm_alphadot = aircraft.Cm_alphadot;
    
    [~,~,rho] = stdatm(h);
    
    X_u = 2.*((m.*9.81)./v).*sin(theta)-0.5.*rho.*v.*S.*(Cd_u+2.*Cd);
    X_w = 0.5.*rho.*v.*S.*(Cl-Cd_alpha);
    X_q = 0;
    X_wdot = 0;
    X = [X_u,X_w,X_q,X_wdot];
    
    Z_u = -2.*((m.*9.81)./v).*cos(theta)-0.5.*rho.*v.*S.*(Cl_u+2.*Cl);
    Z_w = -0.5.*rho.*v.*S.*(Cd-Cl_alpha);
    Z_q = -0.25.*rho.*v.*S.*c.*Cm_u;
    Z_wdot = -0.25.*rho.*S.*c.*Cl_alphadot;
    Z = [Z_u,Z_w,Z_q,Z_wdot];
    
    M_u = 0.5.*rho.*v.*S.*c.*Cm_u;
    M_w = 0.5.*rho.*v.*S.*c.*Cm_alpha;
    M_q = 0.25.*rho.*v.*S.*(c.^2).*Cm_q;
    M_wdot = 0.25.*rho.*S.*(c.^2).*Cm_alphadot;
    M = [M_u,M_w,M_q,M_wdot];
end

