clear;
clc;
workspace;

filenames={'a.tiff', 'airplane.png', 'Akiyo.png', 'alu.tif', 'b.tiff', 'baboon.png', 'bandon.tif', 'barbara.bmp', 'brandyrose.tif', 'c.tiff', 'Carphone.png', 'Coastguard.png', 'Container.png', 'd.tiff', 'e.tiff', 'f.tiff', 'fruits.png', 'girl.png', 'Goldhill.png', 'h.tiff','Hall.png','i.tiff','kid.tif','Kodak.png','Lake.png','lena.png','lochness.tif','Mobile.png','MothernDaughter.png','News.png','newyork.tif','opera.tif','papermachine.tif','peppers.png','pills.tif','stomach.bmp','terraux.tif','tiffany.bmp','tulips.png','watch.tif','water.tif','waterall.bmp','wildflowers.tif'};

ab_mb = zeros(40, 5);
gn_gf = zeros(40, 10);
gn_spk = zeros(40, 10);
sp_gf = zeros(40, 10);
cb_spk = zeros(40, 10);

for i=1:40
absloc=strcat('D:\Downloads\FinalYearProj\FinalYearProj\similarImages\',filenames{1,i});
I=imread(absloc);
[Hash1] = PHOG_hash(I);
    for sw=1:6
        switch sw
        case 1
            len=0;
            theta=0;
            for k=1:5
                len=len+1;
                theta = theta+2;
                H=fspecial('average',len);
                J=imfilter(I,H,'replicate');
                h = fspecial('motion', len, theta);
                j=imfilter(J,h);
                [Hash2] = PHOG_hash(j);
                Sim_Dist=corr2(Hash1,Hash2);
                ab_mb(i,k) = Sim_Dist;
            end
         
        case 2
            rad=0;
            per=0;
            for k=1:10
                rad=rad+0.001;
                per = per+0.3;
                J=imnoise(I,'gaussian',0,rad);
                h = fspecial('gaussian',[3,3],per);
                j=imfilter(J,h);
                [Hash2] = PHOG_hash(j);
                Sim_Dist=corr2(Hash1,Hash2);
                gn_gf(i,k)=Sim_Dist;
            end
    
        case 3
            per=0;
            var=0;
            for k=1:10
                per=per+0.001;
                var=var+0.001;
                J=imnoise(I,'gaussian',0,per);
                j = imnoise(J,'speckle',var);
                [Hash2] = PHOG_hash(j);
                Sim_Dist=corr2(Hash1,Hash2);
                gn_spk(i,k) = Sim_Dist;         
            end
            
        case 4
            per=0;
            for k=1:10
                per=per+0.001;
                J=imnoise(I,'salt & pepper',per);   
                h = fspecial('gaussian',[3,3],per);
                j=imfilter(J,h);
                [Hash2] = PHOG_hash(j);
                Sim_Dist=corr2(Hash1,Hash2);
                sp_gf(i,k) = Sim_Dist;
            end
            
        case 5
           rad=0;
           for k=1:10
               rad=rad+0.001;
               H=fspecial('disk',rad);
               J=imfilter(I,H,'replicate');
               j = imnoise(J,'speckle',rad);
               [Hash2] = PHOG_hash(j);
               Sim_Dist=corr2(Hash1,Hash2);
               cb_spk(i,k) = Sim_Dist;
           end
        end      
    end
end