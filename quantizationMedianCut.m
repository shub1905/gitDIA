clear
%% Parameters
n = 2; %% The resulting image will nave 2^n colours
imagename = 'dice';

%%
a = imread(strcat('TestImages/',imagename,'.jpg'),'jpeg');
[m,n,o] = size(a);
newImage = a;



min = zeros(1,o)+255; %% Array of min's of each channel
max = zeros(1,o); %% Array of max's of each channel



minmax = vertcat(min,max);
medianCut(minmax)


new_image = uint8(newImage);
imwrite(new_image,strcat('OutputImages/',imagename,'_ZoomInMATLAB',num2str(fact),'.jpg'),'jpeg');

function 