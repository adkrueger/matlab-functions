function cruiseT = cruise_thrust(aircraft,LtoD)
% CRUISE_THRUST Thrust required at cruise conditions
%   Inputs are:
%   aircraft   :a struct aircraft data in SI
%   LtoD       :a numeric array of Mx1 aircraft lift to drag ratio
%
%   Outputs are: 
%   cruiseT    :a numeric array of Mx1 cruise thrust in N

    arguments
        aircraft {mustBeA(aircraft,"struct")}
        LtoD (:,1) {mustBeNumeric, mustBeReal}
    end
    
    W = aircraft.W;

    cruiseT = W./LtoD;
end

