clear all; close all; clc
% %1
% load cdata
% figure(1);
% plot(cdata(:,1),cdata(:,2),'.')
% title('1', 'fontsize', 20)
% 
% %2
% I = imread('handBW.pnm');
% 
% % threshold determined by for loop, increacing each threshold, and
% % plotting result with pause(0.05);
% t1 = 90; % threshold for background
% t2 = 110;% threshold for hand
% 
% figure(2)
% sgtitle('2', 'fontsize', 20)
% subplot(2,1,1)
% imshow(I);
% subplot(2,1,2)
% imhist(I)
% 
% figure(4)
% % mtresh sets (think of it as a regular threshold, hnot binary, but ternary)
% % - pixelvalues below t1 to one value
% % - the union of t1 and t2 as one value
% % - pixelvalues above t2 as one value
% mtresh(I,t1,t2) % thresholded image
% imshow(I)
% title('Trenary thresholded grayscale image with t1 = 90, t2 = 110')
% 
% % 3
% I2 = imread('hand.pnm'); % Read the image
% figure(5);imshow(I2); % Show the image
% R = I2(:,:,1); % Separate the three layers, RGB
% G = I2(:,:,2);
% B = I2(:,:,3);
% figure(6);plot3(R(:),G(:),B(:),'.') % 3D scatterplot of the RGB data
% 
% % plot each image component r b g and their histogram
% figure()
% subplot(2,3,1)
% imshow(R)
% title('red')
% subplot(2,3,2)
% imshow(B)
% title('blue')
% subplot(2,3,3)
% imshow(G)
% title('green')
% subplot(2,3,4)
% imhist(R)
% title('red histogram')
% subplot(2,3,5)
% imhist(B)
% title('blue histogram')
% subplot(2,3,6)
% imhist(G)
% title('green histogram')
% 
% 
% label_im = imread('hand_training.png'); % Read image with labels
% figure(7);imagesc(label_im); % View the training areas
% %classify for pair bands
% I3(:,:,1) = G; % Create an image with two bands/features
% I3(:,:,2) = B;
% [data,class] = create_training_data(I3,label_im); % Arrange the training data into vectors
% figure(8);scatterplot2D(data,class); % View the training feature vectors
% 
% Itest = im2testdata(I3); % Reshape the image before classification
% C = classify(double(Itest),double(data),double(class)); % Train classifier and classify the data
% ImC = class2im(C,size(I3,1),size(I3,2)); % Reshape the classification to an image
% 
% % 4 - classify
% % grayscale
% [data_g,class_g] = create_training_data(I,label_im);
% Itest_g = im2testdata(I);
% C_g = classify(double(Itest_g),double(data_g),double(class_g));
% ImC_g = class2im(C_g,size(I,1),size(I,2)); % Reshape the classification to an image
% 
% % single band - red
% [data_R,class_R] = create_training_data(R,label_im);
% Itest_R = im2testdata(R);
% C_R = classify(double(Itest_R),double(data_R),double(class_R));
% ImC_R = class2im(C_R,size(R,1),size(R,2)); % Reshape the classification to an image
% 
% % pair band
% % see pair band above
% 
% % all bands
% [data_3,class_3] = create_training_data(I2,label_im);
% Itest_3 = im2testdata(I2);
% C_3 = classify(double(Itest_3),double(data_3),double(class_3));
% ImC_3 = class2im(C_3,size(I2,1),size(I2,2)); % Reshape the classification to an image
% 
% figure(10)
% subplot(1,3,1)
% imagesc(ImC_g); % View the classification result
% title('Grayscale')
% 
% subplot(1,3,2)
% imagesc(ImC_R); % View the classification result
% title('Single band: Red')
% 
% subplot(1,3,3)
% imagesc(ImC_3); % View the classification result
% title('All bands: RBG')

% 5
load landsat_data

% what does the images look like?
figure()
subplot(2,4,1)
imagesc(landsat_data(:,:,1)) % g
subplot(2,4,2)
imagesc(landsat_data(:,:,2)) % g
subplot(2,4,3)
imagesc(landsat_data(:,:,3)) % r
subplot(2,4,4)
imagesc(landsat_data(:,:,4))
subplot(2,4,5)
imagesc(landsat_data(:,:,5))
subplot(2,4,6)
imagesc(landsat_data(:,:,6))
subplot(2,4,7)
imagesc(landsat_data(:,:,7))

% training data 
T = zeros(512,512);     % Create an empty image
T(490:511,20:70) = 1;   % Class 1: Water
T(450:510,140:190) = 2; % Class 2: Forrest
T(324:344,395:415) = 3; % Class 3: Agriculture
T(140:220,80:150) = 4; % Class 4: Urban environment

%plot trainingdata and an image 
figure()
subplot(1,2,1)
imagesc(T)
subplot(1,2,2)
imagesc(landsat_data(:,:,4))
sgtitle('Areas of training relative to the image (channel 4)', 'fontsize', 24)

Itest = im2testdata(landsat_data(:,:,[4,6,7]));
[data,class] = create_training_data(landsat_data(:,:,[4,6,7]),T);
C = classify(Itest,data,class,'quadratic');
ImC = class2im(C,size(landsat_data,1),size(landsat_data,2)); % Reshape the classification to an image
figure()
scatterplot3D(data,class)
figure()
sgtitle('Classification of image')
subplot(1,2,1)
imagesc(ImC)
title('Classifications using channel 4,6,7', 'fontsize', 24)


%ALL CHANNELS
Itest = im2testdata(landsat_data);
[data,class] = create_training_data(landsat_data,T);
C = classify(Itest,data,class);
ImC = class2im(C,size(landsat_data,1),size(landsat_data,2)); % Reshape the classification to an image
subplot(1,2,2)
imagesc(ImC)
title('Classifications using all seven channels', 'fontsize', 24);
sgtitle('')

% 6
% see paper

% 7 - TEXTURE BASED CLASSIFICATION

