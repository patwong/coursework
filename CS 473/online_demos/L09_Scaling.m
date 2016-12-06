%% Lesson 09 - Image scaling using the DFT

% (C) 2013 Jeff Orchard
%     University of Waterloo

% Image scaling can be done by padding and cropping the image/frequency
% domains.  We will blow up our image by a factor of 2 by zero-padding the
% frequency domain.  This effectively extends the sampling in the freq.
% domain.

%% Read in an image to play with
f = imread('ct.jpg');
f = double( f(:,:,1) ); % converts to graylevel floating-pt

figure(1);
imshow(f, []); title('Original image');

%% 2D DFT of the image
% The fftshift puts the DC in (near) the centre of the image array.
F = fftshift( fft2(f) );
figure(2);
imshow(log(abs(F)+1), []); title('Original DFT');

%% Padding in the frequency domain.
% Extend the array by a factor of 2 along each dimension by adding
% zeros around the outside (called padding).
[rows cols] = size(f);
padamt = rows/2; % how many samples to pad on each side
G = padarray(F, [padamt padamt], 'both'); % Pad DFT with zeros
figure(3);
imshow(log(abs(G)+1), []); title('Padded DFT');

%% Inverse DFT
% Thus, the corresponding sample spacing in the spatial domain is half of
% its original.
% ie. twice as many samples in the same spatial field of view (L).
g = ifft2( ifftshift(G) ); % Inverse DFT

figure(4);
imshow(real(g), []); title('Supersampled image');

%% Crop the supersampled image
% If we crop back to our original array size, and assume it's FOV is
% still L, then it's like we scaled up our image by a factor of 2.
orig_range = padamt:(padamt+rows-1);
g_crop = g(orig_range, orig_range); % remove the padding we added before

figure(5);
imshow(real(g_crop),[]); title('Scaled up by a factor of 2');




