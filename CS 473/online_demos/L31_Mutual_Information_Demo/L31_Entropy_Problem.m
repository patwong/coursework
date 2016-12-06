%% Lesson 31 - Joint Entropy Problem Demo

% (C) 2013 Jeff Orchard
%     University of Waterloo


% This script demonstrates how joint entropy, when computed only on the
% overlapping portion of the two images (as is usually done in practice),
% the minimum of the cost function does not necessarily give the correct
% registration.

%% Read in images
f = imread('ct.jpg');
f = double(f(:,:,1));
f = circshift(f, [-4 -18]); % Align f with g
f = padarray(f , [64 64], 'both');

g = imread('t2.jpg');
g = double(g(:,:,1));
g = padarray(g , [64 64], 'both');

% The above images are padded to allow for a more dramatic effect (ie.
% larger overlapping background regions).

figure(3);
subplot(1,2,1); imshow(f,[]);
subplot(1,2,2); imshow(g,[]);

%% Joint Entropy over a range of offsets

figure(1);
ranges = -300:5:300; % These are the offsets we'll try

% We'll store the joint entropy cost for each offset.
cost = zeros(size(ranges));
counter = 1;

plot_hist = 1; % =1 to plot hist, =0 to not plot hist

for offset = ranges

    % First extract the overlapping portions of the two images.
    if offset<0
        moved_f = f(1:(end+offset),:);
        moved_g = g((1-offset):end,:);
    else
        moved_f = f((1+offset):end,:);
        moved_g = g(1:(end-offset),:);
    end

    % Compute (and display) the joint histogram
    p = JointHist(moved_g, moved_f, 64);
    if plot_hist
        imshow(log(p+1),[], 'InitialMagnification', 'fit');
    end

    % Compute the entropy of the joint histogram
    % Note that the joint histogram has to be normalized to properly
    % compute its entropy (ie. you must divide the histogram counts by the
    % total number of samples).
    cost(counter) = JointEntropy(p);
    
    if plot_hist
        title(['Offset = ' num2str(offset)]);
        xlabel('g Intensity (T2-MRI)');
        ylabel('f Intensity (CT)');
        drawnow;
        pause(0.1);
    end
    counter = counter + 1;
    
end

%% Plot how the cost function changes w.r.t. offset
figure(2);
plot(ranges, cost);
xlabel('Offset');
ylabel('Joint Entropy');


