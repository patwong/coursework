%q3.m

a3 = randi(40,4,4);
while rank(a3) ~= 4
    a3 = randi(40,4,4);
end

[u s v] = svd(a3);

diag(s.*s)
eig(a3)