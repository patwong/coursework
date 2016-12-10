%% Lesson 31 - Mutual Information Problem Demo

% (C) 2013 Jeff Orchard
%     University of Waterloo


% Try running this with a pad_amount of 0, 128 and 256
% (or other values).
%
pad_amount = 128;
bins = 128;
measure = 'mi'; % 'entropy', 'mi', 'nmi', 'pvi', 'Parzen', 'blur'

%% Read in images
f = imread('ct.jpg');
f = double(f(:,:,1));
f = padarray(f , [pad_amount 0], 'both');

g = imread('t2.jpg');
g = double(g(:,:,1));
g = padarray(g , [pad_amount 0], 'both');

% This function pads f and g so that they are the same size.
% Type "help SameSize" for more information.
%[fp gp r] = SameSize(f, g);
fp = f; gp = g; fmask = ones(size(f)); gmask = fmask;

% Construct a mask for each image to help determine the overlap
%{
fmask = zeros(size(fp));
fmask(r(1,1):r(1,2), r(1,3):r(1,4)) = 1;
gmask = zeros(size(gp));
gmask(r(2,1):r(2,2), r(2,3):r(2,4)) = 1;
%}

% Shift for centre pixel in the padded images
%T = p2m([0 0 0 floor( (size(fp)+1) / 2 ) 0]);

offsets = [-90:2:-10 -9:1:9 10:2:90];
cost = zeros(size(offsets));
counter = 1;

figure(2);

for offset = offsets
    
    % Move fp and fmask
    M = p2m([0 0 offset 0 0 0]);
    moved_fp = MyAffine(fp, M, 'linear','centred');
    moved_fmask = MyAffine(fmask, M, 'linear','centred');

    % The image "overlap" is the part of the padded image where the
    % two original images intersect.
    overlap = ( moved_fmask .* gmask ) > 0.0001;
    
    % Compute and record the MI cost
    cost(counter) = mi(moved_fp, gp, overlap, bins, measure);
    
    subplot(1,2,1);
    % Plot offset vs. cost
    plot(offsets(1:counter), cost(1:counter) );
    % Adjust axes dynamically to fit nicely
    axis([offsets(1) offsets(end) min(cost(1:counter))-0.00001 max(cost(1:counter))]);
    
    subplot(1,2,2);
    imshow(moved_fp+overlap*100+gp,[0 612]);
    drawnow;
    
    counter = counter + 1;

end





