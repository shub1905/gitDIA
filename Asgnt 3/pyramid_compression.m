clear
%% Parameters
imagename = 'martin';
levels = 8;
no_thres = [10,10,10,10,10,10,10,10];
%no_thres = zeros(1,8)+7;
%% Read images
I = int16(imread(strcat('Test Image/',imagename,'.png'),'png'));
I = I(:,:,1);
I(513,:) = 256;
I(:,513) = 256;

%I = I(320:448,320:448)

%% Creating Laplacian Pyramid (ENCODE)
pyramid_gauss = cell(1,levels);
pyramid_laplacian = cell(1,levels);

pyramid_gauss{1}=I;
% imwrite(uint8(pyramid_gauss{1}),strcat(['Output Image/',imagename,'_gp',int2str(1),'.png']),'png')
% imwrite(uint8(pyramid_gauss{1}),strcat(['Output Image/',imagename,'_gps',int2str(1),'.png']),'png')

for i=2:levels
    pyramid_gauss{i}=impyramid(pyramid_gauss{i-1},'reduce');
%     imwrite(uint8(pyramid_gauss{i}),strcat(['Output Image/',imagename,'_gp',int2str(i),'.png']),'png')
%     temp = pyramid_gauss{i};
%     for j=2:i
%         temp = impyramid(temp,'expand');
%     end
%     %figure,imshow(uint8(temp+128));
%     imwrite(uint8(temp),strcat(['Output Image/',imagename,'_gps',int2str(i),'.png']),'png');
end
pyramid_laplacian{levels}=pyramid_gauss{levels};
for i=levels-1:-1:1
    pyramid_laplacian{i}=pyramid_gauss{i}-impyramid(pyramid_gauss{i+1},'expand');
%     %figure,imshow(uint8(pyramid_laplacian{i}+128));
%     imwrite(uint8(pyramid_laplacian{i}+128),strcat(['Output Image/',imagename,'_lp',int2str(i),'.png']),'png')
%     temp = pyramid_laplacian{i};
%     for j=2:i
%         temp = impyramid(temp,'expand');
%     end
%     %figure,imshow(uint8(temp+128));
%     imwrite(uint8(temp+128),strcat(['Output Image/',imagename,'_lps',int2str(i),'.png']),'png');
end

%% COMPRESSION
entr_c=0;   %compressed entropy
entr=0;     %original entropy

entr = entropy(uint8(I))*size(I,1)*size(I,2);

pyramid_laplacian_c = cell(1,levels);
for i=1:levels
    thresh = multithresh(pyramid_laplacian{i},no_thres(i));
    temp = [min(pyramid_laplacian{i}(:)) thresh max(pyramid_laplacian{i}(:))];
    values = zeros(1,size(temp,2)-1);
    for j=1:size(values,2)
        values(j) = mean([temp(j) temp(j+1)]);
    end
    [quantized,index] = imquantize(pyramid_laplacian{i},thresh,values);
    pyramid_laplacian_c{i}=int16(quantized);
    
%     pyramid_laplacian_c{i}=(pyramid_laplacian{i}/(255/no_thres(i)))*(255/no_thres(i));
    
    entr_c = entr_c + entropy(uint8(pyramid_laplacian_c{i}-min(min(pyramid_laplacian_c{i}))))*size(pyramid_laplacian_c{i},1)*size(pyramid_laplacian_c{i},2);

    
    imwrite(uint8(pyramid_laplacian_c{i}+128),strcat(['Output Image/',imagename,'_lp_c',int2str(i),'.png']),'png')
    temp = pyramid_laplacian_c{i};
    for j=2:i
        temp = impyramid(temp,'expand');
    end
    %figure,imshow(uint8(temp+128));
    imwrite(uint8(temp+128),strcat(['Output Image/',imagename,'_lps_c',int2str(i),'.png']),'png');

end

%% DECODE
O = pyramid_laplacian_c{levels};
for i=levels-1:-1:1
    %figure, imshow(O);

    O = impyramid(O,'expand') + pyramid_laplacian_c{i};
    %figure, imshow(uint8(O));

end
figure, imshow(uint8(I));
figure, imshow(uint8(O));

compression_ratio = entr/entr_c
% thresh = multithresh(I,2);
% 
% valuesMax = [thresh max(I(:))];
% [quant8_I_max,index] = imquantize(I,thresh,valuesMax);
% 
% imshow(uint8(quant8_I_max));
% entropy(I)
% 
% entropy(quant8_I_max)
