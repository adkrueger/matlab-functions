function [A,B] = lin_lat_mats(aircraft,v,theta)
%LIN_LAT_MATS Linearized Lateral Matrices
%   Inputs are:
%   aircraft   :a struct aircraft data in SI
%   v          :a numeric array of 1xN velocity in m/s
%   theta      :a numeric array of 1xN angle of attack in rad
% 
%   Outputs are:
%   A          :a numeric array of 6x6 linearized A matrix
%   B          :a numeric array of 6x2 linearized B matrix
    
    arguments
        aircraft {mustBeA(aircraft,"struct")}
        v (1,:) {mustBeNumeric, mustBeReal}
        theta (1,:) {mustBeNumeric, mustBeReal}
    end
    
    m = aircraft.W/9.81;
    Ixx = aircraft.Ixx;
    Izz = aircraft.Izz;
    Ixz = aircraft.Ixz;
    
    Y_v = aircraft.Y_v;
    Y_p = aircraft.Y_p;
    Y_r = aircraft.Y_r;
    Y_deltaa = aircraft.Y_deltaa;
    Y_deltar = aircraft.Y_deltar;
    
    l_v = aircraft.l_v;
    l_p = aircraft.l_p;
    l_r = aircraft.l_r;
    l_deltaa = aircraft.l_deltaa;
    l_deltar = aircraft.l_deltar;
    
    N_v = aircraft.N_v;
    N_p = aircraft.N_p;
    N_r = aircraft.N_r;
    N_deltaa = aircraft.N_deltaa;
    N_deltar = aircraft.N_deltar;
    
    Ixprime = (Ixx*Izz-Ixz^2)/Izz;
    Izprime = (Ixx*Izz-Ixz^2)/Ixx;
    Ixzprime = Ixz/(Ixx*Izz-Ixz^2);
    
    A = [Y_v/m,Y_p/m,-v+(Y_r/m),9.81*cos(theta),0,0;
        (l_v/Ixprime)+Ixzprime*N_v,(l_p/Ixprime)+Ixzprime*N_p,...
            (l_r/Ixprime)+Ixzprime*N_r,0,0,0;
        (N_v/Izprime)+Ixzprime*l_v,(N_p/Izprime)+Ixzprime*l_p,...
            (N_r/Izprime)+Ixzprime*l_r,0,0,0;
        0,1,tan(theta),0,0,0;
        0,0,sec(theta),0,0,0;
        1,0,0,0,v*cos(theta),0];
    
    B = [Y_deltaa/m,Y_deltar/m;
        (l_deltaa/Ixprime)+Ixzprime*N_deltaa,...
            (l_deltar/Ixprime)+Ixzprime*N_deltar;
        (N_deltaa/Ixprime)+Ixzprime*l_deltaa,...
            (N_deltar/Ixprime)+Ixzprime*l_deltar;
            0,0;
            0,0;
            0,0];
end

