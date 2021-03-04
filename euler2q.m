function q = euler2q(alpha,beta,gamma,seq)
%EULER2Q Convert euler angles to quaternion
%   Inputs are:
%   alpha  :a scalar alpha angle in rad
%   beta   :a scalar beta angle in rad
%   gamma  :a scalar gamma angle in rad
%   seq    :a string rotation sequence (i.e. '313' for classical sequence
%           or '123' for yaw-pitch-roll)
% 
%   Output is:
%   q      :a numeric array of 4x1 quaternion vector (q(4) = scalar part)

    arguments
        alpha {mustBeNumeric, mustBeReal}
        beta {mustBeNumeric, mustBeReal}
        gamma {mustBeNumeric, mustBeReal}
        seq  char
    end

    Q = euler_rot(alpha,beta,gamma,seq);
    q = dcm2q(Q);
end

