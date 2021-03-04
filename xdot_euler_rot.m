function xdot = xdot_euler_rot(x,u)
%XDOT_ROTATION Rotation of body with euler angles
%   Inputs are:
%   x      :a numeric array of 6x1 current state vector in SI
%           [phi;theta;psi;omega_x;omega_y;omega_z]
%   u      :a numeric array of 6x1 principal moments of inertia in kg*m^2 
%           and applied moment vector in Nm [A;B;C;Mx;My;Mz]
%   
%   Output is:
%   xdot   :a numeric array of 3x1 current xdot vector in SI 
%           [phi_dot;theta_dot;psi_dot;alpha_x;alpha_y;alpha_z]

    arguments
        x (6,1) {mustBeNumeric, mustBeReal}
        u (6,1) {mustBeNumeric, mustBeReal}
    end

    A = u(1);
    B = u(2);
    C = u(3);
    
    xdot = [(1/sin(x(2)))*(x(4)*sin(x(3))+x(5)*cos(x(3)));
        x(4)*cos(x(3))-x(5)*sin(x(3));
        (-1/tan(x(2)))*(x(4)*sin(x(3))+x(5)*cos(x(3)))+x(6);
        (u(4)-(C-B)*x(5)*x(6))/A;
        (u(5)-(A-C)*x(6)*x(4))/B;
        (u(6)-(B-A)*x(4)*x(5))/C];
end


