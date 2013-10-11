% function [] = SeamCarving(m,n)
a = imread('Test Image\Broadway_tower.jpg');
ag = rgb2gray(a);
filter = fspecial('laplacian');
al = imfilter(ag,filter);
[m,n,~] = size(a);
n = n + 50;
m = m - 40;

while(size(a,2)>n)
    [seam,~] = findVerticalSeam(al,1,1);
%     a = markSeam(a,seam,'V');
    [a,ag,al] = removeSeam(a,ag,al,seam,'V');
end
while(size(a,1)>m)
    [seam,~] = findHorizontalSeam(al,1,1);
%     a = markSeam(a,seam,'H');
    [a,ag,al] = removeSeam(a,ag,al,seam,'H');
end

while size(a,1)<m
    [p,~] = size(al);
    p = randi(p,1,2);
    pp = max(p);
    tt = min(p);
    
    [seam,~] = findHorizontalSeam(al(tt:pp,:),1,1);
    seam = seam + tt;
    [a,ag,al] = extendSeam(a,al,ag,seam,'H');
end

while size(a,2)<n
    [~,p] = size(al);
    p = randi(p,1,2);
    pp = max(p);
    tt = min(p);
    
    [seam,~] = findVerticalSeam(al(:,tt:pp),1,1);
    seam = seam + tt;
    [a,ag,al] = extendSeam(a,al,ag,seam,'V');
end
figure,imshow(a);
imwrite(a,['Output Images\Broadway_tower ',num2str(size(a,1))...
    ,' ',num2str(size(a,2)),'.jpg']);
% end