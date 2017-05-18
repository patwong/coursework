%%EigenMethods.m
% wipeout
clearvars
%setting up the tridiagonal matrix
% n = 5;
% upd = -ones(n-1,1);
% lod = -ones(n-1,1);
% ddd = 2*ones(n,1);
% A = gallery('tridiag',upd,ddd,lod);       %A will be sparse

%example from course notes - PowerIteration works!
A = [21 7 -1; 5 7 7; 4 -4 20];
v0 = [1;1;1];
maxiter = 20;
tol = 0.0001;
[vpi, lambdapi, iterpi] = PowerIteration(A, v0, maxiter, tol);
lambdapi
% mew = 21;
% [v, lambda, iter] = ShiftedInverse(A, v0, maxiter, tol, mew)

[vrq, lambdarq, iterrq] = RayleighQuotient(A, v0, maxiter, tol);
lambdarq
% %QRIter example
% qita = [2 1 1; 1 3 1; 1 1 4];
% [final_a, v, lambda, iter] = QRIteration(qita,20,0);
% lambdav = v*diag(lambda)
% avs = qita*v
% norm(qita*v(:,1) - lambda(1)*v(:,1))
% norm(qita*v(:,2) - lambda(2)*v(:,2))
% norm(qita*v(:,3) - lambda(3)*v(:,3))
% [rv, rd] = eig(qita);