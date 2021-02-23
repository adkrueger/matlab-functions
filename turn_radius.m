function radius = turn_radius(W,S,Cd0,Clmax,K,Tsl,nmax_s,h,v)
% TURN_RADIUS Finds the minimum turning radius given aircraft parameters
%             as well as the cruise conditions.
%   Inputs are:
%   W          :a scalar aircraft weight in N
%   S          :a scalar wing area in m^2
%   Cd0        :a scalar zero-lift drag coefficient
%   Clmax      :a scalar maximum lift coeficient
%   K          :a scalar induced drag coefficient
%   T_max_sl   :a scalar maximum thrust at sea level in N 
%   nmax_s     :a scalar structural limit provided by structural analysis
%   h          :a numeric array of Mx1 altitude in m
%   v          :a numeric array of Mx1 cruise speed in m/s
%
%   Output is:
%   radius     :a numeric array of Mx1 minimum turn radius in m

    arguments
        W {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        S {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        Cd0 {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        Clmax {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        K {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        Tsl {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        nmax_s {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        h (:,1) {mustBeNumeric, mustBeReal}
        v (:,1) {mustBeNumeric, mustBeReal}
    end

    if length(h) == 1 && length(v) > 1
        h = h.*ones(length(v));
    elseif length(v) == 1 && length(h) > 1
        v = v.*ones(length(v));
    elseif length(h) ~= length(v)
        error('Incompatible h and v array sizes')
    end

    [~,~,rho] = stdatm(h); % atmospheric density at altitude (kg/m^3)
    Q = 0.5.*rho.*v.^2; % dynamic pressure (N/m^2)
    T = Tsl.*(rho./1.225); % thrust at altitude (N)

    nmax_s = nmax_s.*ones(1,length(h));
    nmax_t = sqrt((Q./(K.*W./S)).*((T./W)-((Q.*Cd0)./(W./S))));
    nmax_alpha = (Q.*Clmax)./(W./S);
    
    radius = zeros(1,length(h));
    for i = 1:length(h)
        n = [nmax_s(i);nmax_t(i);nmax_alpha(i)];
        radius(i) = (v(i).^2)./(9.81.*sqrt((min(n).^2)-1));
    end
end

