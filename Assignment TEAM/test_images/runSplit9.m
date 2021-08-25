clear all; close all; clc;

%% import image
imgOriginal = imread('test_01.png');
figure();
imshow(imgOriginal); title('Original');

% Duplicate the image to assign the result
imgSplitResult = imgOriginal;

% I'm trying to PLIT INTO 9 PIECES and binarize them, but result is
% imperfect
img_size = size(imgOriginal);
w = img_size(1);
l = img_size(2);
% img = imgoriginal(1200:w,  1200:l);

img11 = imgOriginal(1:600,  1:600);     img11 = imbinarize(img11,150/255);
img12 = imgOriginal(1:600,  600:1200);  img12 = imbinarize(img12);
img13 = imgOriginal(1:600,  1200:l);    img13 = imbinarize(img13);
imgSplitResult(1:600,  1:600) = img11(1:600,  1:600).*255;     
imgSplitResult(1:600,  600:1200) = img12.*255;  
imgSplitResult(1:600,  1200:l) = img13.*255;   

img21 = imgOriginal(600:1200,  1:600);  img21 = imbinarize(img21);
img22 = imgOriginal(600:1200,  600:1200);img22 = imbinarize(img22);
img23 = imgOriginal(600:1200,  1200:l); img23 = imbinarize(img23);
imgSplitResult(600:1200,  1:600) = img21.*255;
imgSplitResult(600:1200,  600:1200) = img22.*255;
imgSplitResult(600:1200,  1200:l) = img23.*255;

img31 = imgOriginal(1200:w,  1:600);    img31 = imbinarize(img31,'global');
img32 = imgOriginal(1200:w,  600:1200); img32 = imbinarize(img32);
img33 = imgOriginal(1200:w,  1200:l);   img33 = imbinarize(img33);
imgSplitResult(1200:w,  1:600) = img31.*255;
imgSplitResult(1200:w, 600:1200) = img32.*255;
imgSplitResult(1200:w,  1200:l) = img33.*255;

figure();
imshow(imgSplitResult); title('Result of splitting and imbinarizing');

%% Binarizing

% Imbinarize the SPLIT result
mask = imbinarize(imgSplitResult, 130/255);
inverse = 1 - mask;
% Find the number of connected components in the image.
imgcc = bwconncomp(inverse);

% Extract centroids
stats = regionprops(imgcc,'Area','Centroid','Circularity');
% Store data
centroids = cat(1,stats.Centroid);
areas = cat(1,stats.Area);
circularity = cat(1,stats.Circularity);

%% Show
figure();
imshow(inverse); title('inverse');
hold on
plot(centroids(:,1),centroids(:,2),'b*')
hold off

%% Classify
triangles = [];
squares = [];
circles = [];
last = length(stats);
for i=1:last
    cir = circularity(i);
    if cir > 0.9
        circles = [circles; centroids(i) centroids(i)];
    elseif cir > 0.7
        squares = [squares; centroids(i) centroids(i)];
    else
        triangles = [triangles; centroids(i) centroids(i)];      
    end
end


%% Resources I used:
% https://au.mathworks.com/help/images/ref/regionprops.html#d123e242978
% https://au.mathworks.com/help/images/ref/bwconncomp.html
% Identify shape based on circularity: Lec03 slides
% Tut03 slides




