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
    tol_limit = 0.001;
    g_vector = g(:);
    f_rots = MyDerivative(g,3); %rotation on s-axis
    f_r1 = MyDerivative(g,4);   %row shift
    f_c1 = MyDerivative(g,5);   %col shift
    
    %gradient has shift first then rotation
    %p2m input has rotation first then shift
    if ndims == 3
        f_rotr = MyDerivative(g,1); %rotation on r-axis
        f_rotc = MyDerivative(g,2); %rotation on c-axis
        f_s1 = MyDerivative(g,6);   %slice shift
        grad_g = zeros(dims(1)*dims(2)*dims(3),6);        
        grad_g(:,1) = f_r1(:);
        grad_g(:,2) = f_c1(:);
        grad_g(:,3) = f_s1(:);
        grad_g(:,4) = f_rotr(:);
        grad_g(:,5) = f_rotc(:);
        grad_g(:,6) = f_rots(:);
    else %ndims == 2
        grad_g = zeros(dims(1)*dims(2),3);
        grad_g(:,1) = f_r1(:);
        grad_g(:,2) = f_c1(:);
        grad_g(:,3) = f_rots(:);
    end
    
    %to save computation in for loop
    invATA_AT = inv(grad_g'*grad_g)*grad_g';
    for iter = 1:20
        if ndims == 2
            %re-index because rotations and shifts are swapped for best_m
            p_old = [best_m(4) best_m(5) best_m(3)];
            tf = MyAffine(f,p2m(best_m),'linear','centred');
            temp = p_old - (invATA_AT*(tf(:) - g_vector))';
            %re-index
            best_m(4) = temp(1);best_m(5) = temp(2);best_m(3) = temp(3);
        else
            %re-index because rotations and shifts are swapped for best_m
            p_old = circshift(best_m',3)';
            tf = MyAffine(f,p2m(best_m),'linear','centred');
            temp = p_old - (invATA_AT*(tf(:) - g_vector))';
            %re-index
            best_m = circshift(temp',3)';
        end
        %output format like test_ls_reg.m
        disp(num2str(best_m));
        if max(abs(temp - p_old)) < tol_limit
            break;
        end
    end
end