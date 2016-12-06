%% Lesson 20 - Blur an image 

% (C) 2013 Jeff Orchard
%     University of Waterloo


% Load an image
f = imread('t2.jpg');
f = double(f(:,:,1));
figure(3);
imshow(f,[]); title('Original');

% Add some noise
fn = f + randn(size(f))*15;
figure(4);
imshow(fn,[]); title('Noisy');

% Create a convolution kernel

% Block filter
radius = 2;
h = zeros(size(f));
h((128-radius):(128+radius),(128-radius):(128+radius)) = 1;

% Or Gaussian
%h = Gaussian(1.5, size(f));

% Normalize so sum is 1
h = h / sum(h(:));

% Convolve (in frequency domain)
% Notice I don't fftshift in the frequency domain; no need to
% since I'm not visualizing it.
Fn = fft2( ifftshift(fn) );
H = fft2( ifftshift(h) );
G = H .* Fn;

% IDFT to get the result
g = fftshift( ifft2( G ) );

figure(5);
imshow(real(g), []); title('Filtered Noisy Image');

