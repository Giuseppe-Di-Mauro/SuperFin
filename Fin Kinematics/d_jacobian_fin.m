%% Derivative of Jacobian Fin


% Syntax:
% dJ = d_jacobian_fin(q1,q2,dq1,dq2,d)
%
% INPUT ARGUMENTS:
% q1,q2,dq1,dq2,d
%
% Gets the pose and velocity of joint variables and the length of the link
%
% OUTPUT:
% dJ
%
% Returns the derivative of Jacobian


function dJ = d_jacobian_fin(q1,q2,dq1,dq2,d)


dJ = [                                         -d*dq1*sin(q1),                                         0, 0;
    - dq1*(d*sin(q1 + q2) + d*sin(q1)) - d*dq2*sin(q1 + q2), - d*dq1*sin(q1 + q2) - d*dq2*sin(q1 + q2), 0;
    0,                                         0, 0];

end