clc
clear
%--------------parameters-------------------%
inputImageName = 'manOfSteel';
outputImageName = '_artification.jpg';
% yui = quantizationMedianCutDhruv(4,inputImageName);
imageType = 'jpeg';
sigma = 1.6;
tau = .998;
k = 2;
epi = 0;
phi = 1;
kernelSize = 5;
%------------------------------------------------%
a = imread(strcat('TestImages/',inputImageName),imageType);
figure,imshow(a);
a = rgb2gray(a);
[m,n,o] = size(a);
d(:,:,:) = zeros(m,n,o);

G1 = fspecial('Gaussian',[kernelSize,kernelSize],sigma);
G2 = fspecial('Gaussian',[kernelSize,kernelSize],k*sigma);

b1 = imfilter(a,G1,'symmetric');
b2 = imfilter(a,G2,'symmetric');
b = double(b1) - double(tau*b2);
for p=1:m
    for q=1:n
        for r=1:o
            if b(p,q,r) < epi
                d(p,q,r) = 1;
            else
                d(p,q,r) = 1 + tanh(double(phi*b(p,q,r)));
            end
        end
    end
end
minmin = min(min(min(d)));
maxmax = max(max(max(d)));
d = (d - minmin)/(maxmax-minmin);
d = d*255;
d = uint8(d);
figure,imshow(d);

% bwD = im2bw(d);
% bwD = 1-bwD;
% bm(:,:,1) = bwD;
% bm(:,:,2) = bwD;
% bm(:,:,3) = bwD;
% figure,imshow(bm);
% 
% ef = uint8(bm).*yui;
% figure,imshow(ef);
% imwrite(ef,strcat('OutputImages/',inputImageName,outputImageName));