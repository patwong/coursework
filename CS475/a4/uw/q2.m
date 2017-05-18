%q2.m

a1 = randi(20,4,3);
[u, s, v] = svd(a1);
[q r] = qr(a1);
b = randi(30,4,1);
xstandard = a1\b;
% xsvd = v*

%need to show that r = vd and that vd is upper triangular