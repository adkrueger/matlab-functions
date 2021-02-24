function glide_range = glide_range(LtoD,h)
% GLIDE_RANGE Glide range for a constant lift to drag ratio  
%   Inputs are:
%   h           :a scalar altitude in m
%   LtoD        :a scalar lift to drag ratio
%
%   Output is:
%   glide_range	:a scalar glide range in m

    arguments
       LtoD {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
       h {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal} 
    end

    glide_range = h*LtoD;
end

