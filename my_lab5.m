close;
clear;
clc;

%% read image
filename = 'image.jpg';
I = imread(filename);
figure('name', 'source image');
imshow(I);

%% ----- pre-lab ----- %%
% output = function(input1, input2, ...); grey_scale function
I2 = my_grey_scale(I);

%% ----- homework lab ----- %%
% flip function
I3 = my_flip(I,0);

% rotation function
I4 = my_rotation(I, pi/3);

%% show image
figure('name', 'grey scale image'),
imshow(I2);

figure('name', 'flip'),
imshow(I3);

figure('name', 'rotation'),
imshow(I4);

%% write image
% save image for your report
filename2 = 'my_grey.jpg';
imwrite(I2, filename2);
filename3 = 'my_flip.jpg';
imwrite(I3, filename3);
filename4 = 'my_rotation.jpg';
imwrite(I4, filename4);
