A = [2 -1 12; 2 4 -6; 2 4 6; 2 -1 0];
[q1, q2, q3, u] = hhq3(A)

% v = [-2;2;2;2];
% v*v'
% 
% ii = eye(4);
% F = ii - 2*v*v'/(v'*v)


%%%%%%%course notes example%%%%%%%%
% A = [1 -4; 2 3; 2 2];
% % x = A(:,1)
% v = x - norm(x)*[1;0;0]
% 
% F = eye(3) - 2*v*v'/(v'*v)
% % 2       1       1 
% % -2      2 (_) 3 0
% % -2      2       0