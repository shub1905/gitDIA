clear
%% Parameters
fact = 8;
imagename = 'dice'

%%
a = imread(strcat('TestImages/',imagename,'.jpg'),'jpeg');
newImage = imresize(a,fact);

new_image = uint8(newImage);
imwrite(new_image,strcat('OutputImages/',imagename,'_ZoomInMATLAB',num2str(fact),'.jpg'),'jpeg');