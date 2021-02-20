function [alpha,beta,gamma] = dcm_conv(Q,output,range)
%DCM_CONV Convert DCM to classical euler or yaw pitch roll sequence
%   Inputs are:
%   Q      :a numeric array of 3x3 direction cosine matrix
%   output :a string desired output sequence ('euler' or 'ypr')
%   range  :an optional string of desired range ('+/-pi' or '0_2pi'). Default
%           is '+/-pi'
% 
%   Output is:
%   alpha  :a scalar first angle in sequence in rad
%   beta   :a scalar second angle in sequence in rad
%   gamma  :a scalar third angle in sequence in rad
%   
%   Reference: ISBN 9780323853453, Algorithms 4.3 and 4.4
    
    arguments
        Q (3,3) {mustBeNumeric, mustBeReal}
        output string
        range string = '+/-pi'
    end
    
%   Calculates angles based on desired sequence
    switch output
        case 'euler'
            alpha = atan2(Q(3,1),-Q(3,2));         
            beta = acos(Q(3,3));
            gamma = atan2(Q(1,3),Q(2,3));
        case 'ypr'
            alpha = atan2(Q(1,2),Q(1,1));
            beta = asin(-Q(1,3));
            gamma = atan2(Q(2,3),Q(3,3));
        otherwise
            error('Invalid output sequence')
    end

%  Converts angles to correct range
    switch range
        case '+/-pi'
            return
        case '0_2pi'
            alpha = mod(alpha,2*pi);
            beta = mod(beta,2*pi);
            gamma = mod(gamma,2*pi);
        otherwise
            error('Invalid range')
    end
    
end

