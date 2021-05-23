function g = eci_grav(P_LLH)
%ECI_GRAV Magitude of gravitational acceleration based on WGS84 Ellipsoid
%   Input is:
%   P_LLH   :a numeric array of 3x1 position vector in geodetic coordinates 
%       [latitutde,longitude,height] in [rad,rad,m] 
%   Output is:
%   g       :a scalar gravitational acceleration magnitude in m/s^2

    arguments
        P_LLH (3,1) {mustBeNumeric, mustBeReal}
    end
    
    lat = P_LLH(1);
    h = P_LLH(3);
    
    g = 9.7803253359*((1+0.00193185265241*sin(lat)^2)/...
        (sqrt(1-0.00669437999013*sin(lat)^2)))-3.086e-6*h;
end

