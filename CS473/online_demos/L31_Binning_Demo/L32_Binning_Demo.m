%% Lesson 32 - Binning Discontinuity Demo

% (C) 2013 Jeff Orchard
%     University of Waterloo


%% === Options ===

% Try:
% mi, large, 128
% mi, small, 128
% mi, small, 32
dataset = 't1_t2';     % 't1_t2' or 'ct_t2'

% Choose a similarity measure
sim = 'mi';           % Try 'mi', 'pvi', or 'blur'

% Choose a range of translations
range = 'large';    % Try 'small' or 'large'

% === end of options ===

%% Evaluate for different offsets

bins = 256; % # of bins for joint histogram

switch range
    case 'small'
        offsets = -0.6:0.01:0.6;
    case 'large'
        offsets = -4:0.1:4;
end

switch dataset
    case 'ct_t2'
        f_name = 'new_ct.jpg';
        g_name = 'new_t2.jpg';
    case 't1_t2'
        f_name = 't1.jpg';
        g_name = 't2.jpg';
end

% Read in images
% Read in images
f = imread(f_name);
f = double(f(:,:,1));

g = imread(g_name);
g = double(g(:,:,1));
g = MyAffine(g, p2m([0 0 45 0 0 0]), 'cubic', 'centred') + randn(size(g))*10;

overlap = ones(size(f));

cost = zeros(size(offsets));
counter = 1;

figure(1);

for offset = offsets
    
    % Move fp and fmask
    %M = T * p2m([0 0 0 offset 0 0]) / T;
    M = p2m([0 0 45 offset 0 0]);
    moved_f = MyAffine(f, M, 'cubic','centred');
    
    % Compute and record the MI cost
    cost(counter) = mi(moved_f, g, overlap, bins, sim);
    
    subplot(1,2,1);
    % Plot offset vs. cost
    plot(offsets(1:counter), cost(1:counter) );
    % Adjust axes dynamically to fit nicely
    axis([offsets(1) offsets(end) min(cost(1:counter))-0.00001 max(cost(1:counter))+0.00001]);
    %grid on;
    
    % superimpose images
    subplot(1,2,2);
    imshow(moved_f - g,[]);
    
    drawnow;
 
    counter = counter + 1;

end





