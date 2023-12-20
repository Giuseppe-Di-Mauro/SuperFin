%% Acceleration Inverse Kinematics


% Syntax:
% [ddq1,ddq2,ddq3] = acc_inv_kin(ddx,dds,dda,q1,q2,dq1,dq2,dq3,d)
%
% INPUT ARGUMENTS:
% ddx,dds,dda,q1,q2,dq1,dq2,dq3,d
%
% Gets the acceleration of cartesian variables, the pose and velocity of
% joint variables and the length d of the link
% (to calculate the Jacobian and its derivative)
%
% OUTPUT:
% ddq1,ddq2,ddq3
%
% Returns the acceleration of joint variables ddq1, ddq2, ddq3


function [ddq1,ddq2,ddq3] = acc_inv_kin(ddx,dds,dda,q1,q2,dq1,dq2,dq3,d)


% Calculate the Jacobian

J = jacobian_fin(q1,q2,d);


% Calculate the derivative of Jacobian

dJ = d_jacobian_fin(q1,q2,dq1,dq2,d);


% Calculate the joint accelerations

joint_acc = J \ ([ddx;dds;dda] - dJ*[dq1;dq2;dq3]);


% Output

ddq1 = joint_acc(1);
ddq2 = joint_acc(2);
ddq3 = joint_acc(3);


end