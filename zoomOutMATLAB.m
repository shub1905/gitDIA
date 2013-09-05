clear
%% Parameters
fact = 5;
imagename = 'car'

%%
a = imread(strcat('TestImages/',imagename,'.jpg'),'jpeg');
newImage = imresize(a,1/fact);

new_image = uint8(newImage);
imwrite(new_image,strcat('OutputImages/',imagename,'_ZoomOutMATLAB',num2str(fact),'.jpg'),'jpeg');