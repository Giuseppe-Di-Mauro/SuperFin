%% Pose Direct Kinematics


% Syntax:
% [x,s,a] = pos_dir_kin(q1,q2,q3,d)
%
% INPUT ARGUMENTS:
% q1,q2,q3,d
%
% Gets the pose of joint variables and the length d of the link
%
% OUTPUT:
% x,s,a
%
% Returns the pose of cartesian variables


function [x,s,a] = pos_dir_kin(q1,q2,q3,d)

x = d*sin(q1);

s = d*sin(q1) + d*sin(q1+q2);

a = q1 + q2 + q3;

end