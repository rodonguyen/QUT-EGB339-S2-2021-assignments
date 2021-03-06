function [binary_img, centroids] = segment_blue_markers(img)
% Find the blue markers in an image. 
%   Return Values:
%     binary_img must be of type logical.
%     centroids must be of shape [n, 2].    

% Get hue value
[H,S,V] = rgb2hsv(img);
% Examine the image and binarize blue area
blue = H>0.65 & H<0.68;

% Clean noise
blueClean = medfilt2(blue, [8,8]);

% Get props' centroids
stats = regionprops("table",blueClean,"Centroid");
% Store data
centroids = cat(1,stats.Centroid);
binary_img = imbinarize(double(blueClean));

imshow(blueClean);

end