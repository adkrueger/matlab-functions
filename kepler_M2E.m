function E = kepler_M2E(e,M,tol)
%KEPLER_M2E Eccentric anomaly from mean anomaly
%   Inputs are:
%   e      :a scalar orbital eccentricy
%   M      :a scalar mean anomaly in rad
%   tol    :an optional scalar solver tolerance
% 
%   Output is:
%   E      :a scalar eccentric anomaly in rad

    arguments
        e {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        M {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        tol {mustBeNumeric, mustBeReal, mustBePositive} = 1e-8
    end
    
    if M < pi
        E = M + e/2;
    else
        E = M - e/2;
    end
    
    ratio = inf;
    while abs(ratio) > tol
        ratio = (E-e*sin(E)-M)/(1-e*cos(E));
        E = E-ratio;
    end
end

