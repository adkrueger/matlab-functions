function cruiseT = cruise_thrust(W,LtoD)
% CRUISE_THRUST Thrust required at cruise conditions
%   Inputs are:
%   W       :a scalar aircraft weight in N
%   LtoD    :a numeric array of Mx1 aircraft lift to drag ratio
%
%   Outputs are: 
%   cruiseT :a numeric array of Mx1 cruise thrust in N

    arguments
        W {mustBeNumeric, mustBeReal}
        LtoD (:,1) {mustBeNumeric, mustBeReal}
    end

    cruiseT = W./LtoD;
end

