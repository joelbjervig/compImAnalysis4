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



% 4

% 5

% 6

% 7
