% function [] = SeamCarving(m,n)
imageName = 'Boat_lake';
a = imread(['Test Image\',imageName,'.jpg']);
ag = rgb2gray(a);
% filter = fspecial('laplacian');
% al = imfilter(ag,filter);
[al,~] = imgradient(ag);
al = (al-min(min(al)))/(max(max(al))-min(min(al)));
[m,n,~] = size(a);
m = m+50;
n = n-40;
imwrite(al,['Output Images\',imageName,'_energy.jpg']);
while(size(a,2)>n)
    [seam,~] = findVerticalSeam(al,1,1);
    b = markSeam(a,seam,'V');
    imwrite(b,['Temp\',imageName,num2str(size(a,2)),'x',num2str(size(a,1)),'.jpg']);
    [a,ag,al] = removeSeam(a,ag,al,seam,'V');
end
while(size(a,1)>m)
    [seam,~] = findHorizontalSeam(al,1,1);
    b = markSeam(a,seam,'H');
    imwrite(b,['Temp\',imageName,num2str(size(a,2)),'x',num2str(size(a,1)),'.jpg']);
    [a,ag,al] = removeSeam(a,ag,al,seam,'H');
end
while size(a,1)<m
    [p,~] = size(al);
    p = randi(p,1,2);
    pp = max(p);
    tt = min(p);
    
    [seam,~] = findHorizontalSeam(al(tt:pp,:),1,1);
    seam = seam + tt;
    b = markSeam(a,seam,'H');
    imwrite(b,['Temp\',imageName,num2str(size(a,2)),'x',num2str(size(a,1)),'.jpg']);
    [a,ag,al] = extendSeam(a,al,ag,seam,'H');
end
while size(a,2)<n
    [~,p] = size(al);
    p = randi(p,1,2);
    pp = max(p);
    tt = min(p);
    
    [seam,~] = findVerticalSeam(al(:,tt:pp),1,1);
    seam = seam + tt;
    b = markSeam(a,seam,'V');
    imwrite(b,['Temp\',imageName,num2str(size(a,2)),'x',num2str(size(a,1)),'.jpg']);
    [a,ag,al] = extendSeam(a,al,ag,seam,'V');
end
imwrite(a,['Output Images\',imageName,num2str(size(a,1))...
    ,'x',num2str(size(a,2)),'.jpg']);
% end