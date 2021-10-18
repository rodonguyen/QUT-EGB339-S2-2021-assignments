function retval = fullmarks(sim, init_image, dest_image)

if nargin == 0 
    retval = 20   
return 
end 
% sim is a coppeliaRobot object that has methods you can use to  
%            drive the robot or capture images 
% init_image is a color image in matrix form  
% dest_image is a color image in matrix form  


%% COMPUTE THE INITIAL AND FINAL CYLINDER POSITIONS 

% do computer vision on init_image and dest_image 
% determine the initial position of each cylinder. 
% This must be a 3 x 2 matrix, with one row per shape, 
% each row is (x,y) position of a cylinder 

init_xy = ?? % must be 3x2 matrix 


% determine the destination position of each cylinder. This must be a
% 3 x 2 matrix, with one row per shape, each row is (x,y) position of
% a cylinder 

dest_xy = ?? % must be 3x2 matrix 
retval = {init_xy, dest_xy}


%% MOVE ROBOT ARM, CAPTURE IMAGE, PROCESS THE WORKSHEET TO DETERMINE 



%% POSITIONS 

 

%% MOVE THE CYLINDERS FROM INITIAL TO DESTINATION POSITIONS 

 

end 