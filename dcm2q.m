function q = dcm2q(Q)
%DCM2Q Convert DCM to quaternion
%   Inputs are:
%   Q      :a numeric array of 3x3 direction cosine matrix
% 
%   Output is:
%   q      :a numeric array of 4x1 quaternion vector (q(4) = scalar part)
% 
%   Reference: ISBN 9780323853453, Algorithm 11.2

    arguments
        Q (3,3) {mustBeNumeric, mustBeReal}
    end
    
    K = [Q(1,1)-Q(2,2)-Q(3,3),Q(2,1)+Q(1,2),Q(3,1)+Q(1,3),Q(2,3)-Q(3,2);
    Q(2,1)+Q(1,2),Q(2,2)-Q(1,1)-Q(3,3),Q(3,2)+Q(2,3),Q(3,1)-Q(1,3);
    Q(3,1)+Q(1,3),Q(3,2)+Q(2,3),Q(3,3)-Q(1,1)-Q(2,2),Q(1,2)-Q(2,1);
    Q(2,3)-Q(3,2),Q(3,1)-Q(1,3),Q(1,2)-Q(2,1),Q(1,1)+Q(2,2)+Q(3,3)]/3;

    [vec,val] = eig(K);
    [~,I] = max(diag(val));
    
    q = vec(:,I);
end

