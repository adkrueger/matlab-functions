function P_ECEF = llh2ecef(P_LLH)
%LLH2ECEF Convert LLH coordiantes of WGS84 to ECEF coordinates
%   Input is:
%   P_LLH   :a numeric array of 3x1 position vector in geodetic coordinates 
%               [latitutde,longitude,height] in [rad,rad,m]
%   Output is:
%   P_ECEF  :a numeric array of 3x1 position vector in ECEF coordinates 
%       [x,y,z] in m 

    arguments 
        P_LLH (3,1) {mustBeNumeric, mustBeReal}
    end

    lat = P_LLH(1); long = P_LLH(2); h = P_LLH(3);
    
%   WGS84 Parameters
    a = 6378137.0;
%       b = 6356752.314245

    e_sq = 0.006694379990198;
    bbdaa = 0.993305620009802;
    
    N = a/sqrt(1-e_sq*sin(lat)^2);
    
    P_ECEF = [(N+h)*cos(lat)*cos(long);
        (N+h)*cos(lat)*sin(long);
        (bbdaa*N+h)*sin(lat)];
end

