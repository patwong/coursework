%% Lesson 28 - Phase Ramp Registration

% (C) 2013 Jeff Orchard
%     University of Waterloo


%% Read in an image
f = imread('pd.jpg');
f = double(f(:,:,1));

% Create shifted, noisy version
d = [3.5 9.5];
g = MyAffine(f, p2m([0 0 0 d 0]), 'cubic') + randn(size(f))*5;

%% Create a ramp of our own

N = size(f,1);
[r c] = ndgrid(-128:127, -128:127);
truePhaseDiff = exp(-2*pi*1i*(d(1)*r + d(2)*c)/N);


%% Derive the ramp from the images

F = fftshift( fft2( ifftshift(f) ) );
G = fftshift( fft2( ifftshift(g) ) );

imgPhaseDiff = G ./ F;

figure(1);
imshow((imgPhaseDiff), [-1 1]), title('Observed Phase Difference');

figure(2);
imshow(truePhaseDiff,[-1 1]),  title('Theoretical Phase Difference');


%% IFFT of R

r = ifft2( ifftshift(imgPhaseDiff) );
figure(3);
imshow(abs(r), []); title('IDFT of Phase Difference');

[val row col] = GetMaxElement(abs(r));

row = row - 1;
col = col - 1;

disp(['Optimal shift is down ' num2str(row) ' and right ' num2str(col)]);
