function [data] = processData(props,color,sizeThreshold)

% Get red shapes full data
[rowNum,~] = size(props);
for i = 1:rowNum
    % remove possible noise
    if props.Area(i,1) <= 30
        continue
    end
    % get shape colour
    data(i,1) = "red";
    % determine shape
    if props.Circularity(i,:) > 0.85
        data(i,2)= "Circle";
    elseif props.Circularity(i,:) <= 0.85 && props.Circularity(i,:) > 0.7
        data(i,2)= "Square";
    elseif props.Circularity(i,:) <= 0.70
        data(i,2)= "Triangle";
    end
    %determine size
    if props.Area(i,1)> sizeThreshold
        data(i,6)= "True";
    else
        data(i,6)= "False";
    end
    %get centroid and area
    data(i,3)= props.Centroid(i,1);
    data(i,4)= props.Centroid(i,2);
    data(i,5)= props.Area(i,1);
end
    
    
end

