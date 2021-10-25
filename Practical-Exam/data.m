function stats = data(arrayIn, colour, areaSize)


[rowNum,~] = size(arrayIn);
for c = 1:rowNum
    %remove possible noise
    if arrayIn.Area(c,1)<=30
        continue
    end
    %get shape colour
    stats(c,1)=colour;
    %determine shape
    if arrayIn.Circularity(c,:)>0.85
        stats(c,2)= "Circle";
    elseif arrayIn.Circularity(c,:)<=0.85 && arrayIn.Circularity(c,:)>0.7
        stats(c,2)= "Square";
    elseif arrayIn.Circularity(c,:)<=0.70
        stats(c,2)= "Triangle";
    end
    %determine size
    if arrayIn.Area(c,1)>areaSize
        stats(c,6)= "True";
    else
        stats(c,6)= "False";
    end
    %get centroid and area
    stats(c,3)= arrayIn.Centroid(c,1);
    stats(c,4)= arrayIn.Centroid(c,2);
    stats(c,5)= arrayIn.Area(c,1);
end
%remove missing rows if exists
% stats = rmmissing(stats);
end