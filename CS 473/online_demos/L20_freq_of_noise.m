%% Lesson 20 - Frequency composition of noise

% (C) 2013 Jeff Orchard
%     University of Waterloo


%% Load a 1D signal

% We'll use one row from an image
img = imread('t2.jpg');
img = double(img(:,:,1));
f = img(128,:); % extract only the 128th row
F = fftshift( fft( ifftshift(f) ) ); % used later
figure(1);
subplot(3,1,1); plot(f); title('Original');
axis([0 255 -50 150]); % set axis limits same on all plots

% Add some Gaussian noise
fn = f + randn(1,256)*15;
Fn = fftshift( fft( ifftshift(fn) ) );
subplot(3,1,2); plot(fn); title('Noisy');
axis([0 255 -50 150]); % set axis limits same on all plots

% Window-averaging kernel (constant)
h = zeros(1,256);
radius = 2;
h((129-radius):(129+radius)) = 1;
h = h / sum(h(:)); % normalize (so they add to 1)
H = fftshift( fft( ifftshift(h) ) );

% Convolve (in the frequency domain)
G = H .* Fn;
g = fftshift( ifft( ifftshift(G) ) );
subplot(3,1,3); plot(real(g)); title('Noisy Blurred');
axis([0 255 -50 150]); % set axis limits same on all plots

%% Look at the situation in the frequency domain
figure(2);

% Frequency domain: original and noisy
subplot(2,1,1);
plot(log(abs(Fn)+1),'r'); hold on;
plot(log(abs(F)+1),'b'); hold off;
title('FT of original (blue) and noisy (red)');

% Frequency domain: effect of filter
subplot(2,1,2);
plot(10*log(abs(H)+1),'k'); hold on; % scaled to see it better
plot(log(abs(G)+1),'r'); hold off;
title('FT of filter (green) and denloised (red)');


