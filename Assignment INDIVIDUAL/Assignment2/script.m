clear all; close all; clc;

%% Task 1
% img = imread('example3.png');
% figure(); imshow(img);
% 
% repaired_img = recover(img);
% figure(); imshow(repaired_img);


%% Task 2
img = imread('example_001.png');
img = imbinarize(img);
img = imerode(img, ones(21,21));
imshow(img);
stats = regionprops(img, 'Area');
length(stats);

img = logical(imread('example_010.png'));
n = how_many(img);