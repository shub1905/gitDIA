function [a,al,ag] = extendSeam(a,al,ag,seam,type)
[m,n,~] = size(a);
o = 1:3;
if strcmp(type,'V')
    a(:,n+1,:) = 0;
    al(:,n+1) = 0;
    ag(:,n+1) = 0;
    for i = 1:m
        for j=n+1:-1:seam(i)+1
            a(i,j,o) = a(i,j-1,o);
            ag(i,j) = ag(i,j-1);
            al(i,j) = al(i,j-1);
        end
    end
else
    a(m+1,:,:) = 0;
    al(m+1,:) = 0;
    ag(m+1,:) = 0;
    for j = 1:n
        for i=m+1:-1:seam(j)+1
            a(i,j,o) = a(i-1,j,o);
            ag(i,j) = ag(i-1,j);
            al(i,j) = al(i-1,j);
        end
    end
end
end