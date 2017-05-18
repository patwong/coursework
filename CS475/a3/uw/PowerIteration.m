function [v, lambda, iter] = PowerIteration(A, v0, maxiter, tol)
%PowerIteration(A, v0, maxiter, tol) => [v, lambda, iter]
%inputs: matrix A, initial vector v0, max iterations maxiter, tolerance
%outputs: eigenvector, eigenvalue, # iterations until tol reached

currtol = tol + 1;
iter = 1;
v = v0;
while (currtol > tol) && (iter <= maxiter)
   w = A*v;
   v = w/norm(w);
   lambda = v'*A*v;
   currtol = norm(A*v - lambda*v);
   iter = iter + 1;
end
iter = iter - 1;
end
%%Patrick Wong 20317267