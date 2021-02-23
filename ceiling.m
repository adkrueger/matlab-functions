function [absolute, service] = ceiling(W,S,Cd0,K,Tsl)
% CEILING Computes absolute and service ceilings
%   Inputs are:
%   W          :a scalar aircraft weight in N
%   S          :a scalar wing area in m^2
%   Cd0        :a scalar zero-lift drag coefficient
%   K          :a scalar induced drag coefficient
%   Tsl        :a scalar thrust at sea level in N 
%
%   Outputs are:
%   absolute    :a scalar altitude in m at which RC goes to 0  m/s
%   service     :a scalar altitude in m at which RC goes to .508 m/s

    arguments
        W {mustBeNumeric, mustBeReal}
        S {mustBeNumeric, mustBeReal}
        Cd0 {mustBeNumeric, mustBeReal}
        K {mustBeNumeric, mustBeReal}
        Tsl {mustBeNumeric, mustBeReal}
    end
    

    function arg3 = out(W,S,Cd0,K,Tsl,x)
        [~,~,arg3] = steady_climb(W,S,Cd0,K,Tsl,x);
    end

    absolute = fzero(@(h) out(W,S,Cd0,K,Tsl,h),10000);
    service = fzero(@(h) out(W,S,Cd0,K,Tsl,h)-0.508,10000);
end

