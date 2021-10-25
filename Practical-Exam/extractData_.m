    function [data] = extractData(image, sizeThreshold)
    %extract colour plain
    r = image(:,:,1);
    g = image(:,:,2);
    b = image(:,:,3);

    red = imclose(r./(r+g+b) > 0.5, ones(5,5));
    blue = imclose(b./(r+g+b) > 0.5, ones(5,5));
    green = imclose(g./(r+g+b) > 0.5, ones(5,5));

    % Get Shape props from colour plain
    if sum(sum(red))>0
        redProps = regionprops("table",red,"Centroid","Area","Circularity");
    else
        redProps = 0;
    end
    % % if sum(sum(blue))>0
    % %     blueStats = regionprops("table",blue,"Centroid","Area","Circularity");
    % % else
    % %     blueStats = 0;
    % % end
    if sum(sum(green))>0
        greenProps = regionprops("table",green,"Centroid","Area","Circularity");
    else
        greenProps = 0;
    end

    % Get red shapes full data
    [rowNum,~] = size(redProps);
    for i = 1:rowNum
        % remove possible noise
        if redProps.Area(i,1) <= 30
            continue
        end
        % get shape colour
        redData(i,1) = "red";
        % determine shape
        if redProps.Circularity(i,:) > 0.85
            redData(i,2)= "Circle";
        elseif redProps.Circularity(i,:) <= 0.85 && redProps.Circularity(i,:) > 0.7
            redData(i,2)= "Square";
        elseif redProps.Circularity(i,:) <= 0.70
            redData(i,2)= "Triangle";
        end
        %determine size
        if redProps.Area(i,1)> sizeThreshold
            redData(i,6)= "True";
        else
            redData(i,6)= "False";
        end
        %get centroid and area
        redData(i,3)= redProps.Centroid(i,1);
        redData(i,4)= redProps.Centroid(i,2);
        redData(i,5)= redProps.Area(i,1);
    end

    % Get green shapes full data

    [rowNum,~] = size(greenProps);
    for k = 1:rowNum
        %remove possible noise
        if greenProps.Area(k,1)<=30
            continue
        end
        %get shape colour
        greenData(k,1)="green";
        %determine shape
        if greenProps.Circularity(k,:) > 0.85
            greenData(k,2)= "Circle";
        elseif greenProps.Circularity(k,:)<=0.85 && greenProps.Circularity(k,:) > 0.7
            greenData(k,2)= "Square";
        elseif greenProps.Circularity(k,:)<=0.70
            greenData(k,2)= "Triangle";
        end
        %determine size
        if greenProps.Area(k,1) > sizeThreshold
            greenData(k,6)= "True";
        else
            greenData(k,6)= "False";
        end
        %get centroid and area
        greenData(k,3)= greenProps.Centroid(k,1);
        greenData(k,4)= greenProps.Centroid(k,2);
        greenData(k,5)= greenProps.Area(k,1);
    end

    % % % Get blue shapes full data
    % % [rowNum,~] = size(blueProps);
    % % for i = 1:rowNum
    % %     % remove possible noise
    % %     if blueProps.Area(i,1)<=30
    % %         continue
    % %     end
    % %     % get shape colour
    % %     blueData(i,1)="blue";
    % %     % determine shape
    % %     if arrayIn.Circularity(i,:)>0.85
    % %         blueData(i,2)= "Circle";
    % %     elseif arrayIn.Circularity(i,:)<=0.85 && arrayIn.Circularity(i,:)>0.7
    % %         blueData(i,2)= "Square";
    % %     elseif arrayIn.Circularity(i,:)<=0.70
    % %         blueData(i,2)= "Triangle";
    % %     end
    % %     % determine size
    % %     if arrayIn.Area(i,1) > sizeThreshold
    % %         blueData(i,6)= "True";
    % %     else
    % %         blueData(i,6)= "False";
    % %     end
    % %     % get centroid and area
    % %     blueData(i,3)= arrayIn.Centroid(i,1);
    % %     blueData(i,4)= arrayIn.Centroid(i,2);
    % %     blueData(i,5)= arrayIn.Area(i,1);
    % % end

    data = cat(1, redData, greenData);

    end