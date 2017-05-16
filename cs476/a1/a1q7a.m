%a1q7a
%calculating put option value using down-and-out European option
K = 110;
Sd = 80;
T = 1;
sigma = 0.3;
r = 0.015;
optvect = zeros(20,1);
s0 = zeros(20,1);
j = 1;
for i = 80:2:120
    s0(j,1) = i;
    optvect(j,1) = EuroDownOut(K,Sd,i,T,sigma,r,0);
    j = j + 1;
end

figure
plot(s0,optvect,'b--o')
xlabel('stock price')
ylabel('put option value')
title('stock price versus put option value')
