%% Lesson 21 - Deblurring Demo

% (C) 2013 Jeff Orchard
%     University of Waterloo


%% Read in image f
f = imread('t2.jpg');
f = double(f(:,:,1));

figure(1);
imshow(f,[]); title('Original');
%pause;

%% Blur it with a Gaussian kernel (using the FFT)
F = fftshift( fft2( ifftshift(f) ) );

% Here is the Gaussian kernel
h = Gaussian(1.3, size(f));
H = fftshift( fft2( ifftshift(h) ) );

F_blurred = F .* H; % element-wise mult
f_blurred = fftshift( ifft2( ifftshift(F_blurred) ) );

figure(2);
imshow(abs(f_blurred),[]); title('Blurred');
%pause;

%% Deblur the blurred image

F_blurred = fftshift( fft2( ifftshift( f_blurred ) ) ); % DFT of 
F_deblurred = F_blurred ./ H; % Deconvolve
blah = find(abs(H)<1e-15); % Need to ignore elements where
F_deblurred(blah) = 0;     %  divide-by-zero occurs
f_deblurred = fftshift( ifft2( ifftshift(F_deblurred) ) );

figure(3);
imshow(abs(f_deblurred),[]); title('Noiseless Deblurred');
%pause;

%% Add a teeny-tiny bit of noise.
f_noisy_blurred = f_blurred + 0.001 * randn(size(f));

figure(4);
imshow(abs(f_noisy_blurred),[]); title('Noisy Blurred');
%pause();

%% Deblur the noisy blurred image
F_noisy_blurred = ifftshift( fft2( fftshift(f_noisy_blurred) ) );
F_noisy_deblurred = F_noisy_blurred ./ H; % De-convolve
blah = find(abs(H)<1e-15); % Need to ignore elements where
F_noisy_deblurred(blah) = 0;    %  divide-by-zero occurs
f_noisy_deblurred = ifftshift( ifft2( fftshift(F_noisy_deblurred) ) );

figure(5);
imshow(abs(f_noisy_deblurred),[]); title('Noisy Deblurred');


