function  [RC,gamma,maxRC,vmaxRC,gammamaxRC] = steady_climb(W,S,Cd0,K,Tsl,h,v)
% STEADY_CLIMB Steady climb rate and maximum RC with velocity
%   Inputs are:
%   W          :a scalar aircraft weight in N
%   S          :a scalar wing area in m^2
%   Cd0        :a scalar zero-lift drag coefficient
%   K          :a scalar induced drag coefficient
%   Tsl        :a scalar thrust at sea level in N
%   h          :a numeric array of Mx1 aircraft altitude in m
%   v          :an optional numeric array of Mx1 aircraft velocity in m/s
% 
%   Outputs are: 
%   RC         :a numeric array of Mx1 steady climb rate in m/s
%   gammamaxRC :a numeric array of Mx1 climb angle in radians
%   maxRC      :a numeric array of Mx1 maximum steady climb rate in m/s
%   vmaxRC     :a numeric array of Mx1 velocity at maximum steady climb 
%               rate in m/s
%   gammamaxRC :a numeric array of Mx1 climb angle at maximum steady climb
%               rate in radians
%   
%   When no v is passed to the function RC and gamma are set to NaN, with
%   the presumption that the arguments will be ignored in the output call.

    arguments
        W {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        S {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        Cd0 {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        K {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        Tsl {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        h (:,1) {mustBeNumeric, mustBeReal}
        v (:,1) {mustBeNumeric, mustBeReal}
    end
    
    [~,~,rho] = stdatm(h); % atmospheric density at altitude (kg/m^3)
    T = Tsl.*(rho./1.225); % thrust at altitude (N)
    TtoW = T./W; % thrust to weight ratio
    
    switch nargin
        case 6
            RC = NaN;
            gamma = NaN;
        case [7,8]
            Q = 0.5.*rho*v.^2; % dynamic pressure (N/m^2)
            RC = v.*(TtoW-((Q.*Cd0)./(W./S))-(W./S).*(K./Q));
            gamma = asin(RC./v);
    end
    
    [~,maxLtoD] = LtoD_ratio(W,S,Cd0,K,h); % maximum L/D
    
    Z = 1+sqrt(1+(3./((maxLtoD.^2).*(TtoW.^2))));
    maxRC = sqrt(((W./S).*Z)/(3.*rho.*Cd0)).*(TtoW.^(3./2)).*(1-(Z./6)-(3./(2.*(TtoW.^2).*(maxLtoD.^2).*Z)));
    vmaxRC = sqrt((TtoW.*(W./S).*Z)./(3.*rho.*Cd0));
    gammamaxRC = asin(maxRC./vmaxRC);
end

