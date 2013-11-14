clear
%% Parameters
Rimagename = 'bob';
Limagename = 'marty';
levels=6;
m = [10,8,6,5,4,2];
direction = 'h'; %h-horizontal, v-vertical
%% Read images
RI = int16(imread(strcat('Test Image/',Rimagename,'.png'),'png'));
LI = int16(imread(strcat('Test Image/',Limagename,'.png'),'png'));
RI = RI(:,:,1);
LI = LI(:,:,1);

%% Creating Laplacian Pyramid (ENCODE)
pyramid_gauss_R     = cell(1,levels);
pyramid_laplacian_R = cell(1,levels);
pyramid_gauss_L     = cell(1,levels);
pyramid_laplacian_L = cell(1,levels);

pyramid_gauss_R{1}=RI;
pyramid_gauss_L{1}=LI;

for i=2:levels
    pyramid_gauss_R{i}=impyramid(pyramid_gauss_R{i-1},'reduce');
    pyramid_gauss_L{i}=impyramid(pyramid_gauss_L{i-1},'reduce');
end
pyramid_laplacian_R{levels}=pyramid_gauss_R{levels};
pyramid_laplacian_L{levels}=pyramid_gauss_L{levels};

for i=levels-1:-1:1
    pyramid_laplacian_R{i}=pyramid_gauss_R{i}-impyramid(pyramid_gauss_R{i+1},'expand');
    pyramid_laplacian_L{i}=pyramid_gauss_L{i}-impyramid(pyramid_gauss_L{i+1},'expand');
end

%% STITCHING

pyramid_laplacian_S = cell(1,levels);
for i=1:levels
    if strcmp(direction,'v')
        s = size(pyramid_gauss_R{i},1);
        hs = uint16(s/2);
        pyramid_laplacian_S{i} = zeros(s,s);
        pyramid_laplacian_S{i}(:,1:hs-m(i)) = pyramid_laplacian_L{i}(:,1:hs-m(i));
        pyramid_laplacian_S{i}(:,hs+m(i):end) = pyramid_laplacian_R{i}(:,hs+m(i):end);
        for j=-m(i)+1:m(i)-1
            pyramid_laplacian_S{i}(:,hs+j) = int16((0.5-j/(2*m(i)))*pyramid_laplacian_L{i}(:,hs+j)+(0.5+j/(2*m(i)))*pyramid_laplacian_R{i}(:,hs+j));
        end
    else
        s = size(pyramid_gauss_R{i},1);
        hs = uint16(s/2);
        pyramid_laplacian_S{i} = zeros(s,s);
        pyramid_laplacian_S{i}(1:hs-m(i),:) = pyramid_laplacian_L{i}(1:hs-m(i),:);
        pyramid_laplacian_S{i}(hs+m(i):end,:) = pyramid_laplacian_R{i}(hs+m(i):end,:);
        for j=-m(i)+1:m(i)-1
            pyramid_laplacian_S{i}(hs+j,:) = int16((0.5-j/(2*m(i)))*pyramid_laplacian_L{i}(hs+j,:)+(0.5+j/(2*m(i)))*pyramid_laplacian_R{i}(hs+j,:));
        end
    end
    imwrite(uint8(pyramid_laplacian_S{i}+128),strcat(['Output Image/',Rimagename,'_',Limagename,'_lp_',direction,'_',int2str(i),'.png']),'png')
    temp = pyramid_laplacian_S{i};
    for j=2:i
        temp = impyramid(temp,'expand');
    end
    %figure,imshow(uint8(temp+128));
    imwrite(uint8(temp+128),strcat(['Output Image/',Rimagename,'_',Limagename,'_lps_',direction,'_',int2str(i),'.png']),'png');
end

%% DECODE
O = pyramid_laplacian_S{levels};
for i=levels-1:-1:1
    %figure, imshow(O);

    O = impyramid(O,'expand') + pyramid_laplacian_S{i};
    %figure, imshow(uint8(O));

end
%figure, imshow(uint8(RI));
%figure, imshow(uint8(LI));

figure, imshow(uint8(O));
imwrite(uint8(O),strcat(['Output Image/',Rimagename,'_',Limagename,'_',direction,'.png']),'png');

% thresh = multithresh(I,2);
% 
% valuesMax = [thresh max(I(:))];
% [quant8_I_max,index] = imquantize(I,thresh,valuesMax);
% 
% imshow(uint8(quant8_I_max));
% entropy(I)
% 
% entropy(quant8_I_max)
