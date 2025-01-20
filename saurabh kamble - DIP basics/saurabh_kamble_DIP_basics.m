% created by saurabh kamble
% DIP basics

clc;
clear all;
close all;
%reading image 
I = imread('https://www.bkacontent.com/wp-content/uploads/2016/06/Depositphotos_31146757_l-2015.jpg');

R=I(:,:,1);%extracting red
G=I(:,:,2);%extracting green
B=I(:,:,3);%extracting blue
Ig=((R+G+B)/3);% grey scale image 

count = sum(Ig(:)); %suming igs intensity 
threshold=count/(1752*1920);
Ib = Ig > threshold; % Binarized image

Iblue=I;
Iblue(:,:,1)=0;% Remove red
Iblue(:,:,2)=0;% Remove green 

Igreen=I;
Igreen(:,:,1)=0;% Remove red
Igreen(:,:,3)=0;% Remove blue

Ired=I;
Ired(:,:,2)=0;% Remove green 
Ired(:,:,3)=0;% Remove blue

%plotting images 
subplot(2,3,1);
imshow(I);
title("Original Image");

subplot(2,3,2);
imshow(Ig);
title("Grayscale Image");

subplot(2,3,3);
imshow(Ib);
title("B&W Image");

subplot(2,3,4);
imshow(Ired);
title("Red Image");

subplot(2,3,5);
imshow(Igreen);
title("Green Image");

subplot(2,3,6);
imshow(Iblue);
title("Blue Image");