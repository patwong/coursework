%% Lesson 05 - Fourier Transform

% (C) 2013 Jeff Orchard
%     University of Waterloo

%% Start with a 1D signal

% We'll take it from a single row in an image.
img = imread('t1.jpg');
img = img(:,:,1); % Just in case it's a colour image

f = img(128,:);  % taking only row 128

%% Plot our signal

figure(1);
plot(f);

%% Discrete Fourier Transform

% The DFT function is called "fft".
% The documentation for fft states that it works for single and double
% input.  So we cast our signal to double.

%===== YOU DO IT =====
% Cast f to double, and save the result back in f

%=====

% DFT (which uses the FFT algorithm)
F = fft(f);

%% Viewing the Fourier coefficients

figure(2);
plot(real(F));
hold on;  % stops you from overwriting the plot (until "hold off")
plot(imag(F), 'r');
title('Real and Imaginary parts');
hold off;

%% Better viewing of Fourier coefs

figure(3);
plot(abs(F)); % Plots the modulus of the Fourier coefs
title('Modulus');

% Plot the log of the (modulus+1)
figure(4);
plot(log(abs(F)+1));
title('Log of Modulus');

%% Zero-shifting

% We often want to shift the DC to the middle

F_z = fftshift(F);

%===== YOU DO IT =====
% Create a figure and plot the log-modulus of F_z



%=====


%% What exactly does fftshfit do?

% Where is the DC now?  Let's do an experiment.

even_array = [1 2 3 4]; % array of length 4
even_array_z = fftshift(even_array)

odd_array = [1 2 3 4 5 6 7]; % array of length 5
odd_array_z = fftshift(odd_array)

% Here is a formula that tells us where the DC will end up.
% We will actually use this formula a lot.

even_ctr = ceil( (length(even_array)+1) / 2 )

%===== YOU DO IT =====
% Find the centre index for odd_array, store it in odd_ctr

%=====

even_array_z(even_ctr)


%% Undoing Zero-shifting

% Now, to undo it, we use ifftshift because it behaves differently with
% even- and odd-length arrays (just like fftshift).
ifftshift(even_array_z)

%===== YOU DO IT =====
% Unshift the odd-length array

%=====


%% 2D DFT

% Use fft2 instead of fft.

% We'll use our image, but cast it to double.
img = double(img);

figure(6);
imshow(img,[]);
title('image');

figure(7);
Img = fft2(img);
imshow( log(abs(Img)+1), []);
title('DFT of image (log mod)');

% fftshift works on higher-dimensional arrays too
Img_z = fftshift(Img);

%===== YOU DO IT =====
% Create a figure and show the log-mod of Img_z



%=====

% And where is the DC?
ctr = ceil( (size(Img_z)+1) / 2 );
Img_z(ctr(1), ctr(2))
Img(1,1)


%% Your own 2D DFT

% 1D DFT of columns first
Img_col = fft(img); % fft works on columns by default

% Then 1D DFT of rows
Img2 = fft(Img_col, [], 2); % apply DFT along dim 2 (rows)
% type "help fft" for more info

% Compare ours to the one from fft2
diff = abs(Img-Img2); % should be close to zero
max(diff(:)) % make it a column, then find max of col

