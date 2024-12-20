function [vector_distance] = saliency_map(I)
% Set standard size
M = 512;

% Resize image using bicubic interpolation
I_resized = imresize(I, [M M], 'bicubic');

% Apply Gaussian low-pass filter
sigma = 2;
I_smoothed = imgaussfilt(I_resized, sigma);

% Read in the image and convert to HSV
img = I_smoothed;
hsv_img = rgb2hsv(img);

% Extract the V component
V = hsv_img(:,:,3);

% Calculate the saliency map using LC algorithm
S = zeros(size(V));
for i = 1:size(V, 1)
    for j = 1:size(V, 2)
        pixel = V(i, j);
        contrast = abs(V - pixel);
        S(i, j) = sum(contrast(:));
    end
end

% Normalize the saliency map
S = S ./ max(S(:));

%---------------------------Block Partition---------------------------
feature_matrix = [];
[Image_Height,Image_Width,Number_Of_Colour_Channels] = size(S);
Block_Size = 64;
A_block={[ ]};
Number_Of_Blocks_Vertically = ceil(Image_Height/Block_Size);
Number_Of_Blocks_Horizontally = ceil(Image_Width/Block_Size);
a=0;
for i = 1: +Block_Size: Number_Of_Blocks_Vertically*Block_Size - (Block_Size-1)
    a = a+1; b = 0;
    row_feature = [];
    for j = 1: +Block_Size: Number_Of_Blocks_Horizontally*Block_Size - (Block_Size - 1)
        b= b + 1;
        Block = S(i:Block_Size+i-1,j:Block_Size+j-1);
        C = cov(Block);

        % Compute the eigenvectors and eigenvalues of the covariance matrix
        [V, D] = eig(C);

        % Sort the eigenvalues in descending order
        [sorted_eigvals, sorted_idx] = sort(diag(D), 'descend');

        % Select the top d eigenvectors
        proj_m = V(:, sorted_idx(1:4));
        % Concatenate the columns of proj_m into a column vector
        feature_vector = reshape(proj_m, [], 1);
        
        % concatenate the feature vector horizontally
        row_feature = horzcat(row_feature, feature_vector);

        A_block{a,b} = Block;
    end
    feature_matrix = horzcat(feature_matrix, row_feature);
end 
%------------------------Feature matrix compression & Hash
%generation------------------------%

z0=zeros(1,256);
for i = 1:256 
    temp_sum=0;
    for j = 1:64
        temp_sum = temp_sum + feature_matrix(i,j);
    end    
    z0(i) = temp_sum/64;
end   

z0 = z0.';

vector_distance = zeros(1, 64);

for i = 1:64
    temp_sum = 0;
    for j = 1:256
        temp_sum = temp_sum + ((z0(j)-feature_matrix(j, i)) * (z0(j)-feature_matrix(j, i))); 
    end
    vector_distance(i) = sqrt(temp_sum);
end

for i = 1:64
    vector_distance(i) = round(vector_distance(i)+0.5);
end
end 