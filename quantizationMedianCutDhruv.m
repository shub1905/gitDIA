function A = quantizationMedianCutDhruv(recursions,imagename)
recursions_original = recursions;
inputImage = imread(strcat('TestImages/',imagename,'.jpg'),'jpeg');

for recursions = 5:-1:recursions_original
    %# Create the gaussian filter with hsize = [5 5] and sigma = 2
    G = fspecial('gaussian',[5 5],2);
    %# Filter it
    inputImage = imfilter(inputImage,G,'same');


    [m,n,o] = size(inputImage);
    assert(o==3);
    A_original = reshape(inputImage,1,m*n,3); % A is a row vector of triplets
    cut = []; % is the array of cut points of A
    IX_original = [1:m*n]; % A = (original A) [IX]

    [A,cut,IX] = medianCut(A_original,IX_original,recursions);


    % Quantize colours of A
    cut = horzcat(1,cut,m*n);
    for i=2:length(cut)
        % Average the three channels in each cut
        A(1,cut(i-1):cut(i),1) = mean(A(1,cut(i-1):cut(i),1));
        A(1,cut(i-1):cut(i),2) = mean(A(1,cut(i-1):cut(i),2));
        A(1,cut(i-1):cut(i),3) = mean(A(1,cut(i-1):cut(i),3));

    end

    % Rearrange A back
    IX_invert(IX)=IX_original;
    A_back = A(1,IX_invert,:);

    % Reshape A to make an image back
    % outputImage = reshape(A_original_quantized,m,n,o);
    inputImage = reshape(A_back,m,n,o);

    %Write the final image
    inputImage = uint8(inputImage);
end

outputImage = inputImage;
imwrite(outputImage,strcat('OutputImages/',imagename,'_QuantizationMedianCutDhruv',num2str(recursions_original),'.jpg'),'jpeg');
end

function [A,cut,IX] = medianCut(A,IX,recursions)

if (recursions==0)
    cut=[];
    return
end
[m,n,o]=size(A);
% assert(o==3);
% assert(m==1);

rectangleSize = max(A)-min(A); % Dimensions of the rectangle
[r,channelToSplit] = max(rectangleSize); % Split the channel with largest range
[s,ix] = sort(A(1,:,channelToSplit)); % Sort along that channel
A = A(1,ix,:);
IX = IX(1,ix);

c = floor(n/2);

[A1,cut1,IX1] = medianCut(A(:,1:c,:),IX(:,1:c),recursions-1);
[A2,cut2,IX2] = medianCut(A(:,c+1:n,:),IX(:,c+1:n),recursions-1);

cut = horzcat(cut1,c,cut2+c);
A = horzcat(A1,A2); 
IX = horzcat(IX1,IX2); 

end