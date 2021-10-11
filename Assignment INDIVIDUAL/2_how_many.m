function n = how_many(img)
%     Your function will be called with img being a binary image of type 'logical'.
%     
%     Knowing how many objects are in a storage box is very important to 
%     know in the automated fulfillment centre. The existing computer vision 
%     system can already segment foreground and background and
%     create binary images of size 640x480 (width x height) such as those 
%     shown below. The segmentation has been written by a colleague who used 
%     different colour thresholding techniques. The method
%     works ok, but produces a significant number of artifacts that are 
%     visible as small rectangular segments in the image. Further analysis 
%     showed that these erroneous segments are never larger than 20x20
%     pixels.
%     Equipped with this information, your task is to write a function that 
%     can take in a binary image and returns the number of large segments, 
%     which correspond to objects in the box. 
    
img = imerode(img, ones(21,21));
stats = regionprops(img, 'Area');
n = length(stats);

end