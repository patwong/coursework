function [q, L] = hhl(A)
%U = hhl(A)
%input full rank square matrix A, output lower triangle matrix L
    [m, n] = size(A);
    q = eye(n);
    for k = n:-1:1
        x = A(1:k, k);
        e1 = zeros(length(x),1);
        e1(end) = 1;
        v = x + sign(x(end))*norm(x)*e1;
        v = v/norm(v);
        %Q generation
        temp1 = eye(k);
        temp1 = temp1 - 2*v*v'/(v'*v);
        temp_f = eye(n);
        temp_f(1:k,1:k) = temp1;
        q = q*temp_f;
%         for j = k:-1:1
%             A(1:k, j) = A(1:k, j) - 2*v*(v'*A(1:k, j));
%         end
        A(1:k, 1:k) = A(1:k, 1:k) - 2*v*(v'*A(1:k, 1:k))
    end
    L = A;
end

% j  = 2 -> 1
% A(1:2,2)
% A(1:2,1)
%j = 1
%A(1:1,1)

% k = 1;
% k:m,k:n -> 1:m,1:n

% k = 2
% 2:m, 2:n