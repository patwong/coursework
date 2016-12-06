%% Lesson 09 - Fourier wavefront demo

% (C) 2013 Jeff Orchard
%     University of Waterloo


%% Create a 2D array of Fourier coefs (all zero)

F = zeros(256,256);

%% Choose one to be non-zero.

F(5,1) = 1;

%% Now take the inverse 2D-DFT.

f = ifft2( F );

figure(1);
subplot(1,2,1);
imshow(F, []); title('F');
subplot(1,2,2);
imshow(real(f), []); title('f');




