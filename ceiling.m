function [absolute, service] = ceiling(aircraft)
% CEILING Computes absolute and service ceilings
%   Inputs are:
%   aircraft  :a struct aircraft data in SI
%
%   Outputs are:
%   absolute    :a scalar altitude in m at which RC goes to 0  m/s
%   service     :a scalar altitude in m at which RC goes to .508 m/s

    arguments
        aircraft {mustBeA(aircraft,"struct")}
    end

    function arg3 = out(aircraft,x)
        [~,~,arg3] = steady_climb(aircraft,x);
    end

    absolute = fzero(@(h) out(aircraft,h),1000);
    service = fzero(@(h) out(aircraft,h)-0.508,1000);
end

