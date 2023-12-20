%% Pose Inverse Kinematics


% Syntax:
% [q1,q2,q3] = pos_inv_kin(x,s,a,d,sol_number)
%
% INPUT ARGUMENTS:
% x,s,a,d,sol_number
%
% Gets the pose of cartesian variables, the length d of the link and
% the number of the solutions (1, 2, 3 or 4)
%
% OUTPUT:
% q1,q2,q3
%
% Returns the pose of joint variables


function [q1,q2,q3] = pos_inv_kin(x,s,a,d,sol_number)


if sol_number == 1

    q1 = pi - asin(x/d);

    q2 = asin((s - x)/d) - pi + asin(x/d);

    q3 = a - asin((s - x)/d);


elseif sol_number == 2

    q1 = pi - asin(x/d);

    q2 = asin(x/d) - asin((s - x)/d);

    q3 = a - pi + asin((s - x)/d);


elseif sol_number == 3

    q1 = asin(x/d);

    q2 = pi - asin((s - x)/d) - asin(x/d);

    q3 = a - pi + asin((s - x)/d);


elseif sol_number == 4

    q1 = asin(x/d);

    q2 = asin((s - x)/d) - asin(x/d);

    q3 = a - asin((s - x)/d);



else

    error('Error. Input sol_number must be 1, 2, 3 or 4')

end


end


