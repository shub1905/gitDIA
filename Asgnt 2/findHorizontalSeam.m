function [ seam, energy ] = findHorizontalSeam( energy_img,num,numSeam)

[m,n] = size(energy_img);
for col = 2:n
    for row = 1:m
        top = max(row - 1, 1);
        bottom = min(row+1, m);
        elem = min( energy_img(top:bottom,col-1) );
        energy_img(row, col) = energy_img(row, col) + elem;
    end
end
[energy, Index] = sort(energy_img(:,n));
seam = ones(n,numSeam);
energy = energy(num:num+numSeam-1);
is = Index(num:num+numSeam-1);
tp = size(is);
for p=1:tp
    i = is(p);
    for col = n-1:-1:1
        seam(col + 1,p) = i;
        top = max(i-1, 1);
        bottom = min(i+1,m);
        [~, Index] = min( energy_img(top:bottom,col) );
        i = top + Index(1) - 1;
    end
    seam(1,p) = i;
end
end