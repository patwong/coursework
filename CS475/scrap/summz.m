function v = summz(x, A, i)
%matrix multiplication between A and x, excluding the i-th column

v = A(i,:)*x - A(i,i)*x(i);

end