function [disparity, distance] = f(img_left, img_right)
    % Return the disparity in pixels, and the distance in meters.
    % Both images will be RGB color images of type uint8.
    %
    % Carefully read the problem description.

% Focal length * base line
fb = 2.5e-3 * 0.05;

% LEFT - Get the coordinates of a point
img = img_left;
blue = (img(:,:,3) > 100 & img(:,:,1) < 10 & img(:,:,2) < 10) | (img(:,:,3) == 255 & img(:,:,2) < 200 & img(:,:,1) < 200); % image 43 and 34
% Clean noise
blueClean = medfilt2(blue, [2,2]);
% Get centroids
stats = regionprops("table", blueClean, "Centroid");
% Store data
centroids_left = cat(1,stats.Centroid);

% RIGHT - Get the coordinates of that same point in LEFT
img = img_right;
blue = (img(:,:,3) > 100 & img(:,:,1) < 10 & img(:,:,2) < 10) | (img(:,:,3) == 255 & img(:,:,2) < 200 & img(:,:,1) < 200); % image 43 and 34
% Clean noise
blueClean = medfilt2(blue, [2,2]);
% Get centroids
stats = regionprops("table", blueClean, "Centroid");
% Store data
centroids_right = cat(1,stats.Centroid);

% Calculate the disparity based on the coords of the point we got (and only using x axis is sufficient)
disparity = centroids_right(1,1) - centroids_left(1,1);
distance = fb / (disparity*4e-6);       % pixel = 4e-6 meter


end