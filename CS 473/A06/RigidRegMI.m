% function best_p = RigidRegMI(f, g, p0)
%
% Registers image f to g by maximizing their Mutual Information using
% gradient ascent optimization.
%
% Input
%   f and g are images (2D) that are the same size
%   p0 is the initial guess for the motion parameters
%      (default [0 0 0 0 0 0])
%
% Output
%   p is the set of motion parameter estimates, in the form
%
%     p = [theta_r theta_c theta_s  r  c  s]
%       = [   0       0    theta_s  r  c  0]
%
%  where the transformation is with respect to Matlab index coordinates
%  centred on the image centre (see the help for MyAffine).
%  However, theta_r, theta_c and s are all zero in the output since
%  this function only performs 2D rigid-body registration.
%
% [7] marks total
function best_p = RigidRegMI(f, g, p0)

    if nargin<3
        % No initial guess? Use identity mapping.
        p0 = [0 0 0 0 0 0];
    end

    % Initial motion estimate
    best_p = p0;
    
    counter = 0;
    
    % ===== YOUR CODE =====
    %zeroing out the unnecessary parameters
    best_p(1) = 0;best_p(2) = 0;best_p(6) = 0;
    delta = 1.0;
    beta = 5;
    for cc = 1:100
        %s-axis derivative
        s_plus = p2m([0 0 (best_p(3)+1) best_p(4) best_p(5) 0]); 
        s_min = p2m([0 0 (best_p(3)-1) best_p(4) best_p(5) 0]); 
        F_plus = MyAffine(f,s_plus,'linear','centred');
        F_min = MyAffine(f,s_min,'linear','centred');
        dmdt = (mi(F_plus,g,64) - mi(F_min,g,64))/(2*delta);
        
        % r-derivative
        r_plus = p2m([0 0 best_p(3) (best_p(4)+1) best_p(5) 0]);
        r_min = p2m([0 0 best_p(3) (best_p(4)-1) best_p(5) 0]);
        R_plus = MyAffine(f,r_plus,'linear','centred');
        R_min = MyAffine(f,r_min,'linear','centred');
        dmdr = (mi(R_plus,g,64) - mi(R_min,g,64))/(2*delta);
        
        % c-derivative
        c_plus = p2m([0 0 best_p(3) best_p(4) (best_p(5)+1) 0]);
        c_min = p2m([0 0 best_p(3) best_p(4) (best_p(5)-1) 0]);
        C_plus = MyAffine(f,c_plus,'linear','centred');
        C_min = MyAffine(f,c_min,'linear','centred');
        dmdc = (mi(C_plus,g,64) - mi(C_min,g,64))/(2*delta);
        
        M_grad = [dmdt dmdr dmdc];
        if norm(M_grad) < 0.01
            break;
        end
        
        best_p(3:5) = best_p(3:5) + beta * M_grad;
        % --- Show progress ---
        % This is some sample code to help you see how things are progressing.
        disp([num2str(counter) ':  ' num2str(best_p(3:5))])
        
        if mod(counter,5)==0
            [rows cols] = size(g);
            moved_f = MyAffine(f, p2m(best_p), 'linear', 'centred');
            imshow(reshape([moved_f(:) ; g(:) ; zeros(rows*cols,1)]/255, [rows cols 3]));
            drawnow;
        end
        % ---
    end
    

end