function count = coloured_objects(img)

    % Your function will be called with img being a RGB (3 channels) image of type double with values between 0 and 1.
    % You should return the variable count as a 3-vector.
    % count(1) should be the number of red objects, count(2) the number of green objects, count(3) the number of blue objects

    
[H,S,V] = rgb2hsv(img);
figure; 
imshow(H);





count = [0 0 0];
    
    
    
    
end

