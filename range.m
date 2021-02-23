function range = range(LtoD,TSFC,Wwet,Wdry,v)
% RANGE Computes the range when flying at a constant altitude.
%
%   Inputs are:
%   LtoD        :a scalar lift to drag ratio
%   TSFC        :a scalar thrust specific fuel consumption in N/N/s
%   Wwet        :a scalar wet mass in N
%   Wdry        :a scalar dry mass in N
%   v           :a numeric array of Mx1 cruise speed in m/s
%
%   Output is:
%   range       :a numeric array of Mx1 range in m

    arguments
        LtoD {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        TSFC {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        Wwet {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        Wdry {mustBeScalarOrEmpty, mustBeNumeric, mustBeReal}
        v (:,1) {mustBeNumeric, mustBeReal}
    end
    
    range = (v./TSFC).*LtoD.*log(Wwet./Wdry);
end

