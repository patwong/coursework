%% Lesson 09 Fourier Rotation

% (C) 2013 Jeff Orchard
%     University of Waterloo


%% Read in an image to play with
% A square image... keep it simple for now.
f = imread('ct.jpg');
f = double( f(:,:,1) ); % converts to graylevel floating-pt
N = size(f,1);

figure(1);
subplot(1,2,1);
imshow(f, []); title('Original image');
theta = 30; % Rotation angle (in degrees)

% Ignore this for now.
%pa = 200;
%f = padarray(f, [pa pa], 'both'); % Pad image with zeros

%% 2D-DFT
F = fftshift( fft2( ifftshift(f) ) );

%% Rotate in the frequency domain
G = imrotate(F, theta, 'bicubic', 'crop');

figure(2);
subplot(1,2,1);
imshow(log(abs(F)+1), []); title('Original DFT');
subplot(1,2,2);
imshow(log(abs(G)+1), []); title('Rotated DFT');

%% Inverse 2D-DFT
% Reconstruct the resulting image
g = fftshift( ifft2( ifftshift(G) ) );

% Crop to extract the central part of the image
% (The line below does nothing if padamt=0)
%g = g((pa+1):(end-pa-2),(pa+1):(end-pa-2)); % remove the padding we added before

figure(1);
subplot(1,2,2),
imshow(real(g), []), title(['Rotated by ' num2str(theta) ' degrees']);



