%% Main

% clc
% clear
% close all

%% Initialize variables

% Parameters
d = 0.1;                % link length [m]
a0 = deg2rad(23);       % amplitude of a(t) [rad]
s0 = 1.5*0.1;           % amplitude of s(t) [m]

% Geometric parameters of the cam joints
lambda_1 = 0.16;
lambda_2 = 0.16;
lambda_3 = 0.47;

% Initial rotations of the cam joints
delta_1 = 0;
delta_2 = 0;
delta_3 = 2.13;

% Input from simulation
t = simOut.tout;               % time [s]
dt = simOut.SimulationMetadata.ModelInfo.SolverInfo.FixedStepSize;
f = simOut.f_HT3;              % frequency [Hz]
theta = simOut.Thetastr_HT3;   % theta bias [rad]

% Initialize vectors
a_vect = 1:length(t);
s1_vect = 1:length(t);
s2_vect = 1:length(t);

for i=1:length(t)

    % Alpha vector [rad]
    % a_vect = a0*cos(2*pi*f*t+Delta);
    a_vect(i) = lambda_1*cos(2*pi*f(i)*t(i)+delta_1)+lambda_2*cos(2*pi*f(i)*t(i)+delta_2)+lambda_3*cos(2*pi*f(i)*t(i)+delta_3);

    % s1 vector [m]
    s1_vect(i) = d*(lambda_1*cos(2*pi*f(i)*t(i)+delta_1));

    % s2 vector [m]
    % s2_vect = s0*cos(2*pi*f*t);
    s2_vect(i) = d*(lambda_1*cos(2*pi*f(i)*t(i)+delta_1))+d*(lambda_1*cos(2*pi*f(i)*t(i)+delta_1)+lambda_2*cos(2*pi*f(i)*t(i)+delta_2));

end

%% Calculate the velocity of cartesian variables s1,s2,a (first derivative)

% Note: we need to add 1 element to the vector because the function diff
% removes one element, for this reason we'll have a little problem with the graphs

% da
da_vect = diff(a_vect)/dt;
da_vect = [da_vect(1) da_vect];

% ds1
ds1_vect = diff(s1_vect)/dt;
ds1_vect = [ds1_vect(1) ds1_vect];

% ds2
ds2_vect = diff(s2_vect)/dt;
ds2_vect = [ds2_vect(1) ds2_vect];

%% Calculate the acceleration of cartesian variables s1,s2,a (second derivative)

% Note: we need to add 1 element to the vector because the function diff
% removes one element, for this reason we'll have a little problem with the graphs

% dda
dda_vect = diff(da_vect)/dt;
dda_vect = [dda_vect(1) dda_vect];

% dds1
dds1_vect = diff(ds1_vect)/dt;
dds1_vect = [dds1_vect(1) dds1_vect];

% dds2
dds2_vect = diff(ds2_vect)/dt;
dds2_vect = [dds2_vect(1) dds2_vect];

%% Plot pose, velocity and acceleration of cartesian variables s1,s2,a

figure(1)

% Plot s1_vect
subplot(3,3,1)
plot(t, s1_vect)
xlabel('t [s]')
ylabel('s1 [m]')
title('Pos., vel., acc. of s1(t)')

% Plot s2_vect
subplot(3,3,2)
plot(t, s2_vect)
xlabel('t [s]')
ylabel('s2 [m]')
title('Pos., vel., acc. of s2(t)')

% Plot a_vect
subplot(3,3,3)
plot(t ,a_vect)
xlabel('t [s]')
ylabel('a [rad]')
title('Pos., vel., acc. of a(t)')

% Plot ds1_vect
subplot(3,3,4)
plot(t, ds1_vect);
xlabel('t [s]')
ylabel('ds1 [m/s]')

% Plot ds2_vect
subplot(3,3,5)
plot(t, ds2_vect);
xlabel('t [s]')
ylabel('ds2 [m/s]')

% Plot da_vect
subplot(3,3,6)
plot(t, da_vect);
xlabel('t [s]')
ylabel('da [rad/s]')

% Plot dds1_vect
subplot(3,3,7)
plot(t, dds1_vect);
xlabel('t [s]')
ylabel('dds1 [m/s^2]')

% Plot dds2_vect
subplot(3,3,8)
plot(t, dds2_vect);
xlabel('t [s]')
ylabel('dds2 [m/s^2]')

% Plot dda_vect
subplot(3,3,9)
plot(t, dda_vect);
xlabel('t [s]')
ylabel('dda [rad/s^2]')

%% Calculate pose, velocity and acceleration of joint variables q1, q2, q3 and plot the movie

% Initialize vectors
q1_vect = 1:length(t);
q2_vect = 1:length(t);
q3_vect = 1:length(t);
dq1_vect = 1:length(t);
dq2_vect = 1:length(t);
dq3_vect = 1:length(t);
ddq1_vect = 1:length(t);
ddq2_vect = 1:length(t);
ddq3_vect = 1:length(t);
detJ_vect = 1:length(t);

% Plot the "movie"
figure(100)
myVideo = VideoWriter('Moto Pinna'); %open video file
open(myVideo)

% j and step are used to speed up the movie
j=1;
step = floor(length(t)*0.06/simOut.SimulationMetadata.ModelInfo.StopTime);

for i = 1:length(t)

    % Calculate q1, q2, q3 (pose in joint space) for each instance of time
    % note: choose 4 as solution
    [q1_vect(i),q2_vect(i),q3_vect(i)] = pos_inv_kin(s1_vect(i),s2_vect(i),a_vect(i),d,4);

    % Plot Fin
    if j == i
        plot_fin(q1_vect(i),q2_vect(i),q3_vect(i),d,theta(i))

        axis equal
        xlim([0 0.5])
        ylim([-0.3 0.3])
        xlabel('x [m]')
        ylabel('y [m]')

        % Save that frame of plot in F
        F = getframe;
        writeVideo(myVideo, F);

        % Clear the previous frame for a correct movie
        cla
        j=j+step;
    end

    % Calculate dq1, dq2, dq3 (velocities in joint space) for each instance of time
    [dq1_vect(i),dq2_vect(i),dq3_vect(i)] = vel_inv_kin(ds1_vect(i),ds2_vect(i),da_vect(i),q1_vect(i),q2_vect(i),d);

    % Calculate ddq1, ddq2, ddq3 (accelerations in joint space) for each instance of time
    [ddq1_vect(i),ddq2_vect(i),ddq3_vect(i)] = acc_inv_kin(dds1_vect(i),dds2_vect(i),dda_vect(i),q1_vect(i),q2_vect(i),dq1_vect(i),dq2_vect(i),dq3_vect(i),d);

    % Calculate Jacobian for each instance of time
    J = jacobian_fin(q1_vect(i),q2_vect(i),d);

    % Calculate the derivative of Jacobian for each instance of time
    dJ = d_jacobian_fin(q1_vect(i),q2_vect(i),dq1_vect(i),dq2_vect(i),d);

    % Calculate  determinant of J
    detJ_vect(i) = det(J);

end

close(100)
close(myVideo)

%% Plot pose, velocity and acceleration of joint variables q1, q2, q3

figure(3)

% Plot q1_vect
subplot(3,3,1)
plot(t, q1_vect)
xlabel('t [s]')
ylabel('q1 [rad]')
title('Pos., vel., acc. of q1(t)')

% Plot q2_vect
subplot(3,3,2)
plot(t, q2_vect)
xlabel('t [s]')
ylabel('q2 [rad]')
title('Pos., vel., acc. of q2(t)')

% Plot q3_vect
subplot(3,3,3)
plot(t, q3_vect)
xlabel('t [s]')
ylabel('q3 [rad]')
title('Pos., vel., acc. of q3(t)')

% Plot dq1_vect
subplot(3,3,4)
plot(t, dq1_vect);
xlabel('t [s]')
ylabel('dq1 [rad/s]')

% Plot dq2_vect
subplot(3,3,5)
plot(t, dq2_vect);
xlabel('t [s]')
ylabel('dq2 [rad/s]')

% Plot dq3_vect
subplot(3,3,6)
plot(t, dq3_vect);
xlabel('t [s]')
ylabel('dq3 [rad/s]')

% Plot ddq1_vect
subplot(3,3,7)
plot(t, ddq1_vect);
xlabel('t [s]')
ylabel('ddq1 [rad/s^2]')

% Plot ddq2_vect
subplot(3,3,8)
plot(t, ddq2_vect);
xlabel('t [s]')
ylabel('ddq2 [rad/s^2]')

% Plot ddq3_vect
subplot(3,3,9)
plot(t, ddq3_vect);
xlabel('t [s]')
ylabel('ddq3 [rad/s^2]')

%% Plot the Jacobian

figure(4)
plot(t,detJ_vect,'r')
title("Determinant of the Jacobian")
