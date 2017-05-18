%%EigenMethods.m
%%Patrick Wong 20317267
n = 100;
maxiter = 10000;
tol = 0.0001;

%setting up the tridiagonal matrix
upd = -ones(n-1,1);
lod = -ones(n-1,1);
ddd = 2*ones(n,1);
A = gallery('tridiag',upd,ddd,lod);     %A will be sparse
A = full(A);
    
%vectors for PowerIteration, RayleighQuotient
v0_pi = zeros(n,1); v0_pi(1) = 1;       %for PowerIteration
v0_rq = ones(n,1);                      %for RayleighQuotient

[v_pi, lambda_pi, iter_pi] = PowerIteration(A, v0_pi, maxiter, tol);
[v_rq, lambda_rq, iter_rq] = RayleighQuotient(A, v0_rq, maxiter, tol);
[v_qr, lambda_qr, iter_qr] = QRIteration(A, maxiter, tol);
[v_ml, lambda_ml] = eig(A);             %comparing MATLAB to QRIteration

%plots
figure
plot(v_pi)
str1 = sprintf('Power Iteration - Eigenvalue: %f, Iterations: %d', lambda_pi, iter_pi);
title(str1)

figure
plot(v_rq)
str2 = sprintf('Rayleigh Quotient - Eigenvalue: %f, Iterations: %d', lambda_rq, iter_rq);
title(str2)

figure
plot(diag(lambda_qr))
title('Eigenvalues for QR Iteration')

figure
plot(v_qr(:,20))
str3 = sprintf('QR Iteration - Eigenvalue: %f, Iterations: %d', lambda_qr(20,20), iter_qr);
title(str3)

figure
plot(v_qr(:,40))
str4 = sprintf('QR Iteration - Eigenvalue: %f, Iterations: %d', lambda_qr(40,40), iter_qr);
title(str4)

figure
plot(v_qr(:,60))
str5 = sprintf('QR Iteration - Eigenvalue: %f, Iterations: %d', lambda_qr(60,60), iter_qr);
title(str5)

figure
plot(v_qr(:,80))
str6 = sprintf('QR Iteration - Eigenvalue: %f, Iterations: %d', lambda_qr(80,80), iter_qr);
title(str6)