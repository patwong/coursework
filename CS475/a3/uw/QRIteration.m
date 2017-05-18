function [v, lambda, iter] = QRIteration(A, maxiter, tol)
%QRIteration(A, maxiter, tol) => [v, lambda, iter]
%inputs: matrix A, max iterations maxiter, tolerance tol
%outputs: eigenvectors, eigenvalues, # iterations until tol reached

iter = 1;
a_orig = A;
v = eye(size(A));
currtol = tol + 1;  %initialize curr tol to be some dummy variable
while (currtol > tol) && (iter <= maxiter)
   [Q, R] = qr(A);
   v = v*Q;
   A = R*Q;
   lambda = diag(diag(A)); 
   normedmat = a_orig*v - v*lambda;
   currtol = max(sqrt(sum(normedmat.^2, 1)));
   iter = iter + 1;
end
iter = iter - 1;

end
%%Patrick Wong 20317267