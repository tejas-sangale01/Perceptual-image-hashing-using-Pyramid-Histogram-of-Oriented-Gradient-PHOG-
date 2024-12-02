clc;
clear;
filenames={'a.tiff', 'airplane.png', 'Akiyo.png', 'alu.tif', 'b.tiff', 'baboon.png', 'bandon.tif', 'barbara.bmp', 'brandyrose.tif', 'c.tiff', 'Carphone.png', 'Coastguard.png', 'Container.png', 'd.tiff', 'e.tiff', 'f.tiff', 'fruits.png', 'girl.png'};

for i=1:18
dis1=[];
absloc=strcat('D:\Downloads\FinalYearProj\FinalYearProj\similarImages\',filenames{1,i});
%replace the path according to your folder path       
I=imread(absloc);

for sw=1:9

switch sw
     
    case 1
        rot = 0;
      for k=1:9
          rot = rot + 5; 
        J=imrotate(I,rot,'bilinear','crop');
        Hash2 = saliency_map(J); % replace your hash function here
        dis1=[dis1;Hash2]; 
      end    
    case 2
        per=0;
        for k=1:10
         per=per+0.001;
         J=imnoise(I,'salt & pepper',per);   %0.001 to 0.01 with unit 0.001
        Hash2 = saliency_map(J); % replace your hash function here
        dis1=[dis1;Hash2]; 
        end
        
    case 3
        per=0;
        for k=1:10
        per=per+0.5;
        J=imresize(I,per,'Method','bilinear');            %scaling
        Hash2 = saliency_map(J); % replace your hash function here
        dis1=[dis1;Hash2]; 
        end
        
    case 4
        
        per=0;
        for k=1:10
        per=per+0.3;
        h = fspecial('gaussian',[3,3],per);
        J=imfilter(I,h);
        Hash2 = saliency_map(J); % replace your hash function here
        dis1=[dis1;Hash2]; 
        end
        
    case 5
        rad=0;
        for k=1:6
        rad=rad+0.5;
       H=fspecial('disk',rad);
       J=imfilter(I,H,'replicate');
       Hash2 = saliency_map(J); % replace your hash function here
       dis1=[dis1;Hash2]; 
        end
        
        
        case 6
        rad=0;
        for k=1:5
        rad=rad+1;
        H=fspecial('average',rad);
        J=imfilter(I,H,'replicate');
        Hash2 = saliency_map(J); % replace your hash function here
        dis1=[dis1;Hash2]; 
        end
        
        
    case 7
        rad=0;
        for k=1:10
        rad=rad+0.01;
        J=imnoise(I,'gaussian',0,rad);
        Hash2 = saliency_map(J); % replace your hash function here 
        dis1=[dis1;Hash2]; 
        end
case 8
        var=0;
        for k=1:10
        var=var+0.001;
        J = imnoise(I,'speckle',var);
        Hash2 = saliency_map(J); % replace your hash function here
        dis1=[dis1;Hash2]; 
        end
    case 9
        len=0;
        theta = -5;
        for k=1:3
            len = len+1;
            for l =1:3        
                theta = theta + 5;
                h = fspecial('motion', len, theta);
                J=imfilter(I,h);
                Hash2 = saliency_map(J); % replace your hash function here
            end
%             motion_blur(i,k,l) = Sim_Dist;
            dis1=[dis1;Hash2]; 
        end
end       
end
data{1,i}=dis1;  % save data.mat and use it in tpr and fpr    
disp(i)
end
save("data_saliency_map.mat", "data");