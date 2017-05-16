%function [Call, Put] = euroOptCapped(sigma, r, T, S0, N, K, H)
%inputs: sigma, rate, T, stock price at T = 0, N, strike price, cap
%e.g. euroOptCapped(0.3,0.015,1,100,10,60,10)

%inputs: sigma, rate, T, stock price at T = 0, N, K, type
%type = PUT, CALL, BOTH, e.g. euroOpt(0.3,0.015,1,100,10,10,'CALL')
%if type = BOTH, OptionValue = call option value, o_ = put option value

%[Call, Put] = blsprice(Price, Strike, Rate, Time, Volatility, Yield)
%[Call, Put] = blsprice(100,60,0.015,1,0.3);

capvect = zeros(5,1);
normvect = zeros(5,1);
strikev = zeros(5,1);
%z = zeros(5,2);
%axis([0 12 50 105])
for i = 1:5;
    strikev(i,1) = 50+i*10;
    [ctree, ptree] = euroOptCapped(0.3,0.015,1,100,400,50+i*10,10);
    [c1,p1] = euroOpt(0.3,0.015,1,100,400,50+i*10,'BOTH');
    capvect(i,1) = ptree;
    normvect(i,1) = p1;
end

figure
plot(strikev,capvect,'b--o',strikev,normvect,'-x');
xlabel('strike price')
ylabel('put value')
title('strike price versus put value')
% for i = 1:5;
%     [ctree, ptree] = euroOptCapped(0.3,0.015,1,100,400,50+i*10,10);
%     [c1,p1] = euroOpt(0.3,0.015,1,100,400,50+i*10,'BOTH');
%     z(i,1) = ptree;
%     z(i,2) = p1;
%     plot(z(i,1),50+i*10,'b--o',z(i,2),50+i*10,'c*')
%     hold on
% end
