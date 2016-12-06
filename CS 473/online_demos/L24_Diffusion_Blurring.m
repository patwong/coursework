%% Lesson 24 - Diffusion Blurring demo

% (C) 2013 Jeff Orchard
%     University of Waterloo


% Read an image
f = imread('t1.jpg');
f = double( f(:,:,1) );
f = f + randn(size(f))*10;

% Set up the diffusion constant
if 1
    % Global blurring
    lambda = 0.05;
else
    % Spatially varying blurring
    % (less blurring at top, more blurring at bottom)
    % The details here don't matter.
    lambda = (1:size(f,1))' - 100;
    lambda = repmat(lambda, 1, size(f,2)); %repeat column
    lambda = 0.1./(1+exp(-lambda/20));
    figure(2); imshow(lambda,[]); title('Diffusion rate');
    pause(5);
end

% Time step for numerical solution of the PDE
delta_t = 1;

% See the original image
figure(1);
imshow(f,[]); title('Original (Noisy)');
pause(2);

%% Time-stepping the PDE
% We'll use the derivative of the derivative (sequence of
% first derivatives).
for n = 1:delta_t:100
    
    % Gradient of f
    [dfdc dfdr] = gradient(f);
    
    % Divergence of the gradient gives the Laplacian
    % http://en.wikipedia.org/wiki/Laplace_operator
    div = (circshift(dfdr,[-1 0])-circshift(dfdr,[1 0]) ...
         + circshift(dfdc,[0 -1])-circshift(dfdc,[0 1])) / 2;
    
    % Explicit time-stepping
    f = f +  delta_t * lambda .* div;
    
    imshow(f,[0 255]); title(['t = ' num2str(n*delta_t)]); drawnow;

end


