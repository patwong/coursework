%a3q2a
lambda = 10;
vbar = 0.04;
eta = 1;
v0 = 0.04;
r = 0;
T = 1;
S0 = 100;
type = 'call';
K = linspace(-0.5+log(S0),0.2+log(S0),10);
z = zeros(10,1);
vols = zeros(10,1);

for i = 1:10
    z(i,1) = HestonNandi(r,v0,vbar,eta,lambda,S0,K(i),T);
    vols(i,1) = blsimpv(S0, exp(K(i)), r, T,z(i,1));
end
figure
plot(K,z,'-')
ylabel('Heston-Nandi call option value')
xlabel('log K')
title('call option value versus log K')

expK = K;
for i = 1:10
    expK(i) = exp(K(i));
end
figure
plot(expK,vols,'-')
ylabel('volatility')
xlabel('K')
title('volatility using MC versus K')