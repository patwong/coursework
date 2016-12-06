%% Lesson 26 - Correlation Cost Function

% (C) 2013 Jeff Orchard
%     University of Waterloo


% Registration demo

warning off;

f = imread('t1.jpg');
f = double( f(:,:,1) );

% Choose an offset
offset = [0 0 0 20 45 0];
offset = [0 0 0 7 20 0 ];
disp(['True params needed: (theta,r,c) = (' num2str(offset(3)) ',' num2str(offset(4)) ',' num2str(offset(5)) ')'])

% Shift f and add noise to get g
M = p2m(offset);
g = MyAffine(f, M, 'cubic', 'centred') + randn(size(f))*5;
%g = -g;

figure(1); imshow(f,[]); title('f');
figure(2); imshow(g,[]); title('g');

%% Now try a bunch of different shifts on f

p = -15:1:15;
cost = zeros(size(p)); % to record the costs
denom = sqrt( sum(f(:).^2) * sum(g(:).^2) );

for idx = 1:length(p)
    % Apply shift to f
    fs = MyAffine(f, p2m([0 0 0 0 p(idx) 0]), 'linear');
    
    % Compute cost function
    %cost(idx) = sum( abs(fs(:)-g(:)) );
    cost(idx) = fs(:)' * g(:) / denom;
    
    
end

figure(3);
plot(p, cost); title('Correlation');

%% compute cross correlation using the FFT
F = fft2(f);
G = fft2(g);
CC = ifft2(F.*G);
figure();
imshow(real(CC), []);