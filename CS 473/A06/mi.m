% function H = mi(f, g, bins)
%
%  Input
%   f and g are images (volumes), and must be the same size.
%   bins is the number of histogram bins to use for each axis
%     (integer in range 2-256)
%
%  Output
%   H is the mutual information value (scalar)
%
function H = mi(f, g, bins)

    % Extract range of intensities
    minval = min([f(:) ; g(:)]);
    maxval = max([f(:) ; g(:)]);

    % Set up bin centres
    binwidth = (maxval-minval+1) / (bins);
    bin_ctrs{1} = (minval-0.5+binwidth/2):binwidth:(maxval+1-binwidth/2);
    bin_ctrs{2} = bin_ctrs{1};

    pts = [f(:) g(:)];
    
    % Joint histogram
    a = hist3(pts, bin_ctrs);

    [r,c] = size(a);
    b = a/size(pts,1); % normalized joint histogram
    
    % Maginal histograms
    y_marg = sum(b,1); %sum of the rows of normalized joint histogram
    x_marg = sum(b,2); %sum of columns of normalized joint histogran

    % The standard formula for MI is undefined for elements of probability
    % zero, so we have to handle those cases differently -- they contribute
    % zero to MI.  A simple (?) way to take care of it is to create a mask
    % that puts a 1 in each bin where there is a zero.  Then, we simply add
    % that to the histogram inside the log function, which then nicely
    % evaluates to zero for those cases (ie. log(0+1)=0).
    exceptions = (y_marg==0); % mask
    Hy = -sum(y_marg.*(log2(y_marg+exceptions))); % joint entropy
    exceptions = (x_marg==0);
    Hx = -sum(x_marg.*(log2(x_marg+exceptions))); % joint entropy
    exceptions = (b==0);
    H_xy = -sum(sum(b.*(log2(b+exceptions)))); % joint entropy
    
    % MI formula
    H = Hx + Hy - H_xy;
    
    
    
    
    