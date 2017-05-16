S0 = 100;
r = 0.02;
sigma = 0.4;
T = 1;
N = 10;
K = 120;
type = 'put';

[delta, S, t] = deltaBinomial(S0, r, sigma, T, N, K, type);