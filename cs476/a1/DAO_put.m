function put = DAO_put(Sigma, dt, T, S0, Sd, K, r, M)
%European down-and-out put value code
%sigma, N, T = expiry, S0 = stock at T = 0, Sd = barrier price, K = strike price,
%r = rate, M = simulations

N = T/dt;
Sn = S0;
payoff_t = 0;
%p_off = zeros(M+1,1);

%the M simulations of option paths
for j = 1:M+1
    %calculating the stock value at N in the m-th simulation
    for i = 1:N
        phi_rand = randn;
        Sn = Sn*exp((r-0.5*Sigma^2)*dt + Sigma*phi_rand*sqrt(dt));
    end
    if(Sn > Sd)
        payoff_t = payoff_t + max(K - Sn, 0);
    end
end

put = exp(-r*T)*payoff_t/M;