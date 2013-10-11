clear
%% Parameters
imagename = 'eat';

%% Read images
inputimageAraw = double(imread(strcat('Test Images/',imagename,'1.jpg'),'jpeg'));
inputimageBraw = double(imread(strcat('Test Images/',imagename,'3.jpg'),'jpeg'));
inputimageAraw = inputimageAraw(:,:,1);
inputimageBraw = inputimageBraw(:,:,1);

% figure,imshow(uint8(inputimageAraw));
% figure,imshow(uint8(inputimageBraw));
%% Windowing
[M, N] = size(inputimageAraw);
w1 = cos(linspace(-pi/2, pi/2, M));
w2 = cos(linspace(-pi/2, pi/2, N));
w = w1' * w2;
inputimageA = inputimageAraw.*w;
inputimageB = inputimageBraw.*w;

% figure,imshow(uint8(inputimageA));
% figure,imshow(uint8(inputimageB));

%% Find Rotation

absfftA = abs(fftshift(fft2(inputimageA)));
absfftB = abs(fftshift(fft2(inputimageB)));

% figure,imshow(mat2gray(log(absfftA+1)));
% figure,imshow(mat2gray(log(absfftB+1)));

pcfftimageA = imgpolarcoord(absfftA);
pcfftimageB = imgpolarcoord(absfftB);

pcfftimageA = pcfftimageA(50:end,:); ... Low pass filter
pcfftimageB = pcfftimageB(50:end,:); ... Low pass filter

% figure,imshow(mat2gray(log(pcfftimageA+1)));
% figure,imshow(mat2gray(log(pcfftimageB+1)));

power_spectrum = (fft2(pcfftimageA).*conj(fft2(pcfftimageB)))./abs(fft2(pcfftimageA).*conj(fft2(pcfftimageB)));

M = abs(ifft2(power_spectrum));
[I,Rotation] = find(M == max(M(:)));

% figure,imshow(uint8(abs(fftB)));
% figure,imshow(uint8(power_spectrum));

%% Do Rotation

inputimageBraw_rotated = imrotate(inputimageBraw,-1*Rotation);
[m,n] = size(inputimageBraw_rotated);
[p,q] = size(inputimageAraw);
inputimageAraw_rotated = zeros(size(inputimageBraw_rotated));
inputimageAraw_rotated(round(m/2-p/2):round(m/2-p/2)+p-1,round(n/2-q/2):round(n/2-q/2)+q-1) = inputimageAraw;

% figure,imshow(uint8(inputimageAraw_rotated));
% figure,imshow(uint8(inputimageBraw_rotated));

%% Find Translation

power_spectrum = (fft2(inputimageAraw_rotated).*conj(fft2(inputimageBraw_rotated)))./abs(fft2(inputimageAraw_rotated).*conj(fft2(inputimageBraw_rotated)));
M = 100*fftshift(abs(ifft2(power_spectrum)));
[y,x] = find(M == max(M(:)));

%figure,imshow(M);

%% Do translation

se = translate(strel(1), -1.*[round(m/2-y),round(n/2-x)]);
inputimageBraw_translated = imdilate(inputimageBraw_rotated,se);

% figure,imshow(uint8(inputimageBraw_translated));

%% Final cropping
imageA_cropped = imresize(inputimageAraw,0.5);
imageB_cropped = imresize(inputimageBraw,0.5);
temp = inputimageBraw_translated+inputimageAraw_rotated;
imageFinal = temp(round(m/2)-p/2+1:round(m/2)+p/2,round(n/2)-q/2+1:round(n/2)+q/2);


final = horzcat(vertcat(imageA_cropped,imageB_cropped),imageFinal);
figure,imshow(uint8(final));
