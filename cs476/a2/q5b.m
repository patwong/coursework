%q5b part 1
r = 0.02;
v = 0.0174;
vbar = 0.0354;
eta = 0.3877;
rho = -0.7165;
lambda = 1.3253;
S0 = 100;
K = linspace(0.7*S0,1.2*S0,30);
T = 1;
dt = 1/100;

z = zeros(30,1);

figure
for i = 1:30
    y = milmethod(r,v,vbar,eta,rho,lambda,S0,K(i),T,dt);
    z(i,1) = blsimpv(S0, K(i), r, T, y);
end
plot(K,z)
ylabel('implied volatility')
xlabel('strike price')
title('volatility versus strike')