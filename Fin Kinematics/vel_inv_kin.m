%% Velocity Inverse Kinematics


% Syntax:
% [dq1,dq2,dq3] = vel_inv_kin(dx,ds,da,q1,q2,d)
%
% INPUT ARGUMENTS:
% dx,ds,da,q1,q2,d
%
% Gets the velocity of cartesian variables, the pose of joint variables and
% the length d of the link (to calculate the Jacobian).
%
% OUTPUT:
% dq1,dq2,dq3
%
% Returns the velocity of joint variables dq1, dq2, dq3


function [dq1,dq2,dq3] = vel_inv_kin(dx,ds,da,q1,q2,d)

% Calculate the Jacobian

J = jacobian_fin(q1,q2,d);


% Calculate the joint velocities

joint_vel = J\[dx;ds;da];


% Output

dq1 = joint_vel(1);
dq2 = joint_vel(2);
dq3 = joint_vel(3);


end



