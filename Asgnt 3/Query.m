load('decompDatabase.mat');
load('QdecompDatabase.mat');

Qlen = size(QdecompDatabase,3);
Dlen = size(decompDatabase,3);
score = zeros(Qlen,Dlen);
weight = 10^-2;

for i=1:Qlen    
    for dim=1:3
        query = QdecompDatabase(:,dim,i);
        for d=1:Dlen
            img = decompDatabase(:,dim,d);
            score(i,d) = score(i,d) - sum((img>0) & (query>0));
            score(i,d) = score(i,d) - sum((img<0) & (query<0));
            score(i,d) = score(i,d) + weight*abs(img(1)-query(1));
        end
    end
end

[~,ind] = sort(score,2);
disp(ind(:,1)');