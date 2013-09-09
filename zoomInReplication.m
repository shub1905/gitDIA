clear
%% Parameters
fact = 5;
imagename = 'car'

%%
a = imread(strcat('TestImages/',imagename,'.jpg'),'jpeg');
[m,n,o] = size(a);
newImage = zeros(m*fact,n*fact,o);
for dim = 1:o
    for i = 1:m
        for j = 1:n
            s = fact*i;
            t = fact*j;
            for k = 0:fact-1
                for l = 0:fact-1
                    newImage(s-k,t-l,dim) = a(i,j,dim);
                end
            end
        end
    end
end
new_image = uint8(newImage);
imwrite(new_image,strcat('OutputImages/',imagename,'_ZoomInReplication',num2str(fact),'.jpg'),'jpeg');
