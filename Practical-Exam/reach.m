function [done] = reach(x,y, sim)

done = 0;

% Robot specs
L1 = 138;
L2 = 135;
L3 = 147;
L4 = 60; L5 = 80; L6 = 100;   

% Robot position on workspace
xRobot = 80; yRobot = 290;

% Aim for cylinder 
z = 50; % cylinder height/ in milimeter

phi = 0;    % angle of the vacuum gripper
phi0 = pi/2 - phi;

theta1 = atan((y-yRobot)/(x-xRobot));

% distance_to_target_xy_plane
distance = sqrt((x-xRobot)^2 + (y-yRobot)^2) ;
omega = atan(L5/L4);
ww = pi/2 - omega - phi; % fork-like icon
ww0 = omega + phi;

Lh = sin(ww)*L6;
Lv = cos(ww)*L6;
% pg30lec10
r = sqrt((distance - Lh)^2 + (z - L1+Lv)^2);
si = atan2((z - L1+Lv),(distance - Lh)) ;% s angle sign

beta = acos((L2^2 + L3^2 - r^2)/(2*L2*L3));
alpha = asin(sin(beta)/r*L3);

theta2 = pi/2 - alpha - si;                               %
theta3 = pi/2 - beta;   % Robot angle is already added 90 degrees, therefore minus it off
% theta4 = pi/2 - theta3 - theta2 + (pi/2 - phi0);            %
theta4 = - theta3 - theta2;  % testing our way

q_new = rad2deg([theta1 theta2 theta3 theta4 0])
setJointPositions(sim, rad2deg(q_new));
% setJointPositions(sim, q_new);

done = 1;
end

