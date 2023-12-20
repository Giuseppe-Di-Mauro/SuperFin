%% Plot Fin


% Syntax:
% plot_fin(q1,q2,q3,d,theta)
% 
% INPUT ARGUMENTS:
% q1,q2,q3,d,theta
% 
% Gets the pose of joint variables, the length of the link and the bias theta
% 
% OUTPUT:
% Returns the plot of the fin


function plot_fin(q1,q2,q3,d,theta)


% Plot links

plot([0 d*cos(q1+theta)],[0 d*sin(q1+theta)],'-ok')

hold on

plot([d*cos(q1+theta) d*cos(q1+theta)+d*cos(q1+q2+theta)],[d*sin(q1+theta) d*sin(q1+theta)+d*sin(q1+q2+theta)],'-k')


plot([d*cos(q1+theta)+d*cos(q1+q2+theta) d*cos(q1+theta)+d*cos(q1+q2+theta)+d*cos(q1+q2+q3+theta)], ...
    [d*sin(q1+theta)+d*sin(q1+q2+theta) d*sin(q1+theta)+d*sin(q1+q2+theta)+d*sin(q1+q2+q3+theta)],'-ok')

hold off


end




