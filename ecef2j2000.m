function P_J2000 = ecef2j2000(t,P_ECEF,omega)
%ECEF2J2000 Convert ECEF coordiantes to J2000 coordinates
%   Input is:
%   t       :a scalar number of seconds since January 1, 2000, 11:58:55.816
%               UTC
%   P_ECEF  :a numeric array of 3x1 position vector in ECEF coordinates 
%               [x,y,z] in m 
%   omega   :an optional scalar earth axial rotation speed in rad/s

%   Output is:
%   P_J2000  :a numeric array of 3x1 position vector in J2000 coordinates 
%               [x,y,z] in m 
    
    arguments
        t {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        P_ECEF (3,1) {mustBeNumeric, mustBeReal}
        omega {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal} = 10.*7.2921150e-5
    end
    
    H_g = omega*t;
    
    R_J20002ECEF = [cos(H_g),sin(H_g),0;
        -sin(H_g),cos(H_g),0;
        0,0,1];
    
    P_J2000 = R_J20002ECEF'*P_ECEF;

end
