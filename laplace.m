clc
a = imread('cats.jpg','jpeg');
a = rgb2gray(a);
[m n] = size(a);
figure,imshow(a);
laplac = [-1 0 1; -2 0 2; -1 0 1];
laplac1 = [0 -1 0; -1 5 -1; 0 -1 0];
b = zeros(m,n);
% c = zeros(m,n);
% d = zeros(m,n);
% fg = [1 2 1;2 4 2;1 2 1];
% lsum = sum(sum(fg));
% fg2 = [1 1 1;1 1 1;1 1 1];
% lsum2 = sum(sum(fg2));

% for i =2:m-1
%     for j = 2:n-1
%         c(i,j) = sum(sum(fg.*double(a(i-1:i+1,j-1:j+1))));
%         c(i,j) = c(i,j)/lsum;
%         d(i,j) = sum(sum(fg2.*double(a(i-1:i+1,j-1:j+1))))/lsum2;
%     end
% end
% c = uint8(c);
% figure,imshow(c);
% d = uint8(d);
% figure,imshow(d);
% c = double(c);

for i = 2:m-1
    for j = 2:n-1
        b(i,j) = sum(sum(laplac.*double(a(i-1:i+1,j-1:j+1))));
    end
end

figure,imshow(uint8(b));