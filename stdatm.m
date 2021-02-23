function [T,P,rho] = stdatm(h)
% STDATM Atmospheric properties based on ISA
%   Inputs are:
%   h      :a numeric array of Mx1 geopotential altitude in m
%
%   Outputs are: 
%   T      :a numeric array of Mx1 air temperature in K
%   P      :a numeric array of Mx1 air pressure in Pa
%   rho    :a numeric array of Mx1 air density in kg/m^3

    arguments
       h (:,1) {mustBeNumeric, mustBeReal} 
    end

    [T,P,rho] = deal(zeros(1,length(h)));
    for i = 1:length(h)
        if h(i) <= 11000
            T(i) = 288.16 + (-6.5e-3).*h(i);
            P(i) = 101.32e3.*(T(i)./288.16).^((-9.81)./((-6.5e-3).*287));
            rho(i) = 1.225.*(T(i)./288.16).^(-1-((9.81)./((-6.5e-3).*287)));
        elseif h(i) <=25000
            T(i) = 216.66;
            P(i) = 22.346.*exp((-9.81.*(h(i)-11000))./(287.*T(i)));
            rho(i) = 0.3642.*exp((-9.81.*(h(i)-11000))./(287.*T(i)));
        end
    end
end

