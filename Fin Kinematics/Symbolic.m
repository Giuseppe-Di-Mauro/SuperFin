%% Symbolic

clc
clear
close all


syms q1 q2 q3 x s a d dq1 dq2 dq3 dx ds da 


%% System of equations


eq1 = x - d*sin(q1);

eq2 = s - d*sin(q1) - d*sin(q1+q2);

eq3 = a - q1 - q2 - q3;


% Solve the system

sol = solve([eq1 eq2 eq3], [q1 q2 q3]);


%% Save the solutions


% First solution

q1_sol1 = simplify(sol.q1(1));

q2_sol1 = simplify(sol.q2(1));

q3_sol1 = simplify(sol.q3(1));


% Second solution

q1_sol2 = simplify(sol.q1(2));

q2_sol2 = simplify(sol.q2(2));

q3_sol2 = simplify(sol.q3(2));


% Third solution

q1_sol3 = simplify(sol.q1(3));

q2_sol3 = simplify(sol.q2(3));

q3_sol3 = simplify(sol.q3(3));


% Fourth solution

q1_sol4 = simplify(sol.q1(4));

q2_sol4 = simplify(sol.q2(4));

q3_sol4 = simplify(sol.q3(4));


%% Calculate the Jacobian

J = jacobian([x-eq1, s-eq2, a-eq3], [q1 q2 q3]);

% Note: the last row of J is: 1 1 1
% In fact alpha depends on q1, q2, q3


% Calculate the determinant of J

det_J = det(J);

eq100 = cos(q1 + q2)*cos(q1);

sol100 = solve(eq100, [q1 q2]);

% Note: the determinant is d^2*cos(q1 + q2)*cos(q1),
% so there is singularity (det_J != 0) for q1=pi/2 and q2=0


%% Calculate the derivative of Jacobian


dJ = simplify(diff(J,q1)*dq1 + diff(J,q2)*dq2 + diff(J,q3)*dq3)




