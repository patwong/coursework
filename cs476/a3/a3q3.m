%clean;
%course notes
% sigma  = 0.2;
% r = 0.1;
% T = 0.25;

%table 2
sigma  = 0.4;
r = 0.02;
T = 1;
K = 100;
S0 = 100;
dt = T/25;
N = 25;
type = 'put';
method = 'CNR';
dnorm = 0.1;
iters = 5;
S = [0:0.1*K:0.4*K,...
    0.45*K:0.05*K:0.8*K,...
    0.82*K:0.02*K:0.9*K,...
    0.91*K:0.01*K:1.1*K,...
    1.12*K:0.02*K:1.2*K,...
    1.25*K:.05*K:1.6*K,...
    1.7*K:0.1*K:2*K,...
    2.2*K, 2.4*K, 2.8*K,...
    3.6*K, 5*K, 7.5*K, 10*K];

%initializing vectors to store Black-Scholes finite difference method
%values, difference between option values, and the ratio of the finite
%difference option values
bsfd = zeros(5,1);
fd_diff = zeros(5,1);
fd_ratio = zeros(5,1);
vlen = zeros(1,6);
vlen(1) = 62;

for i = 1:iters
    [optval, steps] = ameropt2(sigma, r, T, K, dt, S, method,type,dnorm);
    s_ind = find(S == 100);      
    bsfd(i) = optval(s_ind);
    if i >= 2
       fd_diff(i-1) = abs(bsfd(i-1) - bsfd(i));
       if i >= 3
           fd_ratio(i-2) = fd_diff(i-2) / fd_diff(i-1);
       end
    end
    sprintf('iteration number %d, nodes %d, steps %d', i, length(S), steps) %debug
    %calculating the new grid - new nodes of S inserted between nodes
    if i < iters
        gridlen = length(S);
        new_s = zeros(1,2*gridlen-1);
        for c = 1:(gridlen-1)
            new_s(2*c-1) = S(c);
            new_s(2*c) = (S(c) + S(c+1))/2;
        end
        new_s(end) = S(end);
    end
    orig_s = S; %store original S for later calculations
    S = new_s;
    dt = dt/4;
    dnorm = dnorm/2;
end
s_50 = find(orig_s == 50);
s_150 = find(orig_s == 150);
s_ranged = orig_s(s_50:s_150);
v_ranged = optval(s_50:s_150);

figure
plot(s_ranged,v_ranged,'-');
title('American Put versus Underlying for CN-Rannacher');
ylabel('Put')
xlabel('Underlying')
grid on

delta = (v_ranged(2:end)-v_ranged(1:end-1))'./(s_ranged(2:end)-s_ranged(1:end-1));
figure
plot(s_ranged(1:end-1),delta,'-');
title('Delta of American Put versus Underlying for CN-Rannacher')
ylabel('Delta')
xlabel('Underlying')
grid on

gamma = 2*(delta(2:end) - delta(1:end-1))./(s_ranged(3:end) - s_ranged(1:end-2));
figure
plot(s_ranged(3:end),gamma,'-');
title('Gamma of American Put versus Underlying for CN-Rannacher')
ylabel('Gamma')
xlabel('Underlying')
grid on