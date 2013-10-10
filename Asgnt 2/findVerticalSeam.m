function [ seam, energy ] = findVerticalSeam( energy_img )

[m,n] = size(energy_img);
for row = 2:m
   for col = 1:n
      left = max(col - 1, 1);
      right = min(col+1, n);
      elem = min( energy_img(row - 1, left:right) );
      energy_img(row, col) = energy_img(row, col) + elem;
   end
end
[energy, Index] = min(energy_img(m,:));
seam = ones(m,1); 

for row = m-1:-1:1
    j = Index(1);
    seam(row + 1) = j;
    left = max(j-1, 1);
    right = min(j+1,n);
    [C, Index] = min( energy_img(row, left:right) );
    Index = left + Index - 1;
end
seam(1) = Index(1);
end