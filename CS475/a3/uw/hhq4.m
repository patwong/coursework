function [q1, q2, q3,q4,q5, U] = hhq4(A)
%U = hh(A)
%input full rank square matrix A, output upper triangle matrix R
    [m, n] = size(A);
    for k = 1:n
        x = A(k:m, k);
        e1 = zeros(length(x),1);
        e1(1) = 1;
        v = x + sign(x(1))*norm(x)*e1;
        v = v/norm(v);
        temp1 = eye(m-k+1);
        temp1 = temp1 - 2*v*v'/(v'*v);
        temp_f = eye(n); temp_f(k:end,k:end) = temp1;
        if k == 1
            q1 = temp_f;
        elseif k == 2
            q2 = temp_f;
        elseif k == 3
            q3 = temp_f;
        elseif k == 4
            q4 = temp_f;
        elseif k == 5
            q5 = temp_f;
        end
        A(k:m, k:n) = A(k:m, k:n) - 2*v*(v'*A(k:m, k:n));
    end
    U = A;
end