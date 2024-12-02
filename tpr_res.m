clc;
clear;
load data.mat;
filenames={'a.tiff', 'airplane.png', 'Akiyo.png', 'alu.tif', 'b.tiff', 'baboon.png', 'bandon.tif', 'barbara.bmp', 'brandyrose.tif', 'c.tiff', 'Carphone.png', 'Coastguard.png', 'Container.png', 'd.tiff', 'e.tiff', 'f.tiff', 'fruits.png', 'girl.png'};

[row,col]=size(filenames);
[row1,col1]=size(data);
lambda=1.05; % replace it with your initial starting threshold value
TPR=[];
for s=1:20 % run the loop till the threshold you want
    count=0;
    lambda=lambda-0.05; % replace 0.05 with the threshold interval
    for x=1:col
       absloc=strcat('D:\Downloads\FinalYearProj\FinalYearProj\similarImages\',filenames{1,x});
       %replace the path according to your folder path 
       I=imread(absloc);
       Hash1 = PHOG_hash(I); % replace your hash function here
       for y=1:col1
            if(x==y)
                temp=data{1,y};
                [row2,col2]=size(temp);
                for z=1:row2
                    % replace it with your distance metric
                    if(corr2(Hash1,temp(z,:))>=lambda)
                         count=count+1;
                    end
                end
            end
        end

    end
    TPR(1, s)=count;
    disp(s);
end

%%

%image_count = (total no of manipulations * 18)
          %  = 73 * 18 = 1314
          % for true positive rate, divide TPR by total no of images
          % in each threshold