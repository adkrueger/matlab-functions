function [alpha,beta,gamma] = q2euler(q,seq,range)
%Q2EULER Convert quaternion to euler angles
%   Inputs are:
%   q      :a numeric array of 4x1 quaternion vector (q(4) = scalar part)
%   seq    :a string rotation sequence (i.e. '313' for classical sequence
%           or '123' for yaw-pitch-roll)
%   range  :an optional string of desired range ('+/-pi' or '0_2pi'). Default
%           is '+/-pi'
% 
%   Outputs are:
%   alpha  :a scalar alpha angle in rad
%   beta   :a scalar beta angle in rad
%   gamma  :a scalar gamma angle in rad

    arguments
        q (4,1) {mustBeNumeric, mustBeReal}
        seq  char
        range string = '+/-pi'
    end

    Q = q_rot(q);
    
    switch seq
        case '313'
            output = 'euler';
        case '123'
            output = 'ypr';
    end
    [alpha,beta,gamma] = dcm2euler(Q,output,range);
end

