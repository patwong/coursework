%a3q2b.m
lambda = 10;
vbar = 0.04;
eta = 1;
v0 = 0.04;
r = 0;
T = 1;
S0 = 100;
lambda_hat = lambda + eta/2;
vbar_hat = vbar*lambda/lambda_hat;
method = 'implicit';
type = 'call';
delt = T/25;
bsfd = zeros(10,1);
K2 = linspace(-0.5+log(S0),0.2+log(S0),10);
K = zeros(10,1);

for aa = 1:10
    K(aa) = exp(K2(aa));
    S = [0:0.1*K(aa):0.4*K(aa),...
        0.45*K(aa):0.05*K(aa):0.8*K(aa),...
        0.82*K(aa):0.02*K(aa):0.9*K(aa),...
        0.91*K(aa):0.01*K(aa):1.1*K(aa),...
        1.12*K(aa):0.02*K(aa):1.2*K(aa),...
        1.25*K(aa):.05*K(aa):1.6*K(aa),...
        1.7*K(aa):0.1*K(aa):2*K(aa),...
         2.2*K(aa), 2.4*K(aa), 2.8*K(aa),...
        3.6*K(aa), 5*K(aa), 7.5*K(aa), 10*K(aa)];
    delt = 0.04;
    %four refinements from initial grid in problem 1
    for i = 1:4
        S = S(2:end);
        N = T/delt;
        lenS = length(S);
        
        %computing a vector of volatilities
        e_lhatt = exp(-lambda_hat);
        vol = max((v0-vbar_hat)*e_lhatt + vbar_hat - eta*log(S/S0)*((1-e_lhatt)/(lambda_hat)),0);
      
        optval = ifd_lvf(vol, r, T, K(aa), delt, S, method,type);
        %for sake of comparing option values, we compare the option values
        %where its underyling is >= 100
        s_ind = find(S >= 100);
        bsfd(aa) = optval(s_ind(1));
        
        %double the number of grid intervals
        gridlen = length(S);
        new_s = zeros(1,2*gridlen-1);
        for c = 1:(gridlen-1)
            new_s(2*c-1) = S(c);
            new_s(2*c) = (S(c) + S(c+1))/2;
        end
        new_s(end) = S(end);
        S = new_s;
        delt = delt/2;
    end
end