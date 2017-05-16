function [var, cvar] = dVaRCVaR(L, Beta)
%L: discrete loss distribution with M independent samples
%Beta: confidence level

ll = sort(L);
i = 1;
M = 10000;
while(i/M <= Beta)
    i = i + 1;
end

var = L(i);
sumli = ll(i+1,:);
cvar = 1/(1-Beta) * ((i/M - Beta)*L(i) + (1/M)*sumli;

end