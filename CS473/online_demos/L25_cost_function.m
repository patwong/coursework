%% Lesson 25 - Registration Cost Functions

% (C) 2013 Jeff Orchard
%     University of Waterloo


% Registration demo

warning off;

f = imread('t1.jpg');
f = double( f(:,:,1) );

% Choose an offset
offset = [0 0 5 0 0 0];
disp(['True params needed: (theta,r,c) = (' num2str(offset(3)) ',' num2str(offset(4)) ',' num2str(offset(5)) ')'])

% Shift f and add noise to get g
M = p2m(offset);
g = MyAffine(f, M, 'cubic', 'centred') + randn(size(f))*5;

figure(1); imshow(f,[]); title('f');
figure(2); imshow(g,[]); title('g');

%% Now try a bunch of different shifts on f

p = -15:1:15;
cost = zeros(size(p)); % to record the costs

for idx = 1:length(p)
    % Apply shift to f
    fs = MyAffine(f, p2m([0 0 0 0 p(idx) 0]), 'linear','centred');
    
    % Compute cost function
    cost(idx) = sum( abs(fs(:)-g(:)) );
    
end

figure(3);
plot(p, cost); title('Sum of Absolute Differences');


