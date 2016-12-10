% GMM segmentation test script

warning off;

%=== User options ===
dataset = 1; % 1=small, 2=full-sized
hard_init = 1; % 1=use hardcoded initialization, 0=user entered
%===

% Read in 3 modalities of the same content
switch dataset
    case 1
        f = imread('brainweb_t1_small.jpg'); f = double( f(:,:,1) );
        g = imread('brainweb_t2_small.jpg'); g = double( g(:,:,1) );
        h = imread('brainweb_pd_small.jpg'); h = double( h(:,:,1) );
    case 2
        f = imread('brainweb_t1.jpg'); f = double( f(:,:,1) );
        g = imread('brainweb_t2.jpg'); g = double( g(:,:,1) );
        h = imread('brainweb_pd.jpg'); h = double( h(:,:,1) );
end

% Put the images into a stack.
%stack = cat(3, g, h); % stack has 3 features
stack = cat(3, f, g, h); % stack has 3 features
D = size(stack,3);  % D is # of features (images)

% Add a bit of noise.  The noise actually helps to stabilize
% the process.  The next two lines sets the random number generator.
% For a given seed, it will give the same set of "random" numbers.
% Change the number after 'Seed' to get a different set of numbers.
s = RandStream('mt19937ar','Seed',337); % <-- change to get diff'nt #s
RandStream.setGlobalStream(s);
stack = stack + randn(size(stack))*5;

% Choose some pixels to initialize the components
% I've hardcoded 4 (so K=4), but you can also use ginput to
% choose some points yourself (hit "Return" when you're done clicking).
if hard_init==1
    switch dataset
        case 1 % for small
            r = [72 63 103 58] / 2;
            c = [81 73 106 27] / 2;
        case 2
            r = [72 63 103 58];
            c = [81 73 106 27];
    end
else
    % Use ginput to select points using the mouse.  Hit the "Return"
    % key when you're done.
    figure(2);
    imshow(h,[]);
    [c r] = ginput;
end

% How many Gaussian components do we have?
K = length(c);

% We will use a cell array to store Gaussian components.
phi = cell(K,1);
% For example...
%   phi{1}.mu is the mean (centroid) of comp 1
%   phi{1}.Sigma is the covariance matrix of comp 1
%   phi{k}.pi is the mass of comp k

% Initialize the components of the GMM
for k = 1:K
    % Extract intensity values for chosen pixels
    % Notice that component means are stored as row vectors.
    Ir = round(r(k)); %  \ Extract row and col coords
    Ic = round(c(k)); %  /  (make sure they're integers)
    phi{k}.mu = reshape( stack(Ir,Ic,:) , [1 D 1]); % mean
    phi{k}.Sigma = eye(D); % start out with isotropic covariance
    phi{k}.pi = 1/K; % start out with equal weight for all components
end

% Call GMM Segmentation function
[memb phi] = GMMSegmentation(stack, phi);

% Display membership maps.
figure(1);
plotcols = 3;
for k = 1:min(K,2*plotcols)
    subplot(2,plotcols,k);
    imshow(memb(:,:,k),[]);
end

% Display composite membership map, where each component
% is assigned a different intensity.
composite = K*memb(:,:,1);
for k = 2:K
    composite = composite + (K-k+1)*memb(:,:,k);
end
figure(2);
imshow(composite,[]);


