% CS 473 A2 - Patrick Wong 20317267

%%%% [4] marks total
function G = MyGaussianBlur(F, sigma)
% Function G = MyGaussianBlur(F, sigma)
%
%  Blur an image (2D or 3D) using a Gaussian filter.
%
%  Input:
%    F is an image array (2D or 3D)
%    sigma is the standard deviation of the Gaussian blurring kernel
%
%  Output:
%    G is an image array the same size as F containing the
%      blurred image

% Get dimensions of array
dims = size(F);
numDims = length(dims);
if numDims == 2
    [m,n] = size(F);
    gaussmat = Gaussian(sigma,[m n]);
    G = fftshift(fftshift(ifft2( fft2(F) .* fft2(gaussmat) )));
else
    % Input array is not 2D (then it's 3D)
    [m,n,z] = size(F); 
    gaussmat = Gaussian(sigma,[m n z]);
    G = zeros(m,n,z);
    for c = 1:z
        G(:,:,c) = fftshift(ifft2( fft2(F(:,:,c) .* fft2(gaussmat(:,:,c)))));
    end
end


end
    
    
    