%table 2
clean;
sigma  = 0.4;
r = 0.02;
T = 1;
K = 100;
S0 = 100;
dt = T/25;
N = 25;
type = 'put';
nat = 'euro';
method = 'CN';

S = [0:0.1*K:0.4*K,...
    0.45*K:0.05*K:0.8*K,...
    0.82*K:0.02*K:0.9*K,...
    0.91*K:0.01*K:1.1*K,...
    1.12*K:0.02*K:1.2*K,...
    1.25*K:.05*K:1.6*K,...
    1.7*K:0.1*K:2*K,...
    2.2*K, 2.4*K, 2.8*K,...
    3.6*K, 5*K, 7.5*K, 10*K];
% bsfd_diff = zeros(5,1);
% bsfd = zeros(5,1);
fd_diff = zeros(5,1);
vlen = zeros(1,6);
vlen(1) = 62;
for i = 1:5
    [call, put] = blsprice(S,K,r,T,sigma);
    optval = implicitfd(sigma, r, T, K, S0, dt, S, method,type,nat);
    s_ind = find(S == 100);
    fd
%     bsfd(i) = optval(s_ind);
%     bsfd_diff(i) = abs(put(s_ind) - optval(s_ind));
%     bsfd_diff(i) = max(abs(put - optval'));
    
    %double the number of grid intervals
    gridlen = length(S);
    new_s = zeros(1,2*gridlen-1);
    for c = 1:(gridlen-1)
        new_s(2*c-1) = S(c);
        new_s(2*c) = (S(c) + S(c+1))/2;
    end
    new_s(end) = S(end);
%---------------- check -----------------%
    if i == 5
        orig_s = S;
%         stwo = new_s;
    end
%     vlen(i+1) = length(new_s);
%----------------end check---------------%
    S = new_s;
    dt = dt/2;
end
convratios = (bsfd_diff(1:(i-2))-bsfd_diff(2:(i-1)))./(bsfd_diff(2:(i-1))-bsfd_diff(3:i));
s_50 = find(orig_s == 50);
s_150 = find(orig_s == 150);
%central weighting (difference) [s26, 02.25]