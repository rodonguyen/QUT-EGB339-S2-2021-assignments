clear all; close all; clc;

img1 = imread('example_empty.jpg');
img2 = imread('example_empty2.jpg'); % brighter / higher values

img3 = imread('example_filled.jpg');
img4 = imread('example_filled2.jpg');

filled(img1);
filled(img2);
filled(img3);
filled(img4);

%% Empty 2 and Empty 1
diff = abs(img2 - img1);
diff_em2em1 = imbinarize(diff, 47/255);

max_diff = max(diff, [], 'all');
min_diff = min(diff, [], 'all');
mean_diff = mean(diff, 'all');
fprintf('Max diff = %d \nMean diff = %d\nMin diff = %d\n', max_diff, mean_diff, min_diff);
figure(); imshow(diff); title('abs(uint8-uint8)');
figure(); imshow(diff_em2em1); title('diff emmpty2 - empty1');

%% Empty 2 and Empty 1
diff_em2em1 = abs(img2 - img1);

% See the mean of diff_em2em1
mean_em2em1 = mean(diff_em2em1, 'all');
fprintf('Mean of unbinarized diff in empty2 filled1: %d\n', mean_em2em1);

% Binarize
diff_bin_em2em1 = imbinarize(diff_em2em1, mean_em2em1/255); % Value 15/255 is from histogram
mean_bin_em2em1 = mean(diff_bin_em2em1, 'all');
fprintf('Mean of binarized diff in empty2 filled1: %d\n\n', mean_bin_em2em1);

figure(); imshow(diff_em2em1); title('diff unbinarized empty2-empty1');
figure(); imshow(diff_bin_em2em1); title('diff binarized empty2-empty1');
% Histogram of unbinarized diff
figure(); imhist(diff_em2em1); title('diff unbinarized empty2 empty1');

%% Empty 2 and Filled 1
diff_em2fi1 = abs(img2 - img3);

% See the mean of diff_em2fi1
mean_em2fi1 = mean(diff_em2fi1, 'all');
fprintf('Mean of unbinarized diff in empty2 filled1: %d\n', mean_em2fi1);

% Binarize
diff_bin_em2fi1 = imbinarize(diff_em2fi1, mean_em2fi1/255); % Value 15/255 is from histogram
mean_bin_em2fi1 = mean(diff_bin_em2fi1, 'all');
fprintf('Mean of binarized diff in empty2 filled1: %d\n\n', mean_bin_em2fi1);

figure(); imshow(diff_em2fi1); title('diff unbinarized empty2-fi1led1');
figure(); imshow(diff_bin_em2fi1); title('diff binarized empty2-fi1led1');
% Histogram of unbinarized diff
figure(); imhist(diff_em2fi1); title('diff unbinarized empty2 fi1led1');



%% Empty 1 and Filled 1
diff_em1fi1 = abs(img1 - img3);

% See the mean of diff_em1fi1
mean_em1fi1 = mean(diff_em1fi1, 'all');
fprintf('Mean of unbinarized diff in empty1 filled1: %d\n', mean_em1fi1);

% Binarize
diff_bin_em1fi1 = imbinarize(diff_em1fi1, mean_em1fi1/255); % Value 15/255 is from histogram
mean_bin_em1fi1 = mean(diff_bin_em1fi1, 'all');
fprintf('Mean of binarized diff in empty1 filled1: %d\n\n', mean_bin_em1fi1);

% Show 
figure(); imshow(diff_em1fi1); title('diff unbinarized empty1-fi1led1');
figure(); imshow(diff_bin_em1fi1); title('diff binarized empty1-fi1led1');
% Histogram of unbinarized diff
figure(); imhist(diff_em1fi1); title('diff empty1 filled1');

%% Main function

% Mean diff_imbin near 0 => empty
% mean diff_imbin larger than => filled

%function filled = myFunction(img)
%end
