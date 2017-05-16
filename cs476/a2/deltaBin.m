function [w] = fex1(x)
w = zeros(size(x));
for j = 1:10
    w = w + j/10*sin(2*pi*x/j);
end;
w = w - 0.75*ones(size(x));

end