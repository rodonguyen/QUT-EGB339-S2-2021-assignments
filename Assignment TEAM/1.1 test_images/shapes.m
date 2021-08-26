function [triangles, squares, circles, mask] = shapes(img)
    % Return the centroids of all triangles, squares, and circles.
    %
    % Inputs Variable:
    %        img will be a grayscale image of type uint8.
    %
    % Outputs:
    %   triangles, squares, cirles should be of shape [n, 2]
    %   mask should be the binarized image, but is not evaluated. It can be
    %   helpful for your debugging.
   
%     imshow(img);
% Don't touch the above

%% Binarizing
imgBin = imbinarize(img,'adaptive','ForegroundPolarity','dark','Sensitivity',0.56);
imClose = imclose(imgBin,strel('disk',5)); 
% imshow(imClose); title('Close');

% ------------------------
% IMPORTANT
% If error persists, use the uninverted image to dilate + erode (applying
% the white object. This will fill the holes.
% https://robotacademy.net.au/masterclass/spatial-operators/?lesson=678
% ------------------------

invert = 1 - imClose;
mask = invert;
% Find the number of connected components in the image.
imgcc = bwconncomp(invert);

% Extract centroids
stats = regionprops(imgcc,'Area','Centroid','Circularity');
% Store data
centroids = cat(1,stats.Centroid);
areas = cat(1,stats.Area);
circularity = cat(1,stats.Circularity);


%% Classify
triangles = [];
squares = [];
circles = [];
last = length(stats);
for i=1:last
    cir = circularity(i);
    if cir > 0.9
        circles = [circles; centroids(i,1) centroids(i,2)];
    elseif cir > 0.7
        squares = [squares; centroids(i,1) centroids(i,2)];
    else
        triangles = [triangles; centroids(i,1) centroids(i,2)];      
    end
end

end

