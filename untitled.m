clear;
clc;
workspace;

i = imread("1.tif");

resizedImage = imresize(i, [256, 256]);

grayscaleImage = rgb2gray(resizedImage);

image_3D(grayscaleImage);