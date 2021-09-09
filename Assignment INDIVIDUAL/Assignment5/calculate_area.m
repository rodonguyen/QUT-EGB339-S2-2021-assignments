function a = calculate_area(H)
    % Given Homography H, return the area of the triangle with image vertices (640, 650), (590,800), and (540, 650)
    % H is defined from image coordinates to world coordinates.
    
p = [640 590 540; 650 800 650; 1 1 1 ];

world = H*p;
world = world./world(3,:);
world = world(1:2,:);

a = polyarea(world(1,:), world(2,:));
end
