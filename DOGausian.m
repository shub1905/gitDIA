clc
clear
%--------------parameters-------------------%
inputImageName = 'TestImages/minion in suit.jpg';
outputImageName = 'TestImages/minion in suit.jpg';
imageType = 'jpeg';
sigma1 = 5;
sigma2 = .5;
kernelSize = 6;
%------------------------------------------------%
a = imread(inputImageName,imageType);
[m,n,o] = size(a);
figure,imshow(a);

G1 = fspecial('Gaussian',[kernelSize,kernelSize],min(sigma1,sigma2));
G2 = fspecial('Gaussian',[kernelSize,kernelSize],max(sigma1,sigma2));

b1 = imfilter(a,G1,'symmetric');
b2 = imfilter(a,G2,'symmetric');
b = b1-b2;

level = graythresh(b);
c = im2bw(b,level);
figure,imshow(c);

d = c*255;
for i = 1:3
    e(:,:,i) = d;
end
e = uint8(e);
yui = imread(outputImageName);
ef = e+yui;
figure,imshow(ef);
imwrite(ef,'OutputImages/minion catoonization.jpg');