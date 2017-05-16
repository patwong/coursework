clear all;
close all;
sigma=0.4;r=0.02;T=1;K=100;


S=[0:0.1*K:0.4*K,0.45*K:0.05*K:0.8*K,0.82*K:0.02*K:0.9*K,0.91*K:0.01*K:1.1*K,1.12*K:0.02*K:1.2*K,1.25*K:.05*K:1.6*K,1.7*K:0.1*K:2*K,2.2*K,2.4*K,2.8*K,3.6*K,5*K,7.5*K,10*K];

% time_step=1;
% option_type=1;
% num_step=25;

%peasant test
dt = 1/25;
method = 'CN';
type = 'put';
nat = 0;
S0 = 100;

[call,put]=blsprice(S,K,r,T,sigma);

V = implicitfd(sigma, r, T, K, S0, dt, S, method, type,nat);
