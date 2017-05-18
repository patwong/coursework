function U = hh(A)
%U = hh(A)
%input full rank square matrix A, output upper triangle matrix R
    [m, n] = size(A);
    for k = 1:n
        x = A(k:m, k);
        e1 = zeros(length(x),1);
        e1(1) = 1;
        v = x + sign(x(1))*norm(x)*e1;
        v = v/norm(v);
%         for j = k:n
%             A(k:m, j) = A(k:m, j) - 2*v*(v'*A(k:m, j));
%         end
        A(k:m, k:n) = A(k:m, k:n) - 2*v*(v'*A(k:m, k:n));
    end
    U = A;
end