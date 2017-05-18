n = 5;
% upd = randi(10,[n-1,1]);
% lod = randi(10,[n-1,1]);
% dd = randi(10,[n,1]);
% upd = [5;10;4;6];
% dd = [7;9;10;6;2];
% lod = [3;8;3;6];
% A = gallery('tridiag',upd,dd,lod);
% A = full(A);
% [q1,q2,q3,q4,q5,r] = hhq4(A);
% q1
% q2
% q3
% q4
% q5
% r
% big_q = q1*q2*q3*q4*q5
% 
% [big_q2, r2] = hhq4_qgen(A)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% with tridiagonal
upd = -ones(n-1,1);
lod = -ones(n-1,1);
ddd = 2*ones(n,1);
A = gallery('tridiag',upd,ddd,lod);
A = full(A);
[q1,q2,q3,q4,q5,r] = hhq4(A);
big_q = q1*q2*q3*q4*q5
r