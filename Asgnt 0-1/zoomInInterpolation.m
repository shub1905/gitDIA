clear
a = imread('TestImages/dice.jpg','jpeg');
[m,n,o] = size(a);
fact = 8;
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
imwrite(new_image,'OutputImages/dice_ZoomInReplication8.jpg','jpeg');