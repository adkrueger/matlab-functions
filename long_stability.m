function [Cl_0,Cl_alpha,Cm_0,Cm_alpha] = long_stability(aircraft)
%LONG_STABILITY Longitudinal stability characteristics
%   Inputs are:
%   aircraft  :a struct aircraft data in SI
% 
%   Outputs are: 
%   Cl_0      :a scalar zero AOA lift coefficient
%   Cl_alpha  :a scalar lift curve slope
%   Cm_0      :a scalar zero AOA pitching moment coefficient
%   Cm_alpha  :a scalar pitching moment curve slope

    arguments
        aircraft {mustBeA(aircraft,"struct")}
    end
    
    S_w = aircraft.S_w;
    S_t = aircraft.S_t;
    h_cm = aircraft.h_cm;
    h_ac = aircraft.h_ac;
    V_H = aircraft.V_H;
    
    Cl_0_w = aircraft.Cl_0_w;
    Cl_alpha_w = aircraft.Cl_alpha_w;
    Cl_alpha_t = aircraft.Cl_alpha_t;
    k_epsilon_alpha = aircraft.k_epsilon_alpha;
    i_t = aircraft.i_t;
    epsilon_0 = aircraft.epsilon_0;
    
    Cm_ac_w = aircraft.Cm_ac_w;
    
    Cl_0 = Cl_0_w+(S_t/S_w)*Cl_alpha_t*(i_t-epsilon_0);

    Cl_alpha = (Cl_alpha_w+(S_t/S_w)*Cl_alpha_t*(1-k_epsilon_alpha));
    
    Cm_0 = Cm_ac_w + Cl_0*(h_cm-h_ac)-V_H*Cl_alpha_t*(i_t-epsilon_0);
    
    Cm_alpha = Cl_alpha*(h_cm-h_ac)-V_H*Cl_alpha_t*(1-k_epsilon_alpha);
end

