%% Jacobian fin

% Syntax:
% J = jacobian_fin(q1,q2,d)
%
% INPUT ARGUMENTS:
% q1,q2,d
%
% Gets the pose of joint variables and the length of the link
%
% OUTPUT:
% J
%
% Returns the Jacobian


function J = jacobian_fin(q1,q2,d)


J = [                 d*cos(q1),              0, 0;
    d*cos(q1 + q2) + d*cos(q1), d*cos(q1 + q2), 0;
    1,              1, 1];


end


