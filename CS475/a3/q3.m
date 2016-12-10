A = [2 -1 12; 2 4 -6; 2 4 6; 2 -1 0];
% hh(A)

q1a = [ 4    3     6  ; 0   0   0  ;       0              0             12  ;  0             -5              6     ];
x = q1a(2:4,2);
v = x - norm(x)*[1;0;0];
% v'*v
% v*v'
% 
F = eye(3) - 2*v*v'/(v'*v);
Q2 = eye(4,4); Q2(2:end,2:end) = F;
F*q1a(2:end,2:end);
q2q1a = Q2*q1a;

x2 = q2q1a(3:4,3);
v2 = x2 - norm(x2)*[1;0];
F2 = eye(2) - 2*v2*v2'/(v2'*v2)
Q3 = eye(4,4); Q3(3:end,3:end) = F2