%table 2
%clean;
sigma  = 0.4;
r = 0.02;
T = 1;
K = 100;
S0 = 100;
dt = T/25;
N = 25;
type = 'put';
method = 'CNR';

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
[call, put] = blsprice(S,K,r,T,sigma);
for i = 1:5
    optval = implicitfd(sigma, r, T, K, S0, dt, S, method,type);
    s_ind = find(S == 100);
        
    bsfd(i) = optval(s_ind);
    if i >= 2
       fd_diff(i-1) = abs(bsfd(i-1) - bsfd(i));
       if i >= 3
           fd_ratio(i-2) = fd_diff(i-2) / fd_diff(i-1);
       end
    end

    %calculating the new grid - new nodes of S inserted between nodes
    gridlen = length(S);
    new_s = zeros(1,2*gridlen-1);
    for c = 1:(gridlen-1)
        new_s(2*c-1) = S(c);
        new_s(2*c) = (S(c) + S(c+1))/2;
    end
    new_s(end) = S(end);
    %store the original S for later calculations for the grid
    if i == 5
        orig_s = S;
    end
    S = new_s;
    dt = dt/2;
end
s_50 = find(orig_s == 50);
s_150 = find(orig_s == 150);
s_ranged = orig_s(s_50:s_150);
v_ranged = optval(s_50:s_150);

figure
plot(s_ranged,v_ranged,'-');
%title('implicit put')
%title('crank-nicolson put')
%  title('crank-nicolson rannacher put')
%title('Put versus Underlying for fully Implicit Method');
%title('Put versus Underlying for Crank-Nicolson Method');
title('Put versus Underlying for CN-Rannacher Method');
ylabel('Put')
xlabel('Underlying')
%grid on

% delta_splus = (s_ranged(3:end) - s_ranged(2:end-1));
% delta_sminu = (s_ranged(2:end-1) - s_ranged(1:end-2));
% delta = (v_ranged(3:end)-v_ranged(1:end-2))'/(delta_splus + delta_sminu);
delta = (v_ranged(2:end)-v_ranged(1:end-1))'./(s_ranged(2:end)-s_ranged(1:end-1));
figure
plot(s_ranged(1:end-1),delta,'-');
%title('implicit delta put')
% title('crank-nicolson delta put')
%  title('crank-nicolson rannacher delta put')
%title('Delta of Put versus Underlying for fully Implicit Method')
%title('Delta of Put versus Underlying for Crank-Nicolson Method')
%title('Delta of Put versus Underlying for CN-Rannacher Method')
ylabel('Delta')
xlabel('Underlying')
%grid on

%gamma = 2*(delta(2:end) - delta(1:end-1))./(s_ranged(3:end) - s_ranged(2:end-1));
gamma = 2*(delta(2:end) - delta(1:end-1))./(s_ranged(3:end) - s_ranged(1:end-2));
figure
plot(s_ranged(3:end),gamma,'-');
%title('implicit gamma put')
% title('crank-nicolson gamma put')
 title('crank-nicolson rannacher gamma put')
%title('Gamma of Put versus Underlying for fully Implicit Method')
%title('Gamma of Put versus Underlying for Crank-Nicolson Method')
%title('Gamma of Put versus Underlying for CN-Rannacher Method')
ylabel('Gamma')
xlabel('Underlying')
%grid on