function [a,ag,al] = removeSeam(a,ag,al,seam,type)
% seam size = (m,1) or (1,n)
[m,n,~] = size(a);
o = 1:3;
if strcmp(type,'V')
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
else
    for j = 1:n
        for i=seam(j):m-1
            a(i,j,o) = a(i+1,j,o);
            ag(i,j) = ag(i+1,j);
            al(i,j) = al(i+1,j);
        end
    end
    
    a(m,:,:) = [];
    ag(m,:) = [];
    al(m,:) = [];
    
end
end