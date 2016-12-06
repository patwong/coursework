% function best_m = RigidRegLS(f, g, m0)
%
% Least squares registration of f to g, using a Newton fixed-point
% iteration.
%
% Input
%   f and g are images (volumes) that are the same size
%   m0 is the initial guess for the motion parameters
%      (default [0 0 0 0 0 0])
%
% Output
%   m is the set of motion parameter estimates, in the form
%
%     m = [theta_r theta_c theta_s r c s]
%
%  where the transformation is with respect to Matlab index coordinates
%  centred on the image (volume) centre (see the help for MyAffine).
%
function best_m = RigidRegLS(f, g, m0)

    % Initial motion estimate
    if nargin<3
        % No initial guess? Use identity mapping.
        best_m = [0 0 0 0 0 0];
    else
        best_m = m0; % Initial guess supplied by user
    end

    % Sort out how many dimensions the input is
    dims = size(f);
    ndims = length(dims);
    % If dims are [M N 1], then change that to [M N] (ie. 2D).
    if ndims==3
        if dims(3)==1
            dims = dims(1:2);
            ndims = 2;
        end
    end
    
    %======= YOUR CODE =======
    
    
