function [delta, S, t] = deltaBinomial(S0, r, sigma, T, N, K, type)
%deltaBinomial(initial stock price, rate, sigma, Time, N, Strike, type)
%type = 'call' or 'put'
%unsure of what fpayoff was so i included K, indicating strike price
%and type, specifying if it's a call or put

dt = T/N;
u = exp(sigma*sqrt(dt));
d = 1/u;
drt = exp(r*dt);
q = (drt - d)/(u - d);
blattice = zeros(N+1,N+1);
option_value = zeros(N+1,N+1);
delta = zeros(N,N);


%creating the binomial lattice of stock prices
for n = 0:N
    for j = 0:n
        blattice(j+1,n+1) = S0*exp((-2*j + n)*sigma*sqrt(dt));
    end
end

%calculating the value of the option at the N-th level of the binomial
%lattice
kvect = K*ones(N+1,1);
if strcmp(type, 'put')
    option_value(:,N+1) = max(kvect - blattice(:,N+1),0);
elseif strcmp(type,'call')
    option_value(:,N+1) = max(blattice(:,N+1) - kvect,0);
end

%determining the option values before the N-th level
%determining the hedging position for all nodes on all levels before N
ud = u - d;
i = 1;
for n = N:-1:1    
    option_value(:,n) = [(q*option_value(1:n,n+1) + (1-q)*option_value(2:n+1,n+1))/drt; zeros(i,1)];
    delta(:,n) = [((option_value(1:n,n+1) - option_value(2:n+1,n+1))) ./ (ud*blattice(1:n,n));zeros(i-1,1)];
    i = i + 1;
end

%creating the t vector for output
t = zeros(N,1);
for temp = 1:N
    t(temp,1) = dt;
    dt = dt + dt;
end

%outputting the binomial lattice
S = blattice;

end
