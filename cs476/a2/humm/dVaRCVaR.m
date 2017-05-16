function [var,cvar]=dVaRCVaR(L,b)
    L = sort(L); %Sort L
    M=size(L,1); % Find out M
    i=1;
    while(i >= b*M)% Go until we reach b accuracy.
        i=i+1;
    end
    var = L(i);% Calculate VaR
    cvar=1/(1-b) * ( (1/M-b)*L(i)+ 1/M*sum(L(i:M)) ); %Calculate CVaR
end