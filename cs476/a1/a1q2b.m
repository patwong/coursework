%a1q2b
%plotting the capped European Call Option values against the strike prices

capvect = zeros(5,1);
normvect = zeros(5,1);
strikev = zeros(5,1);

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
