function P_LLH = ecef2llh_osen(P_ECEF)
%ECEF2LLH_OSEN ECEF to Geodetic conversion using Osen's Method
%   Input is:
%   P_ECEF  :a numeric array of 3x1 position vector in ECEF coordinates 
%       [x,y,z] in m 
%
%   Output is:
%   P_LLH	:a numeric array of 3x1 position vector in geodetic coordinates 
%       [latitutde,longitude,height] in [rad,rad,m] 
% 
%   Reference:
%   Karl Osen. Accurate Conversion of Earth-Fixed Earth-Centered Coordinates to Geodetic Coordinates.
%   [Research Report] Norwegian University of Science and Technology. 2017. ffhal-01704943v2f

    arguments
        P_ECEF (3,1) {mustBeNumeric, mustBeReal}
    end
    
    x = P_ECEF(1);y = P_ECEF(2);z = P_ECEF(3);
    
    invaa = 2.45817225764733181057e-14;
    p1meedaa = 2.44171631847341700642e-14;
    Hmin = 2.25010182030430273673e-14;
    ee = 6.69437999014131705734e-3;
    p1mee = 9.93305620009858682943e-1;

    ww = x^2+y^2;
    l = 0.5*ee;
    ll = l^2;
    m = ww*invaa;
    n = z^2*p1meedaa;
    mpn = m+n;
    p = 0.166666666666667*(mpn-4*ll);
    G = m*n*ll;
    H = 2*p^3+G;
    if H < Hmin
        error('H < Hmin')
    end
    C = nthroot(H+G+2*sqrt(H*G),3)*0.793700525984100;
    i = -ll-0.5*mpn;
    P = p^2;
    beta = 0.333333333333333*i-C-P/C;
    k = ll*(ll-mpn);
    
    t1 = beta*beta-k;
    t2 = sqrt(t1);
    t3 = t2-0.5*(beta+i);
    t4 = sqrt(t3);
    t5 = abs(0.5*(beta-i));
    t6 = sqrt(t5);
%   t7 = (m < n) ? t6 : -t6;
    if m < n
        t7 = t6;
    else
        t7 = -t6;
    end
    t = t4+t7;
    
    j = l*(m-n);
    g = 2*j;
    tt = t^2;
    ttt = t^3;
    tttt = t^4;
    F = tttt+2*i*tt+g*t+k;
    dFdt = 4*ttt+4*i*t+g;
    dt = -F/dFdt;
    
    u = t+dt+l;
    v = t+dt-l;
    w = sqrt(ww);
    zu = z*u;
    wv = w*v;
    lat = atan2(zu,wv);
    
    invuv = 1/(u*v);
    dw = w-wv*invuv;
    dz = z-zu*p1mee*invuv;
    da = sqrt(dw^2+dz^2);
%   h = (u < 1) ? -da : da;
    if u < 1
        h = -da;
    else
        h = da;
    end
    
    long = atan2(y,x);
    
    P_LLH = [lat;long;h];
end

