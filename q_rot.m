function Q = q_rot(q)
%Q_ROT Quaternion rotation matrix
%   Inputs are:
%   q      :a numeric array of 4x1 quaternion vector (q(4) = scalar part)
% 
%   Output is:
%   Q      :a numeric array of 3x3 direction cosine matrix
% 
%   Reference: ISBN 9780323853453, Algorithm 11.1

    arguments
        q (4,1) {mustBeNumeric, mustBeReal}
    end

    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    q4 = q(4);
    
    Q = [q1^2-q2^2-q3^2+q4^2,2*(q1*q2+q3*q4),2*(q1*q3-q2*q4);
         2*(q1*q2-q3*q4),-q1^2+q2^2-q3^2+q4^2,2*(q2*q3+q1*q4);
         2*(q1*q3+q2*q4),2*(q2*q3-q1*q4),-q1^2-q2^2+q3^2+q4^2];
end

