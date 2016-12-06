%% Lesson 09 - Fourier Shift Theorem

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

%% 2D-DFT
% It's important to put the DC in the centre so the phase ramp can be
% positive on one side, and negative on the other.
F = fftshift( fft2(f) ); % 2D-DFT of image

%% Generate a ramp
% Start with 2 ramps, one along row-dim, and one along col-dim.
[r c] = ndgrid(-128:127, -128:127);

% Decide on the translation you want
down = 20; % Desired shift down
right = 40; % Desired shift to the right
ramp = (r*down+c*right)/N; % phase ramp
eramp = exp(-2i*pi*ramp);

figure(2);
imshow(real(ramp), []); title('Phase ramp');

%% Apply ramp to Fourier coefs
G = eramp .* F;

%% Inverse 2D-DFT
g = ifft2( ifftshift(G) );

figure(1);
subplot(1,2,2),
imshow(real(g),[]);
title(['Shifted (' num2str(down) ', ' num2str(right) ') pixels']);


