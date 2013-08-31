clc
a = imread('cats.jpg','jpeg');
a = rgb2gray(a);
[m n] = size(a);
figure,imshow(a);
laplac = [-1 -1 -1; -1 8 -1; -1 -1 -1];
laplac1 = [0 -1 0; -1 4 -1; 0 -1 0];
b = zeros(m,n);
c = zeros(m,n);
fg = [1 1 1;1 1 1;1 1 1];

for i =2:m-1
    for j = 2:n-1
        c(i,j) = sum(sum(fg.*double(a(i-1:i+1,j-1:j+1))));
        c(i,j) = c(i,j)/9;
    end
end
c = uint8(c);
figure,imshow(c);
c = double(c);

for i = 2:m-1
    for j = 2:n-1
        b(i,j) = sum(sum(laplac1.*double(a(i-1:i+1,j-1:j+1))));
    end
end

figure,imshow(uint8(b));