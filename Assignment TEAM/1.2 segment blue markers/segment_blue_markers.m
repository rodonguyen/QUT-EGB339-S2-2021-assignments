function [binary_img, centroids] = segment_blue_markers(img)
% Find the blue markers in an image. 
%   Return Values:
%     binary_img must be of type logical.
%     centroids must be of shape [n, 2].    

%% Version 1
% % Get hue value
% [H,S,V] = rgb2hsv(img);
% % Examine the image and binarize blue area
% blue = H>0.65 & H<0.68;
% 
% % Clean noise
% blueClean = medfilt2(blue, [5,5]);
% 
% % Get props' centroids
% stats = regionprops("table",blueClean,"Centroid");
% % Store data
% centroids = cat(1,stats.Centroid);
% binary_img = imbinarize(double(blueClean));
% 
% imshow(blueClean);

%% Version 2

gray = 255 - rgb2gray(img);
blue = img(:,:,3);

red = img(:,:,1); 
% % % figure(); imshow(red); title('red');
%1
% redBin = imbinarize(red,"adaptive", "Sensitivity", 0.87); %submitted one
%2 
% redBin = imbinarize(red, "adaptive", 'ForegroundPolarity','dark'); 
% redBin = medfilt2(redBin, [30,30]); 
redBin = red>100;
% % % figure(); imshow(redBin); title('redBin');

green = img(:,:,2); 
% % % figure(); imshow(green); title('green');
% greenBin = imbinarize(green,"adaptive", "Sensitivity", 0.87); 
greenBin = green > 100;
% % % figure(); imshow(greenBin); title('greenBin');

% blue = blue > 115 & red < 20 & green < 20;
% imshow(blue);

% test gray minus green and red
grayMinus = gray - uint8(redBin)*255 - uint8(greenBin)*255;
% % % figure();
% % % imshow(grayMinus); title('GrayMinus');
% grayBin = imbinarize(grayMinus, 'adaptive', 'Sensitivity', 0.55);
grayBin = imbinarize(grayMinus, 30/255);
% imshow(grayBin);

blueClean = medfilt2(grayBin, [10,10]);
% Get props' centroids
stats = regionprops("table", blueClean, "Centroid");

% Store data
centroids = cat(1,stats.Centroid);
binary_img = blueClean;

end