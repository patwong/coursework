function iv = HestonNandi(r,v,vbar,eta,lambda,S0,K,T)
%Heston-Nandi Method to calculate European call options

M = 100000;  %monte carlo simulation number
dt = 1/1000;
N = T/dt;
N = floor(N); %useful when T is not integer
rho = -1;     %rho is -1 for Heston-Nandi

%phi generation
x1 = randn(M,N);
x2 = randn(M,N);
phi1 = x1;
phi2 = rho*x1 + sqrt(1 - rho^2)*x2;

x = log(S0)*ones(M,1);
v = v*ones(M,1);

%using monte carlo to determine the initial value of the call option
%vectorized phi into matrices, x and v as vectors to speed up monte carlo
for bb = 1:N
    v = abs(v);
    x = x + r*dt - (v/2)*dt + sqrt(v*dt).*phi1(:,bb);
    v = (sqrt(v) + (eta/2)*sqrt(dt)*phi2(:,bb)).^2 - lambda*(v - vbar)*dt - (eta^2/4)*dt;
end

callval = max(exp(x) - exp(K), 0);
iv = mean(callval)*exp(-r*T);

end