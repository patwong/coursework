function [OptionValue, o_] = euroOpt(sigma, r, T, S0, N, K,type)
%determines european option pricing
%inputs: sigma, rate, T, stock price at T = 0, N, K, type
%type = PUT, CALL, BOTH, e.g. euroOpt(0.3,0.015,1,100,10,10,'CALL')
%if type = BOTH, OptionValue = call option value, o_ = put option value

%initialize values and constants
delta_t = T/N;
bintree = zeros(N+1,1);
opt_vect = zeros(N+1,1);
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
if strcmp(type, 'PUT')
    opt_vect = max(k_vect - bintree,0);

elseif strcmp(type, 'CALL')
    opt_vect = max(bintree - k_vect,0);
elseif strcmp(type, 'BOTH')
    put_optv = max(k_vect - bintree,0);
    call_optv = max(bintree - k_vect,0);
end

%rolling back through the option value tree to get option value at 0
if strcmp(type, 'PUT') || strcmp(type,'CALL')
    for j = N+1:-1:2
        opt_vect = (q*opt_vect(1:j-1,1) + (1-q)*opt_vect(2:j,1))/drt;
    end
    OptionValue = opt_vect;
    o_ = 0;
elseif strcmp(type, 'BOTH')
    for j = N+1:-1:2
        call_optv = (q*call_optv(1:j-1,1) + (1-q)*call_optv(2:j,1))/drt;
        put_optv = (q*put_optv(1:j-1,1) + (1-q)*put_optv(2:j,1))/drt;
    end
    OptionValue = call_optv;
    o_ = put_optv;
end