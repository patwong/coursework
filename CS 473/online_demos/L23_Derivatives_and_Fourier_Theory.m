%% Lesson 23 - Derivatives and Fourier Theory

% (C) 2013 Jeff Orchard
%     University of Waterloo


%% Read in image f
f = imread('t1.jpg');
f = double(f(:,:,1));

figure(1);
imshow(f,[]); title('Original');
%pause;

%% Take the DFT, and zero-shift (place DC in centre of image)
F = fftshift( fft2( f ) );

%% Construct a ramp along the r-axis, with zero at the DC
ctr = ceil( (size(F)+1) / 2 );

omega = ( 1:size(F,1) )' - ctr(1);
omega = repmat(omega, 1, size(F,2));

figure(2);
imshow(omega,[]); title('Ramp');

%% Use the ramp on the Fourier coefficients to get derivative
dFdr = 2*pi*1i*omega.*F;

%% And go back to the spatial domain (IDFT)
dfdr = ifft2( ifftshift( dFdr ) );

figure(3);
imshow(real(dfdr), []); title('df/dr');


%% We can combine the blurring and derivative operation

F = fft2( f + randn(size(f))*10 ); % add noise, and take DFT of f

g = Gaussian(2, size(f));

dgdr = (circshift(g,[-1 0])-circshift(g,[1 0]))/2;
figure(4);
imshow(dgdr,[]); title('Deriv. of Gaussian');

% Shift Gaussian to upper-left, take DFT
dGdr = fft2( ifftshift(dgdr) );

% Element-wise multiplication
dFdr = F .* dGdr;

% IDFT (with opposite of previous shifts)
dfdr = ifft2( dFdr );

figure(5);
imshow(real(dfdr),[]); title('Blurred df/dr');
