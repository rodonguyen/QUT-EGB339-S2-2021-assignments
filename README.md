# EGB339-S2-2021-Assignments  
  
This repo contains assignments of EGB339 Semester 2/2021 at Queensland University of Technology.  

<br>


<span style="color:red">**IMPORTANT: Don't copy exactly as you may be subject to academic misconduct.** Please modify the variables, delete comments, add/remove lines, etc. before submitting yours.</span>
<hr/> 
<br/>  

## Compositions
### Individual assignments
Assignment | Task description | Method
--- | --- | --- 
1 | Check if the box is empty or not <br/> - Shape classification | - Crop out the box, adaptive binarize, count the number of 1s value in the image to determine 'filled' value <br/> - Calculate the circularity, classify
2 | Repair image with noise <br/> - Count objects| - Use  medfilt2(img,`<size of noise>`) <br/> - erode, regionprops, get length
4 | 1. Return the response of a blue sensor element under the incident light spectrum <br> 2. Count color squares| 1. Wise-multiply the 2 given arrays<br> 2. Use hue value from `rgb2hsv()`
4 | Calculate the workspace coordinates in the image with a given camera+lens | Get specs from camera docs, functions provided in tut05
5 | 1. Return area of rectangle in image from H (homography 3x3) <br> 2. Return the coordinates of a point on image <br> 3. Calculate the field of view | 1. H*p then divide by the third rows (z) <br> 2. H^-1 * P and then divided by thrid row (z) <br> 3. Calculate hypotenuse, get pixel size, field of view

<br/>

### Team assignments
Assignment | Task description | Method
--- | --- | --- 
1.1 | Segmentation and Shape Classification | - Adaptive binarize (with LUCKY RANDOM param), regionprops, circularity
1.2 | Get centroids of blue marker and return binary_image | Use chromacity b/(r+g+b)
1.3 | Calculate homography | Find largest circle, calculate distance from largest circle, sum of their coordinates, sort the 3 closest ones and then 5 furthest ones, then we have the desired order, use provided function to calculate H. This method works because the largest circles are all on the left bottom.
1.4 | Calculate disparity | Get blue circles' centroids, use formula: `focal*baseline/(disparity*picelSize)`
2 | Needle counting (Count circles) | Binarize, filter, invert, number of circles = count from bwlabel - 1


## Author
Rodo Nguyen (rodonguyendd@gmail.com)



 
