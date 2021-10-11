function fov = part3(f)
%PART3' Summary of this function goes here
%   Detailed explanation goes here

diagonalSensor = 7e-3;
% 1800 is the hypotenuse from 1440x1080
pxSize = diagonalSensor/1800;

% Field of view
fov = atand(720 * pxSize / f) * 2;

end

