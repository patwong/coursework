% function [memb phi] = GMMSegmentation(stack, phi0)
%
%  Performs segmentation with the Estimation Maximization (EM) algorithm
%  using a Gaussian Mixture Model (GMM).
%
%  Input:
%   stack is a 3D array, storing one feature (image) per slice.
%   phi0 is a cell array with the initial component parameters, where
%        phi0{k}.mu stores the mean for component k,
%        phi0{k}.Sigma stores the covariance matrix for component k, and
%        phi0{k}.pi stores the mass of component k.
%
%  Output:
%   memb is a 3D array of membership maps, with slices the same size
%        as the input stack, but with K slices (where K is the
%        number of components in phi0).
%   phi is a cell array with the final set of Gaussian components.
%
% [**10** marks total]
%
% [*1*] for code readability and efficiency
function [memb phi] = GMMSegmentation(stack, phi0)

    phi = phi0; % working copy of GMM
    
    [rows cols D] = size(stack); % # and dimension of features
    n_pixels = rows * cols; % # of pixels to classify
    
    K = length(phi); % number of GMM components
    
    % Store the stack of features images in an array so that the features
    % for one pixel are stored in a row.
    img = reshape(stack, [n_pixels  D]);
    
    % Allocate space for pixel membership values (tau_kx),
    % and set the initial values to be uniform.
    memb = ones(n_pixels, K) / K;


    %%%%% YOUR CODE STARTS HERE %%%%%
    iters = 1;
    while iters <= 30
        %for convergence condition
        old_tau_nk = memb;
        
        %step 2 - compute tau_nk - pixel membership
        %first calculate the numerator of tau_nk
        for small_k = 1:K
            %using consts beacuse clutterered
            mu_k = phi{small_k}.mu;
            sigma_k = phi{small_k}.Sigma;
            inv_sigma_k = inv(phi{small_k}.Sigma);
            pi_k = phi{small_k}.pi;
            n_const = pi_k/sqrt((2*pi)^D * det(sigma_k));
            for pixn = 1:n_pixels
                i_sub_mu = img(pixn,:) - mu_k;
                n2 = exp(-0.5 * i_sub_mu * inv_sigma_k * (i_sub_mu'));
                memb(pixn,small_k) = n_const*n2;
            end
        end
        
        %calculating denominator OR using default
        tau_denom = sum(memb,2);
        %default_vect used if tau too small
        default_vect = (1/K)*ones(1,K);
        for pixn = 1:n_pixels
            if tau_denom(pixn) < 10^-10
                memb(pixn,:) = default_vect;
            else
                memb(pixn,:) = memb(pixn,:)/tau_denom(pixn);
            end
        end
        
        mu_numerator = zeros(n_pixels,D);
        for small_k = 1:K
            %step 3 - update mu's - only if iters > 3
            sum_taus = sum(memb(:,small_k));
            if iters > 3
                for z22 = 1:D
                    mu_numerator(:,z22) = memb(:,small_k) .* img(:,z22);
                end
                phi{small_k}.mu = sum(mu_numerator)/sum_taus;
            end
            
            %step 4 - update covariance matrices - sigma_k
            [sr1, sc1] = size(phi{small_k}.Sigma);
            sigma_acc = zeros(sr1,sc1);
            for pixn = 1:n_pixels
                i_sub_mu = img(pixn,:) - phi{small_k}.mu;
                sigma_acc = sigma_acc + memb(pixn,small_k)* (i_sub_mu') * i_sub_mu;
            end
            phi{small_k}.Sigma = sigma_acc/sum_taus;
        end
        
        %step 5 - update component masses - pi_k
        sum_of_all_taus = sum(sum(memb));
        for small_k = 1:K
            sum_taus = sum(memb(:,small_k));
            phi{small_k}.pi = sum_taus / sum_of_all_taus;
        end
        %=== Sample Display code ===
        % You might want to put this in your iteration loop.
        
        % Display the membership maps.
        figure(3);
        plotcols = 3;
        for k = 1:min(K,2*plotcols)
            subplot(2,plotcols,k);
            imshow(reshape(memb(:,k), [rows cols]),[]);
        end
        
        % Display the joint intenstiy scatter plot.
        figure(4);
        ScatterPlot(img, phi);
        %=== End of Sample Display code ===
        
        if ((1/n_pixels*K)*sum(sum(abs(memb - old_tau_nk)))) < 0.002
            break;
        else
            iters = iters + 1;
        end
        
    end
    
    % Reshape the matrix format to a stack of K membership images.
    memb = reshape(memb, [rows cols K]);
end