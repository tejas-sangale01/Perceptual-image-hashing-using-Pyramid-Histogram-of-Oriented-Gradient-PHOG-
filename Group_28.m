clear;
clc;
workspace;

filenames={'a.tiff', 'airplane.png', 'Akiyo.png', 'alu.tif', 'b.tiff', 'baboon.png', 'bandon.tif', 'barbara.bmp','brandyrose.tif', 'c.tiff', 'Carphone.png', 'Coastguard.png', 'Container.png' 'd.tiff', 'e.tiff', 'f.tiff', 'fruits.png', 'girl.png', 'Goldhill.png', 'h.tiff','Hall.png','i.tiff','kid.tif','Kodak.png','Lake.png','lena.png','lochness.tif','Mobile.png','MothernDaughter.png','News.png','newyork.tif','opera.tif','papermachine.tif','peppers.png','pills.tif','stomach.bmp','terraux.tif','tiffany.bmp','tulips.png','watch.tif','water.tif','waterall.bmp','wildflowers.tif'};
%filenames = {'1.bmp', '2.bmp', '3.bmp', '4.bmp', '5.jpg', '6.jpg', '7.jpg', '8.jpg', '9.jpg', '10.jpg', '11.jpg', '12.jpg', '13.jpg', '14.jpg', '15.jpg', '16.jpg', '17.jpg', '18.jpg', '19.jpg', '20.jpg', '21.jpg', '22.jpg', '23.jpg', '24.jpg', '25.jpg', '26.jpg', '27.jpg', '28.jpg', '29.jpg', '30.jpg', '31.jpg', '32.jpg', '33.jpg', '34.jpg','35.jpg', '36.jpg', '37.jpg', '38.jpg', '39.jpg', '40.jpg', '41.jpg', '42.jpg', '43.jpg', '44.jpg', '45.jpg', '46.png', '47.png', '48.png', '49.png', '50.png', '51.png', '52.png', '53.png', '54.png', '55.png', '56.png', '57.png', '58.png', '59.png', '60.png', '61.png', '62.png', '63.png', '64.tif', '65.tif', '66.tif', '67.tif', '68.tif', '69.tif', '70.tif', '71.tif', '72.tif', '73.tif', '74.tif', '75.tif', '76.tif', '77.tif', '78.tif', '79.tif', '80.tif', '81.tif', '82.tif', '83.tif', '84.tif', '85.tif', '86.tif', '87.tif', '88.tif', '89.tif', '90.tif', '91.tif', '92.tif', '93.tif', '94.tif', '95.tif', '96.tif', '97.tif', '98.tif', '99.tif', '100.tif', '101.tif', '102.tif', '103.tif', '104.tif', '105.tif', '106.tif', '107.tif', '108.tif', '109.tif', '110.tif', '111.tif', '112.tif', '113.tif', '114.tif', '115.tif', '116.tif', '117.tif', '118.tif', '119.tif', '120.tif', '121.tif', '122.tif', '123.tif', '124.tif', '125.tif', '126.tif', '127.tif', '128.tif', '129.tif', '130.tif','131.tif', '132.tif', '133.tif', '134.tif', '135.tif', '136.tif', '137.tif', '138.tif', '139.tif', '140.tif', '141.tif', '142.tif', '143.tif', '144.tif', '145.tif', '146.tif', '147.tif', '148.tif', '149.tif', '150.tif', '151.tif', '152.tif', '153.tif', '154.tif', '155.tif', '156.tif', '157.tif', '158.tif', '159.tif', '160.tif', '161.tif', '162.tif', '163.tif', '164.tif', '165.tif', '166.tif', '167.tif', '168.tif', '169.tif', '170.tif', '171.tif', '172.tif', '173.tif', '174.tif', '175.tif', '176.tif', '177.tif', '178.tif', '179.tif', '180.tif', '181.tif', '182.tif', '183.tif', '184.tif', '185.tif', '186.tif', '187.tif', '188.tif', '189.tif', '190.tif', '191.tif', '192.tif', '193.tiff', '194.tiff', '195.tiff', '196.tiff', '197.tiff', '198.tiff', '199.tiff', '200.tiff'};

%numPoints = 100;
rotation_clk=zeros(40, 9);
rotation_aclk=zeros(40,9);
salt_pepper=zeros(40,10);
speckle_noise=zeros(40,10);
scaling=zeros(40,10);
gaussian_blur=zeros(40,10);
circular_blur=zeros(40,6);
average_blur=zeros(40,5);
gaussian_noise=zeros(40,10);
motion_blur = zeros(40,9);

%d=zeros(200, 200);

for i=1:40
    absloc=strcat('D:\Downloads\FinalYearProj\FinalYearProj\similarImages\',filenames{1,i});
    I=imread(absloc);
    [Hash1] = saliency_map(I);
    %   for j = 1:200
    %              idsloc=strcat('D:\Downloads\FinalYearProj\FinalYearProj\images\',filenames{1,j});
     %             imageDissimilar=imread(idsloc);
      %            [phogD, angle] = PHOG_hash(imageDissimilar);
       %           d(i, j) = corr2(Hash1, phogD);
    %  end
    for sw=1:10
        switch sw
        case 1
            rot = 0;
            for k=1:9
                rot = rot + 5; 
                J=imrotate(I,rot,'bilinear','crop');
                [Hash2] = saliency_map(J);
                Sim_Dist=corr2(Hash1,Hash2);
                rotation_clk(i,k) = Sim_Dist;
            end
          
        case 2
            rot = 0;
            for k=1:9
                rot = rot + 5;
                J=imrotate(I,-rot,'bilinear','crop');
                [Hash2] = saliency_map(J);
                Sim_Dist=corr2(Hash1,Hash2);
                rotation_aclk(i,k) = Sim_Dist;
            end
          
        case 3
            per=0;
            for k=1:10
                per=per+0.001;
                J=imnoise(I,'salt & pepper',per);
                [Hash2] = saliency_map(J);
                Sim_Dist=corr2(Hash1,Hash2);
                salt_pepper(i,k) = Sim_Dist;
             end
            
        case 4
            per=0;
            for k=1:10
                per=per+0.5;
                J=imresize(I,per,'Method','bilinear');          
                [Hash2] = saliency_map(J);
                Sim_Dist=corr2(Hash1,Hash2);
                scaling(i,k) = Sim_Dist;            
            end
            
        case 5
            per=0;
            for k=1:10
                per=per+0.3;
                h = fspecial('gaussian',[3,3],per);
                J=imfilter(I,h);
                [Hash2]=saliency_map(J);
                Sim_Dist=corr2(Hash1,Hash2);
                gaussian_blur(i,k) = Sim_Dist;
            end
            
        case 6
            rad=0;
            for k=1:6
                rad=rad+0.5;
                H=fspecial('disk',rad);
                J=imfilter(I,H,'replicate');
                [Hash2] = saliency_map(J);
                Sim_Dist=corr2(Hash1,Hash2);
                circular_blur(i,k) = Sim_Dist;                
            end
                      
       case 7
            rad=0;
            for k=1:5
                rad=rad+1;
                H=fspecial('average',rad);
                J=imfilter(I,H,'replicate');
                [Hash2] = saliency_map(J);
                Sim_Dist=corr2(Hash1,Hash2);
                average_blur(i,k) = Sim_Dist;
            end
                        
        case 8
            rad=0;
            for k=1:10
                rad=rad+0.01;
                J=imnoise(I,'gaussian',0,rad);
                [Hash2] = saliency_map(J);
                Sim_Dist=corr2(Hash1,Hash2);
                gaussian_noise(i,k)=Sim_Dist;
            end

        case 9
            var=0;
            for k=1:10
                var=var+0.001;
                J = imnoise(I,'speckle',var);
                [Hash2] = saliency_map(J);
                Sim_Dist=corr2(Hash1,Hash2);
                speckle_noise(i,k) = Sim_Dist;
            end

        case 10
            len=0;
            theta = -5;
            for k=1:3
                len = len+1;
                for l =1:3        
                    theta = theta + 5;
                    h = fspecial('motion', len, theta);
                    J=imfilter(I,h);
                    [Hash2] = saliency_map(J);
                    Sim_Dist=corr2(Hash1,Hash2);
                    motion_blur(i,l+(k-1)*3)=Sim_Dist;
                end
            end
        end      
    end
end