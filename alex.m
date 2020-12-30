clear all; close all; clc
%1
load cdata
figure(1);
plot(cdata(:,1),cdata(:,2),'.')
title('1', 'fontsize', 20)


I = imread('handBW.pnm');

% threshold determined by for loop, increacing each threshold, and
% plotting result with pause(0.05);
t1 = 90; % threshold for background
t2 = 110;% threshold for hand

figure(2)
sgtitle('2', 'fontsize', 20)
subplot(2,1,1)
imshow(I);
subplot(2,1,2)
imhist(I)

figure(4)
% mtresh sets (think of it as a regular threshold, hnot binary, but ternary)
% - pixelvalues below t1 to one value
% - the union of t1 and t2 as one value
% - pixelvalues above t2 as one value
mtresh(I,t1,t2) % thresholded image

% 2
I2 = imread('hand.pnm');   % Read the image
figure(5);
imshow(I2);      % Show the image
R = I2(:,:,1);            % Separate the three layers, RGB
G = I2(:,:,2);  
B = I2(:,:,3);
figure(6);
plot3(R(:),G(:),B(:),'.') % 3D scatterplot of the RGB dat

label_im = imread('hand_training.png');  % Read image with labels
figure(7);
imagesc(label_im);            % View the training areas

I3(:,:,1) = G;% Create an image with two bands/features
% I3(:,:,2) = B;
% I3(:,:,3) = R;
[data,class] = create_training_data(I3,label_im); % Arrange the training data into vectors
figure(8);
scatter(data,class)

Itest = im2testdata(I3);% Reshape the image before classification
C = classify(double(Itest),double(data),double(class)); % Train classifier and classify the data
ImC = class2im(C,size(I3,1),size(I3,2));% Reshape the classification to an image
figure(9);
imagesc(ImC)

load landsat_data

