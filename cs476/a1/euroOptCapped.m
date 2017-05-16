function [Call, Put] = euroOptCapped(sigma, r, T, S0, N, K, H)
%determines european option pricing with cap H
%inputs: sigma, rate, T, stock price at T = 0, N, strike price, cap
%e.g. euroOptCapped(0.3,0.015,1,100,N,60,10)

%initialize values and constants
delta_t = T/N;
bintree = zeros(N+1,1);
%put_optv = zeros(N+1,1);
%call_optv = zeros(N+1,1);
u = exp(sigma*sqrt(delta_t));
d = 1/u;
drt = exp(r*delta_t);
q = (drt - d)/(u - d);

%creating the binomial lattice at time N; this is a N size vector
for x = 1:N+1
    bintree(x,1) = S0*exp((-2*x+2+N)*sigma*sqrt(delta_t));
end

%creating an N-sized array to calculate put or call option value
k_vect = K*ones(N+1,1);
put_optv = min(max(k_vect - bintree,0), H);
call_optv = min(max(bintree - k_vect,0), H);


%rolling back through the option value tree
for j = N+1:-1:2    
    call_optv = (q*call_optv(1:j-1,1) + (1-q)*call_optv(2:j,1))/drt;
    put_optv = (q*put_optv(1:j-1,1) + (1-q)*put_optv(2:j,1))/drt;
end
Call = call_optv;
Put = put_optv;