%%A4

% q1a = [4 0; 0 -1];
% q1a'*q1a;

% q1b = [3 0; 0 2];
% 
% q1c = [0 3; 0 0; 0 0];
% q1c'*q1c
% [u s v] = svd(q1b)




q1a = [4 0;0 -1];
q1b = [3 0;0 2];
q1c = [0 3; 0 0; 0 0];
q1d = [1 1; 0 0];
q1e = [2 2; 2 2];
% [ua sa va] = svd(q1a);
% [ub sb vb] = svd(q1b);
% [uc sc vc] = svd(q1c)
% [ud sd vd] = svd(q1d)
[ue se ve] = svd(q1e)