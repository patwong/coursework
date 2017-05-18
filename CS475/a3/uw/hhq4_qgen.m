function [big_q, U] = hhq4_qgen(A)
%U = hh(A)
%input full rank square matrix A, output upper triangle matrix R
    [m, n] = size(A);
    big_q = eye(rank(A));
    for k = 1:n
        x = A(k:m, k);
        e1 = zeros(length(x),1);
        e1(1) = 1;
        v = x + sign(x(1))*norm(x)*e1;
        v = v/norm(v);
        temp1 = eye(m-k+1);
        temp1 = temp1 - 2*v*v'/(v'*v);
        temp_f = eye(n); temp_f(k:end,k:end) = temp1;
        big_q = big_q*temp_f;
        A(k:m, k:n) = A(k:m, k:n) - 2*v*(v'*A(k:m, k:n));
    end
    U = A;
end