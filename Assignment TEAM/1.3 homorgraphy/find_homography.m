function H = find_homography(filename)
% Write a function that returns the Homography matrix as explained in the Problem description.
img = imread(filename);
%convert to double
img = im2double(img);

%rgb colour plains
r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);
%get blue circles
binary_img = b./(r+g+b) > 0.45;
imshow(binary_img);

% Get props' centroids
stats = regionprops("table",binary_img,"Centroid","Area","Circularity");
% Store data
centroids = cat(1,stats.Centroid);
areas = cat(1,stats.Area);

% Largest circle
largestArea = max(areas);
i = find(areas == largestArea); % coordinates of the Largest circle

% Clone variable
centroidsNew = centroids;
% Remove the largest circle
centroidsNew(i,:) = [];

% 3rd column: Calculate and add distanceFromLargest circle
distanceFromLargest = [centroidsNew, sqrt(abs(centroidsNew(:,1)-centroids(i,1)).^2 + abs(centroidsNew(:,2)-centroids(i,2)).^2)];
% 4th column: Add sum of coordinates
distanceFromLargest = [distanceFromLargest, distanceFromLargest(:,1)+distanceFromLargest(:,2)];
% Sort in the ascending order of distanceFromLargest
distanceSorted = sortrows( distanceFromLargest, 3);
sorted3 = sortrows( distanceSorted(1:3,:), 4);
sorted5 = sortrows( distanceSorted(4:8,:), 4);

% Now put them in P, order is right as required
P = [centroids(i,1:2)' sorted3(:,1:2)' sorted5(:,1:2)' ; ones(1,9) ];
% The Euclidean workspace coordinates of the markers
Q = [ 0 0 250 250 0 250 500 500 500; 0 250 250 0 500 500 500 250 0; ones(1,9) ];

H = simple_homography(P,Q);
end
