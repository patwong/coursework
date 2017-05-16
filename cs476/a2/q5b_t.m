r = 0.02;
v = 0.0174;
vbar = 0.0354;
eta = 0.3877;
rho = -0.7165;
lambda = 1.3253;
S0 = 100;
K = 100;
T = linspace(0.25,1,20);
dt = 1/100;

z = zeros(20,1);

figure
for i = 1:20
    y = milmethod(r,v,vbar,eta,rho,lambda,S0,K,T(i),dt);
    z(i,1) = blsimpv(S0, K, r, T(i), y);
end
plot(T,z)
ylabel('implied volatility')
xlabel('time')
title('volatility versus time')