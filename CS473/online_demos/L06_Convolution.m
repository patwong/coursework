%% Lesson 06 - Convolution

% (C) 2013 Jeff Orchard
%     University of Waterloo

%% Create convolution kernel, g

% Let's create a circle centred in a 256x256 image.
[r,c] = ndgrid(-128:127, -128:127); % vert & horiz ramps
d = sqrt(r.^2 + c.^2); % distance from centre pixel
g = (d<15); % select pixels less than 15 pixels from centre
g = fftshift(g); % centre g at (1,1) (top-left)
g(1:22,1:5) = 1; % add a little tail so we can determine orientation

%--- TRY IT ---
% Choose a different shape for g
%g = zeros(256); % re-set it to zeros
%g(1:20,1:2) = 1; % a thin vertical rectangle
%---

% Get its DFT
G = fft2(g);

% View it
figure(1);
subplot(1,3,1);
imshow(g, []), title('Circle, g');

%% Now create f

% How about just 2 impulses.
f = zeros(256,256);
f(50,100) = 1;
f(48,120) = 2;

% Get its DFT
F = fft2(f);

%--- TRY IT ---
% Add a third impulse to f.
%---

subplot(1,3,2);
imshow(f,[]), title('Impulses, f');


%% And convolve
f_conv_g = ifft2( F .* G ); % element-wise mult. of Fourier coefs
figure(1);
subplot(1,3,3);
imshow(abs(f_conv_g), []), title('(f*g)');


%% Try convolving circle with an image

% An image of random noise (the same size as the circle image)
%f = rand(size(circle));

% Or uncomment the next 2 lines to try it on an image
f2 = imread('pd.jpg');
f2 = double(f2(:,:,1));

F2 = fft2(f2);

% Element-wise mult. in frequency domain...
f2_conv_g = ifft2( F2 .* G);

figure(2);
subplot(1,2,1);
imshow(f2,[]); title('PD image, f2');
subplot(1,2,2);
imshow(f2_conv_g,[]); title('(f2*g)');



