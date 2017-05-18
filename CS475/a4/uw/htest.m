%htest.m
% ayy = [0 3; -0.5 0]';
% H = [zeros(2,2) ayy'; ayy zeros(2,2)];
% [ayyvec ayyval] = eig(H)
% 
% ia = [3 5 10 7; 34 12 0 6; 18 0 19 20; 1 0 2 5];
% ib = [4 9 4 3; 5  7 19  6;4 19 20  9;5  9  9 12];
% iab = [ia ia'; ib' ib]

a = randi(50,5,3);
[u, s, v] = svd(a);
H = [zeros(3,3) a'; a zeros(5,5)]
[evect, eval] = eig(H);
Q = (1/sqrt(2))*evect;
% HQ - Q*eval = 0 --> what we wnat
% make sense of evect
%evect == q
isq2 = 1/sqrt(2);
% newq = isq2*[v v zeros(3,2); u(:,1:3) -u(:,1:3) sqrt(2)*u(:,4:end)]
% newq isn't actually Q

%checking if reversing the eigenvalues changes anything - doesn't
%bweval = diag(fliplr(diag(eval)))
