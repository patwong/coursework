A = [4 9 6; 7 8 7; 7 3 1];

%generate random full rank 3x3 matrix
% A = zeros(3,3);
% while(rank(A) ~= 3) 
%     A = fix(10*rand(3,3));
% end
% [u, r] = householder(A);
%  r

% z = hh(A);
[q, l] = hhl(A);

%u = [0.8290 0 0; 0.3954 -0.7768 0; 0.3954 -0.6298 -1.0000];
% real_r = [-10.6771 -10.5834 -7.4927; 0.0000 6.4801 5.2008; 0.0000 0 1.6766]