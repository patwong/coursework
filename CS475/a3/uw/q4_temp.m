% n = 10;
% upd = randi(10,[n-1,1]);
% lod = randi(10,[n-1,1]);
% dd = randi(10,[n,1]);
% 
% A = gallery('tridiag',upd,dd,lod);
% A = full(A);
% rank(A)

n = 12;
upd = randi(100,[n-1,1]);
lod = randi(100,[n-1,1]);
dd = randi(100,[n,1]);

A = gallery('tridiag',upd,dd,lod);
A = full(A);
rank(A)
if rank(A) == n
    hh(A)
    A
end