function put = EuroDownOut(K, Sd, S, T, sigma, r, t)
%K:strike price, Sd = barrier price, S = stock price, T = expiry, sigma, rate, t = time

%calculation of the d values
d1 = (log(S/K) + (r + 0.5*(sigma^2))*(T - t))/(sigma*sqrt(T-t));
d2 = (log(S/K) + (r - 0.5*(sigma^2))*(T - t))/(sigma*sqrt(T-t));
d3 = (log(S/Sd) + (r + 0.5*(sigma^2))*(T - t))/(sigma*sqrt(T-t));
d4 = (log(S/Sd) + (r - 0.5*(sigma^2))*(T - t))/(sigma*sqrt(T-t));
d5 = (log(S/Sd) - (r - 0.5*(sigma^2))*(T - t))/(sigma*sqrt(T-t));
d6 = (log(S/Sd) - (r + 0.5*(sigma^2))*(T - t))/(sigma*sqrt(T-t));
d7 = (log(S*K/Sd^2) - (r - 0.5*(sigma^2))*(T - t))/(sigma*sqrt(T-t));
d8 = (log(S*K/Sd^2) - (r + 0.5*(sigma^2))*(T - t))/(sigma*sqrt(T-t));

norm1 = normcdf(d4)-normcdf(d2)-((Sd/S)^(-1+2*r/(sigma^2)))*(normcdf(d7)-normcdf(d5));
norm2 = normcdf(d3)-normcdf(d1)-(Sd/S)^(1+2*r/(sigma^2))*(normcdf(d8)-normcdf(d6));
put = K*exp(-r*(T-t))*norm1 - S*norm2;
