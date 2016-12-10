%% Lesson 21 - Deblurring using a matrix

% (C) 2013 Jeff Orchard
%     University of Waterloo


%% Ill-Conditionedness of the Blur Matrix

N = 8; % start small
N = 64;

% This will be our blur matrix
D = zeros(N^2, N^2);

% Creat a Blur kernel
K = [0 1 0;
     1 2 1;
     0 1 0];
%K = fspecial('gaussian', [N N], 2);
K = K / sum(K(:));  % normalize it so it sums to 1

% Embed the kernel in an NxN image, centred at (1,1)
K2 = zeros(N,N);
K2(1:size(K,1), 1:size(K,2)) = K;
K2 = circshift(K2, -(size(K)-1)/2);


%% Construct blur matrix one row at a time
% Each row (and column) represents a pixel.  The value stored in element
% (i,j) is the degree to which pixel i blurs to pixel j.
counter = 1;
for c = 1:N
    for r = 1:N
        Ks = circshift(K2, [r-1 c-1]);
        D(counter,:) = reshape(Ks, 1, N^2);
        counter = counter + 1;
    end
end

spy(D);

%% Try the blur matrix on an image
f = imread('t2.jpg');
f = imresize(double(f(:,:,1)), [N N], 'bilinear');

f_vec = reshape(f, N^2, 1); % reformat NxN image into N^2x1 column vector
g = D * f_vec; % Multiply by blur matrix
figure(1); imshow(reshape(f_vec,N,N),[],'InitialMagnification',400); title('Original image');
%pause;

figure(2); imshow(reshape(g,N,N),[],'InitialMagnification',400); title('Blurred');
%pause;

%% Add a tiny bit of noise, and try to invert the blurring matrix
g = g + randn(size(g))*0.03;
f_deblurred = D \ g;
figure(3);
imshow(reshape(f_deblurred,N,N), [], 'InitialMagnification',400); 
title('Unblurred');


