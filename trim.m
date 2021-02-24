function [alpha,deltae] = trim(aircraft,h,v)
%TRIM Trim AOA and elevator deflection angles
%   Inputs are:
%   aircraft  :a struct aircraft data in SI
%   h         :a numeric array of Mx1 aircraft altitude in m
%   v         :a numeric array of Mx1 aircraft velocity in m/s
% 
%   Outputs are: 
%   alpha     :a numeric array of Mx1 angle of attack in rad
%   deltae    :a numeric array of Mx1 elevator deflection in rad

    arguments
        aircraft {mustBeA(aircraft,"struct")}
        h (:,1) {mustBeNumeric, mustBeReal}
        v (:,1) {mustBeNumeric, mustBeReal}
    end
    
    W = aircraft.W;
    S_w = aircraft.S_w;
    S_t = aircraft.S_t;
    h_cm = aircraft.h_cm;
    h_ac = aircraft.h_ac;
    V_H = aircraft.V_H;
    
    Cl_0 = aircraft.Cl_0;
    Cl_alpha = aircraft.Cl_alpha;
    Cl_deltae_t = aircraft.Cl_deltae_t;
    
    Cm_0 = aircraft.Cm_0;
    Cm_alpha = aircraft.Cm_alpha;
    
    [~,~,rho] = stdatm(h);
    
    Cw = W./(0.5.*rho.*v.^2.*S_w);
    Cl_deltae = (S_t./S_w).*Cl_deltae_t;
    Cm_deltae = Cl_deltae.*(h_cm-h_ac)-Cl_deltae_t.*V_H;
    
    trim_cond = [Cl_alpha,Cl_deltae;Cm_alpha,Cm_deltae]\[Cw-Cl_0;-Cm_0];
    alpha = trim_cond(1);
    deltae = trim_cond(2);
end

