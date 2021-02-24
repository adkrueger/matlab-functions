function range = range(aircraft,LtoD,v)
% RANGE Computes the range when flying at a constant altitude.
%   Inputs are:
%   aircraft   :a struct aircraft data in SI
%   LtoD       :a numeric array of 1xN lift to drag ratio
%   v          :a numeric array of 1xN cruise speed in m/s
%
%   Output is:
%   range      :a numeric array of 1xN range in m

    arguments
        aircraft {mustBeA(aircraft,"struct")}
        LtoD (1,:) {mustBeNumeric, mustBeReal}
        v (1,:) {mustBeNumeric, mustBeReal}
    end
    
    TSFC = aircraft.TSFC;
    Wwet = aircraft.W;
    Wdry = aircraft.W-aircraft.W_fuel;
    
    range = (v./TSFC).*LtoD.*log(Wwet./Wdry);
end

