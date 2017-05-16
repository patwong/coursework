sigma = 0.4;
r = 0.2;
mu = 0.1;
T = 1.0;
K = 120;
S0 = 100;
Payoff = 'put';
N = 12;
%N = 52;
%N = 250;
dt = T/N;
M = 10000;

Smc = S0;

%phi = randn(N,1);
%[delta, S, t] = deltaBinomial(S0, r, sigma, T, N, K, 'put');
sizt = size(t);

for i = 1:sizt
    Smc = Smc*exp((mu-sigma^2/2)*dt + sigma*phi*sqrt(dt));
end

%delta_i = interpBinomial(delta,S,t,ti,simuS)