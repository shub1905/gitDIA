clc
clear
%--------------parameters-------------------%
inputImageName = 'kerra';
outputImageName = '_artification.jpg';
yui = quantizationMedianCutDhruv(3,inputImageName);
imageType = 'jpeg';
k = 2;
sigma1 = 2.5;
sigma2 = k*sigma1;
tau = .998;
thresh = 5;
%------------------------------------------------%
a = imread(strcat('TestImages/',inputImageName),imageType);
figure,imshow(a);
a = rgb2gray(a);
[m,n,o] = size(a);
d = zeros(m,n,o);

G1 = fspecial('Gaussian',4*sigma1 + 1,sigma1);
G2 = fspecial('Gaussian',4*sigma2 + 1,sigma2);

b1 = imfilter(a,G1,'symmetric');
b2 = imfilter(a,G2,'symmetric');
b = double(b1) - double(tau*b2);
% thresh = uint32(max(max(max(b))) + min(min(min(b))))*graythresh(b);

d(b<thresh) = 1;
d(b>=thresh) = 0;
figure,imshow(d);

bm(:,:,1) = d;
bm(:,:,2) = d;
bm(:,:,3) = d;

ef = uint8(bm).*yui;
figure,imshow(ef);
imwrite(ef,strcat('OutputImages/',inputImageName,outputImageName));