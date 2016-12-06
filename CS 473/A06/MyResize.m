% function g = MyResize(f, s)
%
% Resize an image (2D) or volume (3D).
%
% Input
%   f is an image or volume array
%   s is a scale factor that should be between 0 and 1
%
% Output
%   g is an output image or volume.
%
% Note:
%   The size if g is ceil( s*size(f) ).
%   Scaling is centred on the top-left pixel.
%   This function does not perform antialiasing (blurring) before
%   shrinking.
%
function g = MyResize(f, s)

    slices = size(f,3);
    if slices==1
        T = [eye(3) [1;1;0] ; 0 0 0 1];
        S = eye(4);
        S(1:2,1:2) = s*eye(2);
        g = MyAffine(f, T * S / T, 'linear', 'topleft');
        newsize = ceil(s * size(g));
        g = g(1:newsize(1), 1:newsize(2));
    else
        T = [eye(3) [1;1;1] ; 0 0 0 1];
        S = eye(4);
        S(1:3,1:3) = s*eye(3);
        g = MyAffine(f, T * S / T, 'linear', 'topleft');
        newsize = ceil(s * size(g));
        g = g(1:newsize(1), 1:newsize(2), 1:newsize(3));
    end
    

    