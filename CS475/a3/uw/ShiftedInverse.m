function [v, lambda, iter] = ShiftedInverse(A, v0, maxiter, tol, mew)
%PowerIteration(A, v0, maxiter, tol) => [v, lambda, iter]
%inputs: matrix A, initial vector v0, max iterations maxiter, tolerance
%outputs: eigenvector, eigenvalue, # iterations until tol reached

currtol = tol + 1;
iter = 1;
v = v0;
I = eye(length(A));
while (currtol > tol) && (iter <= maxiter)
   w = (A-mew*I)\v;     %MATLAB: inv(A)*v slower than A\v
   v = w/norm(w);
   lambda = v'*A*v;
   currtol = norm(A*v - lambda*v);
   iter = iter + 1;
end
iter = iter - 1;
end