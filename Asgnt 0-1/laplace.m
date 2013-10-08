clc

%--------------parameters-------------------%
imageName = 'TestImages/car.jpg';
imageType = 'jpeg';
sigma1 = 4;
sigma2 = 3;
%------------------------------------------------%
aa = imread(imageName,imageType);
a = rgb2gray(aa);
[m,n] = size(a);
figure,imshow(a);
b = zeros(m,n);
laplacianOp = [0 -1 0;-1 5 -1;0 -1 0];

for i =2:m-1
    for j = 2:n-1
        b(i,j) = sum(sum(laplacianOp.*double(a(i-1:i+1,j-1:j+1))));
    end
end
figure,imshow(uint8(b));