function xdot = xdot_q_rot(x,u)
%XDOT_ROTATION Rotation of body with quaternions
%   Inputs are:
%   x      :a numeric array of 7x1 current state vector
%           [q1;q2;q3;q4;wx;wy;wz];
%   u      :a numeric array of 6x1 principal moments of inertia in kg*m^2 
%           and applied moment vector in Nm [A;B;C;Mx;My;Mz]
%   
%   Output is:
%   xdot   :a numeric array of 3x1 current xdot vector in rad/s^2

    arguments
        x (7,1) {mustBeNumeric, mustBeReal}
        u (6,1) {mustBeNumeric, mustBeReal}
    end

    A = u(1);
    B = u(2);
    C = u(3);
    
    omega = [0,x(7),-x(6),x(5);
        -x(7),0,x(5),x(6);
        x(6),-x(5),0,x(7);
        -x(5),-x(6),-x(7),0];
    
    xdot = [0.5*omega*x(1:4);
        (u(4)-(C-B)*x(6)*x(7))/A;
        (u(5)-(A-C)*x(7)*x(5))/B;
        (u(6)-(B-A)*x(5)*x(6))/C];
end

