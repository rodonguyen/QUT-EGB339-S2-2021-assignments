function [x] = part2(H,P)
% Given Homography H (from image to work surface) and a point P on the work surface, calculate the image of P and return its carthesian coordinates as a 2-vector.

% Add another row - Change to Homogeneous form
P = [ P; 1 ];

% Get the point coordinates on camera image
x = H^-1 * P;
x = x./x(3,:);
x = x(1:2,:);


end

