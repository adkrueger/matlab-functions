function [LtoD,maxLtoD,vmaxLtoD] = LtoD_ratio(aircraft,h,v)
% LtoD_RATIO Lift to Drag ratio and maximum L/D with velocity
%   Inputs are:
%   aircraft  :a struct aircraft data in SI
%   h         :a numeric array of 1xN aircraft altitude in m
%   v         :an optional numeric array of 1xN aircraft velocity in m/s
% 
%   Outputs are: 
%   LtoD      :a numeric array of 1xN lift to drag ratio
%   maxLtoD   :a scalar maximum lift to drag ratio for given
%   vmaxLtoD  :a numeric array of 1xN velocity at maximum lift to drag
%              ratio in m/s
%   
%   When no v is passed to the function LtoD is set to NaN, with the
%   presumption that the argument will be ignored in the output call.

    arguments
        aircraft {mustBeA(aircraft,"struct")}
        h (1,:) {mustBeNumeric, mustBeReal}
        v (1,:) {mustBeNumeric, mustBeReal} = NaN
    end

    W = aircraft.W;
    S_w = aircraft.S_w;
    Cd_0 = aircraft.Cd_0;
    K = aircraft.K;
    
    [~,~,rho] = stdatm(h); % atmospheric density at altitude (kg/m^3)
    
    switch nargin
        case 2
            LtoD = NaN;    
        case 3
            Q = 0.5.*rho*v.^2; % dynamic pressure (N/m^2)
            Cl = W./(Q.*S_w); % lift coefficient
            Cd = Cd_0+K.*Cl.^2; % drag coefficient
            LtoD = Cl./Cd;
    end
    
    maxLtoD = 1./sqrt(4.*Cd_0.*K);
    vmaxLtoD = sqrt((2./rho).*(W./S_w).*sqrt(K./Cd_0));
    
end

