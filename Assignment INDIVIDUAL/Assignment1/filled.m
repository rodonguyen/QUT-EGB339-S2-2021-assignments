function filled = filled(img)
% Your function will be called with img containing an opened image.
% 
% Determine whether the img shows an empty tote or not.
% Return 0 if the tote is empty, and 1 otherwise.   
% Hint: use the available example files: example_empty.jpg, example_empty2.jpg, example_filled.jpg, and example_filled2.jpg

filled = 0;
sizee = size(img);
crop = img(1:sizee(1)-10, 30:sizee(2)-75);

binarize = imbinarize(crop, 'adaptive','ForegroundPolarity','dark','Sensitivity',0.8);
figure(); imshow(binarize);
onenum = sum(binarize(:) == 1);
zeronum =sum(binarize(:) == 0);
fprintf('one: %d\n', onenum);
fprintf('zero: %d\n', zeronum);
fprintf('1/0: %d\n', onenum / zeronum);

if onenum > 3000
    filled = 1;
end
fprintf('filled = %d\n', filled);


end