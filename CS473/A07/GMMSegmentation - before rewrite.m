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
    big_d = D;
    
    %step 2 - compute tau_nk - pixel membership
    for small_k = 1:K
       %calculate numerator
       %const used in N(...)
       mu_k = phi{small_k}.mu;
       sigma_k = phi{small_k}.Sigma;
       pi_k = phi{small_k}.pi;
       n_const = pi_k/sqrt((2*pi)^D * det(sigma_k));
       for pixn = 1:n_pixels
           %numerator
           i_sub_mu = img(pixn,:) - mu_k;
           
       end
    end
    for pixn = 1:n_pixels
        I_n = img(pixn,:); %gets row vector from img, turns into col vector - IGNORE, send row
        big_n_vect = zeros(K,1);
        tau_denom = 0;
        for small_k = 1:K
            %given pixel n, get N(...) for all k
            big_n_vect(small_k) = n_calc(I_n,small_k);
            tau_denom = tau_denom + phi{small_k}.pi * big_n_vect(small_k);
        end
        if tau_denom < 10^-15
            %display('hi')
            memb(pixn,:) = (1/K)*ones(1,K);
        else
            for small_k = 1:K
                memb(pixn,small_k) = (phi{small_k}.pi) * big_n_vect(small_k) / tau_denom;
            end
        end
        if pixn == 2767 %2768 has NaN
            display('hi')
        end
        %if sum < 10^-10, re-assign tau_nk to 1/K
        %if sum(tau_nk(pixn,:)) < 10^-10
        %    tau_nk(pixn,:) = (1/K)*ones(1,K);
        %end
        %compute matrix(?) of tau_nk * I_n - for use later
        %I_n_matrix(:,:,row_n*col_n) = tau_nk * I_n;
    end
    
    %step 3 - update mu's
    mu_numerator = zeros(n_pixels,big_d);
    for small_k = 1:K
       %sum(A,3)
       %http://www.mathworks.com/matlabcentral/newsreader/view_thread/315640
       sum_taus = sum(memb(:,small_k));
       for z22 = 1:big_d
           mu_numerator(:,z22) = memb(:,small_k) .* img(:,z22);
       end
       phi{small_k}.mu = sum(mu_numerator)/sum_taus; %check that this is 1x3 row
       %dimensions correct,but sum_taus + mu_numerator are NaN
    end

    %step 4 - update covariance matrices - sigma_k
    for small_k = 1:K
       sum_taus = sum(memb(:,small_k));
       [sr1, sc1] = size(phi{small_k}.Sigma);
       sigma_acc = zeros(sr1,sc1);
       for pixn = 1:n_pixels
           i_min_mu = img(pixn,:) - phi{small_k}.mu;
           sigma_acc = sigma_acc + memb(pixn,small_k)* (i_min_mu') * i_min_mu;
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

    
    % Reshape the matrix format to a stack of K membership images.
    memb = reshape(memb, [rows cols K]);
    
    %returns N(...) - a scalar
    function nip1 = n_calc(i_n_vect, k)
        %i_n_vect: row vector
        n1 = 1/sqrt( ((2*pi)^big_d) * det(phi{k}.Sigma));
        iv_and_mu_k = i_n_vect - phi{k}.mu; %row vector
        n2 = exp(-0.5 * iv_and_mu_k * inv(phi{k}.Sigma) * (iv_and_mu_k') );
        nip1 = n1*n2;
    end
end