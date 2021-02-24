function cruiseT = cruise_thrust(aircraft,LtoD)
% CRUISE_THRUST Thrust required at cruise conditions
%   Inputs are:
%   aircraft   :a struct aircraft data in SI
%   LtoD       :a numeric array of 1xN aircraft lift to drag ratio
%
%   Outputs are: 
%   cruiseT    :a numeric array of 1xN cruise thrust in N

    arguments
        aircraft {mustBeA(aircraft,"struct")}
        LtoD (1,:) {mustBeNumeric, mustBeReal}
    end
    
    W = aircraft.W;

    cruiseT = W./LtoD;
end

