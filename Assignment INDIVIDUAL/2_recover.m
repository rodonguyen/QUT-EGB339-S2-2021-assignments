function repaired_img = recover(img)
% Your function will be called with img containing a grayscale uint8 image.
% This function will recover image with salt and pepper noise

repaired_img = medfilt2(img,[3,3]);

end