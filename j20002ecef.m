function P_ECEF = j20002ecef(t,P_J2000,omega)
%J20002ECEF Convert J2000 coordiantes to ECEF coordinates
%   Input is:
%   t       :a scalar number of seconds since January 1, 2000, 11:58:55.816
%               UTC
%   P_J2000 :a numeric array of 3x1 position vector in J2000 coordinates 
%               [x,y,z] in m
%   omega   :an optional scalar earth axial rotation speed in rad/s
% 
%   Output is:
%   P_ECEF  :a numeric array of 3x1 position vector in ECEF coordinates 
%               [x,y,z] in m 
    
    arguments
        t {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        P_J2000 (3,1) {mustBeNumeric, mustBeReal}
        omega {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal} = 7.2921150e-5
    end
    
    H_g = omega*t;
    
    R_J20002ECEF = [cos(H_g),sin(H_g),0;
        -sin(H_g),cos(H_g),0;
        0,0,1];
    
    P_ECEF = R_J20002ECEF*P_J2000;

end

