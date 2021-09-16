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

% % Turn gray to white
% %
% %
% gray = 255 - rgb2gray(img);
% blue = img(:,:,3);
% 
% red = img(:,:,1); 
% 
% % ///
% % redBin = imbinarize(red,"adaptive", "Sensitivity", 0.87); %submitted one
% % redBin = imbinarize(red, "adaptive", 'ForegroundPolarity','dark'); 
% % redBin = medfilt2(redBin, [30,30]); 
% redAdjust = imadjust(red,[0.05 0.95],[]);
% redBin = redAdjust > 20;
% 
% % SHOW RESULTS
% figure(); imshow(red); title('red');
% figure(); imshow(redAdjust); title('redAdjust');
% % figure(); imshow(redBin); title('redBin');
% 
% green = img(:,:,2); 
% greenAdjust = imadjust(green,[0.05 0.95],[]);
% greenBin = green > 20; 
% % greenBin = greenAdjust > 50;
% 
% % SHOW RESULTS
% figure(); imshow(green); title('green');
% figure(); imshow(greenAdjust); title('greenAdjust');
% figure(); imshow(greenBin); title('greenBin');
% 
% % figure(); imhist(green); title('greenAdjust'); 
% % figure(); imhist(greenAdjust);
% 
% % blue = blue > 115 & red < 20 & green < 20;
% % imshow(blue);
% 
% % test gray minus green and red
% grayMinus = gray - uint8(redBin)*255 - uint8(greenBin)*255;
% grayAdjust = imadjust(grayMinus,[0.2 0.5],[]);
% figure(); imshow(grayAdjust); title('GrayMinus');
% % grayBin = imbinarize(grayMinus, 'adaptive', 'Sensitivity', 0.55);
% grayBin = imbinarize(grayAdjust, 200/255);
% % imshow(grayBin);
% 
% blueClean = medfilt2(grayBin, [10,10]);
% stats = regionprops("table", blueClean, "Centroid");
% 
% % Store data
% centroids = cat(1,stats.Centroid);
% binary_img = blueClean;

%% Version 3
% 
% % Representative cases 34 38 43
% blue = (img(:,:,3) > 100 & img(:,:,1) < 10 & img(:,:,2) < 10) | (img(:,:,3) == 255 & img(:,:,2) < 200 & img(:,:,1) < 200); % image 43 and 34
% % figure(); imshow(blue); title('ohyeah');
% % Clean noise
% blueClean = medfilt2(blue, [2,2]);
% 
% % blueClean = blue;
% % Get centroids
% stats = regionprops("table", blueClean, "Centroid");
% 
% % Store data
% centroids = cat(1,stats.Centroid);
% binary_img = blueClean;

%% Version 4: Worked!

%convert to double
img = im2double(img);
%rgb colour plains
r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);
%get blue circles
binary_img = b./(r+g+b) > 0.45;
%get centroid data
stats = regionprops(binary_img);
centroids = cat(1,stats.Centroid);

end