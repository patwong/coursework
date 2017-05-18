A = [3 2; 1 3];
b = [3;1];
x = zeros(2,1);
for k = 1:5
    temp = x;
    for i = 1:2
        x;
        summz(x,A,i);
        temp(i) = (1/A(i,i))*(b(i) - summz(x,A,i));
    end
    x(2);
    x = temp
end

%initially implemented Gauss-Seidel rather than Jacobi; using just computed
%solution in computing new solution