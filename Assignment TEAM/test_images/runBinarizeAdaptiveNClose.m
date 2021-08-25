clear All; close all; clc;

%% import image
imgOriginal = imread('test_23.png');
figure();
imshow(imgOriginal); title('Original');

% Duplicate the image to assign the result
imgBin = imgOriginal;

figure();
imshow(imgBin); title('Result of splitting and imbinarizing');

%% Binarizing

imgBin = imbinarize(imgBin,'adaptive','ForegroundPolarity','dark','Sensitivity',0.57);
imClose = imclose(imgBin,strel('disk',5));
imshow(imClose); title('Close');

% ------------------------
% IMPORTANT
% If error persists, use the uninverted image to dilate + erode (applying
% the white object. This will fill the holes.
% https://robotacademy.net.au/masterclass/spatial-operators/?lesson=678
% ------------------------

invert = 1 - imClose;
% Find the number of connected components in the image.
imgcc = bwconncomp(invert);

% Extract centroids
stats = regionprops(imgcc,'Area','Centroid','Circularity');
% Store data
centroids = cat(1,stats.Centroid);
areas = cat(1,stats.Area);
circularity = cat(1,stats.Circularity);

%% Show
figure();
imshow(invert); title('inverse');
hold on
plot(centroids(:,1),centroids(:,2),'r*')


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

% More markers for shapes
plot(circles(:,1), circles(:,2), 'ro');
plot(triangles(:,1), triangles(:,2), 'bo');
plot(squares(:,1), squares(:,2), 'go');  

%% Resources I used:
% https://au.mathworks.com/help/images/ref/regionprops.html#d123e242978
% https://au.mathworks.com/help/images/ref/bwconncomp.html
% Identify shape based on circularity: Lec03 slides
% Tut03 slides




