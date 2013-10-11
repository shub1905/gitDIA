function [ seam, energy ] = findVerticalSeam( energy_img,num,numSeam )

[m,n] = size(energy_img);
for row = 2:m
    for col = 1:n
        left = max(col - 1, 1);
        right = min(col+1, n);
        elem = min( energy_img(row - 1, left:right) );
        energy_img(row, col) = energy_img(row, col) + elem;
    end
end
[energy, Index] = sort(energy_img(m,:));
seam = ones(m,numSeam);
js = Index(num:num+numSeam-1);
energy = energy(num:num+numSeam-1);
tp = size(js);
for p=1:tp
    j = js(p);
    for row = m-1:-1:1
        seam(row + 1,p) = j;
        left = max(j-1, 1);
        right = min(j+1,n);
        [~, Index] = min( energy_img(row, left:right) );
        j = left + Index(1) - 1;
    end
    seam(1,p) = j;
end
end