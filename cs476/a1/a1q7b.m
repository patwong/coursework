%a1q7b

%put = DAO_put(sigma, dt, T, S0, Sd, K, r, M)
Sigma = 0.3;
dt = 5;
T = 250;
S0 = 100;
Sd = 80;
K = 110;
r = 0.015;
M = 10000;

%changing M values and calculating the put with different number of
%simulations
put = DAO_put(Sigma, dt, T, S0, Sd, K, r, M);
put = DAO_put(Sigma, dt, T, S0, Sd, K, r, 8000);
put = DAO_put(Sigma, dt, T, S0, Sd, K, r, 4000);
put = DAO_put(Sigma, dt, T, S0, Sd, K, r, 2000);
put = DAO_put(Sigma, dt, T, S0, Sd, K, r, 1000);