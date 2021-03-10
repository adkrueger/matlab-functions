function [A,B] = lin_long_mats(aircraft,v,theta)
%LIN_LONG_MATS Linearized Longitudinal Matrices
%   Inputs are:
%   aircraft   :a struct aircraft data in SI
%   v          :a numeric array of 1xN velocity in m/s
%   theta      :a numeric array of 1xN angle of attack in rad
% 
%   Outputs are:
%   A          :a numeric array of 6x6 linearized A matrix
%   B          :a numeric array of 6x1 linearized B matrix
    
    arguments
        aircraft {mustBeA(aircraft,"struct")}
        v (1,:) {mustBeNumeric, mustBeReal}
        theta (1,:) {mustBeNumeric, mustBeReal}
    end
    
    m = aircraft.W/9.81;
    Iyy = aircraft.Iyy;
    u = v*cos(theta);
    
    X_u = aircraft.X_u;
    X_w = aircraft.X_w;
    X_deltae = aircraft.X_deltae;
    
    Z_u = aircraft.Z_u;
    Z_w = aircraft.Z_w;
    Z_q = aircraft.Z_q;
    Z_wdot = aircraft.Z_wdot;
    Z_deltae = aircraft.Z_deltae;
    
    M_u = aircraft.M_u;
    M_w = aircraft.M_w;
    M_q = aircraft.M_q;
    M_wdot = aircraft.M_wdot;
    M_deltae = aircraft.M_deltae;
    
    Mprime = M_wdot/(m-Z_wdot);
    
    A = [X_u/m,X_w/m,0,-9.81*cos(theta),0,0;
        Z_u/(m-Z_wdot),Z_w/(m-Z_wdot),(Z_q+m*u)/(m-Z_wdot),...
            (-m*9.81*sin(theta))/(m-Z_wdot),0,0;
        (M_u+Mprime*Z_u)/Iyy,(M_w+Mprime*Z_w)/Iyy,...
            (M_q+Mprime*(Z_q+m*u))/(Iyy),(Mprime*m*9.81*sin(theta))/Iyy,0,0;
        0,0,1,0,0,0;
        -sin(theta),cos(theta),0,-v*cos(theta),0,0;
        cos(theta),sin(theta),0,-v*sin(theta),0,0];
    
    B = [X_deltae/m;
        Z_deltae/(m-Z_wdot);
        (M_deltae/Iyy)+(M_wdot*Z_deltae)/(Iyy*(m-Z_wdot));
        0;
        0;
        0];
end

