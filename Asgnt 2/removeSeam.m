function [a,ag,al] = removeSeam(a,ag,al,seam,type)

[m,n,~] = size(a);
o = 1:3;
for i = 1:m
    for j=seam(i):n-1
        a(i,j,o) = a(i,j+1,o);
        ag(i,j) = ag(i,j+1);
        al(i,j) = al(i,j+1);
    end
end

a(:,n,:) = [];
ag(:,n) = [];
al(:,n) = [];

end