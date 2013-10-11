function [ image ] = markSeam( image, seam, type )
    if strcmp(type, 'H') 
        %Horizontal seam
        for i = 1:size(seam,1)
            image(seam(i,:), i, 1) = 255;
            image(seam(i,:), i, 2) = 0;
            image(seam(i,:), i, 3) = 0;
        end
    else
        %Vertical seam
        for i = 1:size(seam,1)
            image(i, seam(i,:), 1) = 255;
            image(i, seam(i,:), 2) = 0;
            image(i, seam(i,:), 3) = 0;
        end
    end
end

