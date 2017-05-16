function sch = payoff(K,S,type)
%payoff(K,S,type)
%   K = strike, S = price of underlying, type = 'put' or 'call'

if strcmp(type, 'put')
    sch = max(K - S, 0);
elseif strcmp(type, 'call')
    sch = max(S - K, 0);
else
    disp('invalid option type');
end


end

