%% Velocity Direct Kinematics 


% Syntax:
% [dx,ds,da] = vel_dir_kin(dq1,dq2,dq3,q1,q2,d)
% 
% INPUT ARGUMENTS:
% dq1,dq2,dq3,q1,q2,d
% 
% Gets the pose and velocity of joint variables q1, q2 and the length d of
% the link
% 
% OUTPUT:
% dx,ds,da
% 
% Returns the velocity of cartesian variables dx, ds, da


function [dx,ds,da] = vel_dir_kin(dq1,dq2,dq3,q1,q2,d)


% Calculate the Jacobian 

J = jacobian_fin(q1,q2,d);


% Calculate the cartesian velocities

cart_vel = J*[dq1;dq2;dq3];


% Output

dx = cart_vel(1);
ds = cart_vel(2);
da = cart_vel(3);


end


