%% Acceleration Direct Kinematics


% Syntax:
% [ddx,dds,dda] = acc_dir_kin(ddq1,ddq2,ddq3,dq1,dq2,dq3,q1,q2,d)
%
% INPUT ARGUMENTS:
% ddq1,ddq2,ddq3,dq1,dq2,dq3,q1,q2,d
%
% Gets the pose, velocity and acceleration of joint variables q1, q2, q3 
% and the length d of the link
%
% OUTPUT:
% ddx,dds,dda
%
% Returns the acceleration of cartesian variables ddx, dds, dda


function [ddx,dds,dda] = acc_dir_kin(ddq1,ddq2,ddq3,dq1,dq2,dq3,q1,q2,d)


% Calculate the Jacobian

J = jacobian_fin(q1,q2,d);


% Calculate the derivative of Jacobian

dJ = d_jacobian_fin(q1,q2,dq1,dq2,d);


% Calculate the cartesian accelerations

cart_acc = J*[ddq1;ddq2;ddq3] + dJ*[dq1;dq2;dq3];


% Output

ddx = cart_acc(1);
dds = cart_acc(2);
dda = cart_acc(3);


end

