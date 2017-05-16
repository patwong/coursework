function put = DAO_put(sigma, N, T, S0, Sd, K, r, M)
%sigma, N, T = expiry, S0 = stock at T = 0, Sd = barrier price, K = strike price,
%r = rate, M = simulations

delta_t = T/N;
Sn = S0;
y = 0;
sn_vect = zeros(N,1);
for i = 1:N-1
    phi_rand = randn;
    sn_vect(i+1,1) = sn_vect(i,1)*exp((r-0.5*sigma^2)*delta_t + sigma*phi_rand*sqrt(delta_t));
    %checking if barrier is reached
    if Sn <= Sd
        y = 1;
        %zzz = 'barrier reached'
    else
        %zzz = 'barrier not reached'
    end
end
%Sn

if y == 1
%     y = 1
    p_off = 0;
else
    psum = 0;
    for i = 1:M
        p_off = max(K - Sn, 0)^i;
        psum = psum + p_off;
    end
    p_off = (1/M)*exp(-r*T)*psum;
end

put = p_off;
%tput = exp(-r*T)