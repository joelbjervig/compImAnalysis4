clear all; close all; clc
%1
load cdata
figure(1);
plot(cdata(:,1),cdata(:,2),'.')
title('1', 'fontsize', 20)

%2
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

% 3
I2 = imread('hand.pnm'); % Read the image
figure(5);imshow(I2); % Show the image
R = I2(:,:,1); % Separate the three layers, RGB
G = I2(:,:,2);
B = I2(:,:,3);
figure(6);plot3(R(:),G(:),B(:),'.') % 3D scatterplot of the RGB data

% plot each image component r b g and their histogram
figure()
subplot(2,3,1)
imshow(R)
title('red')
subplot(2,3,2)
imshow(B)
title('blue')
subplot(2,3,3)
imshow(G)
title('green')
subplot(2,3,4)
imhist(R)
title('red histogram')
subplot(2,3,5)
imhist(B)
title('blue histogram')
subplot(2,3,6)
imhist(G)
title('green histogram')


label_im = imread('hand_training.png'); % Read image with labels
figure(7);imagesc(label_im); % View the training areas

% 4

% 5

% 6

% 7
