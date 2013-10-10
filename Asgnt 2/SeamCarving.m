a = imread('Test Image\Broadway_tower.png');
ag = rgb2gray(a);
filter = fspecial('laplacian');
al = imfilter(ag,filter);
[m,n] = size(al);
[seam,energy] = findVerticalSeam(al);
J=[2,3];
for i=1:m
    a(i,seam(i),1) = 255;
    a(i,seam(i),J) = 0;
end

% [m,n] = size(al);
% aseam = double(al(:,:));
% adire = zeros(m,n);
% dirArr = [-1,0,1];
% % -1 go topleft 0 go top 1 g top right
% 
% tstart = cputime();
% for i=2:m
%     for j=1:n
%         if j > 1 && j<n
%             [c,d] = sort([al(i-1,j-1),al(i-1,j),al(i-1,j+1)]);
%             t = j + dirArr(d(1));
%             aseam(i,j) = double(al(i,j)) + aseam(i-1,t);
%             adire(i,j) = dirArr(d(1));
%         elseif j == 1
%             [c,d] = sort(al(i-1,1:2));
%             aseam(i,j) = double(al(i,j)) + aseam(i-1,d(1));
%             adire(i,j) = d(1) - 1;
%         else
%             [c,d] = sort([al(i-1,j-1),al(i-1,j)]);
%             t = j + dirArr(d(1));
%             aseam(i,j) = double(al(i,j)) + aseam(i-1,t);
%             adire(i,j) = dirArr(d(1));
%         end
%     end
% end
% disp(cputime()-tstart);
% ser = aseam(m,:);
% [val,ord] = sort(ser);
% al2 = uint8(zeros(m,n));
% J = ord(1:100);
% 
% for i=m:-1:1
%     al2(i,J) = 255;
%     J = J + adire(i,J);
% end