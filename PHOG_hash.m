function [all_phog_hist] = PHOG_hash( rgbImage )

% Get the dimensions of the image.  numberOfColorBands should be = 3.
[rows, columns, numberOfColorChannels] = size(rgbImage);
% Display the original color image.
%figure,
%imshow(rgbImage);
% Get the max image
maxImage = max(rgbImage, [], 3);
% The outer rows and columns seem to be all zeros, so delete them
if all(maxImage(1,:) == 0)
	maxImage = maxImage(2:end, :);
end
if all(maxImage(end,:) == 0)
	maxImage = maxImage(1:end-1, :);
end
if all(maxImage(:, 1) == 0)
	maxImage = maxImage(:, 2:end);
end
if all(maxImage(:, end) == 0)
	maxImage = maxImage(:, 1:end-1);
end
% Get the last row
lastRow = maxImage(end,:);
% Find out where the last non-zero pixel is
originX = find(lastRow~=0, 1, 'last');
originY = rows;
% Get the last column
lastColumn = maxImage(:, end);
% Find out where the last non-zero pixel is
raisedY = find(lastColumn~=0, 1, 'last');
raisedX = columns;
% Find the slope
deltaY = (originY - raisedY);
deltaX = (raisedX - originX);
% Turn this into an angle.
angle = atan2d(deltaY, deltaX);
% Rotate image to "fix" it
rotatedImage = imrotate(rgbImage, -angle,'bilinear','crop');

% Get rid of black surround
% First get the max image again
maxImage = max(rotatedImage, [], 3);
% Find the non-zero pixels
mask = maxImage > 150;
[rows, columns] = find(mask);
row1 = min(rows);
row2 = max(rows);
col1 = min(columns);
col2 = max(columns);
croppedImage = rotatedImage(row1:row2, col1:col2, :);
% Display the rotated color image.
%figure,
%imshow(croppedImage);


%Image Resize
%image = imread('house.tiff');
dImage = imresize(croppedImage, [256, 256]);
size(dImage)
%figure, imshow(dImage);


%Low Pass Filter
blurred = imgaussfilt(dImage,1);
%imshow(blurred);
%title('After low pass');
%figure, imshow(dImage);
%title('Before low pass');


%Log-Polar Transform
Log_sample = logsample(blurred, 1, 150, 128, 128, 256, 256);
%Display log polar transformed image
%figure, imshow(Log_sample);


%Block Partition
[Image_Height,Image_Width,Number_Of_Colour_Channels] = size(Log_sample);
Block_Size = 64;
Number_Of_Blocks_Vertically = ceil(Image_Height/Block_Size);
Number_Of_Blocks_Horizontally = ceil(Image_Width/Block_Size);
Image_Blocks = struct('Blocks',[]);
all_phog_hist=zeros(0);
Index = 1;
for Row = 1: +Block_Size: Number_Of_Blocks_Vertically*Block_Size
    for Column = 1: +Block_Size: Number_Of_Blocks_Horizontally*Block_Size
        Row_End = Row + Block_Size - 1;
        Column_End = Column + Block_Size - 1;
        if Row_End > Image_Height
           Row_End = Image_Height;
        end
        if Column_End > Image_Width
           Column_End = Image_Width;
        end
        Temporary_Tile = Log_sample(Row:Row_End,Column:Column_End,:);
        %Storing blocks/tiles in structure for later use%
        Image_Blocks(Index).Blocks = Temporary_Tile;
        [ PHOG_hist, ~ ] = desc_PHOG( double(rgb2gray(Temporary_Tile)), 2, 180, 'nh' );
        %PHOG_hist=PHOG_hist*255*10;
        all_phog_hist = horzcat(all_phog_hist, PHOG_hist);
        Index = Index + 1;
    end
end
end