clc;
clear;
load data.mat;
filenames={'a.tiff', 'airplane.png', 'Akiyo.png', 'alu.tif', 'b.tiff', 'baboon.png', 'bandon.tif', 'barbara.bmp', 'brandyrose.tif', 'c.tiff', 'Carphone.png', 'Coastguard.png', 'Container.png', 'd.tiff', 'e.tiff', 'f.tiff', 'fruits.png', 'girl.png'};

[row,col]=size(filenames);
lambda=1.05; % replace it with your initial starting threshold value
fpr=[];
for l=1:20 % run the loop till the threshold you want
    count=0;
    lambda=lambda-0.05; % replace 0.05 with the threshold interval
    lm(l)=lambda;
for k=1:col
dis1=[];    
absloc=strcat('D:\Downloads\FinalYearProj\FinalYearProj\similarImages\',filenames{1,k});
%replace the path according to your folder path        
I=imread(absloc);
Hash1 = PHOG_hash(I); % replace your hash function here
        
for i=1:18
data1=data{1,i};
[row1,col1]=size(data1);
        if(k~=i)
        for x=1:row1
                % replace it with your distance metric
                 if(corr2(Hash1,data1(x,:))>=lambda)
                     count=count+1;
                 end
                 
        end        
        end
end
end
fpr(1,l)=count;
end
%%
%image_count = (total no of manipulations * 17 * 18)
          %  = 73 * 17 * 18 = 22338
          % for false positive rate, divide fpr by total no of images
          % in each threshold