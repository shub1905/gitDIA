clear
a = imread('dice2.jpg','jpeg');
[m,n,o] = size(a);
fact = 2;
M = floor(m/fact);
N = floor(n/fact);
newImage = zeros(M,N,o);

b = uint32(a);

for dim = 1:o
    for i = 1:M
        for j = 1:N
            s = fact*i;
            t = fact*j;
            sum = 0;
            for k = 0:fact-1
                for l = 0:fact-1
                    sum = sum + b(s-k,t-l,dim);
                end
            end
            temp = sum/fact;
            temp = temp /fact;
            newImage(i,j,dim) = temp;
            sum = 0;
        end
    end
end
new_image = uint8(newImage);
imwrite(new_image,'dice21.jpg','jpeg');