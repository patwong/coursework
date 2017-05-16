sigma  = 0.4;
r = 0.02;
T = 1;
K = 100;
S0 = 100;
delta_t = T/25;
N = 25;

S = [0:0.1*K:0.4*K,...
    0.45*K:0.05*K:0.8*K,...
    0.82*K:0.02*K:0.9*K,...
    0.91*K:0.01*K:1.1*K,...
    1.12*K:0.02*K:1.2*K,...
    1.25*K:.05*K:1.6*K,...
    1.7*K:0.1*K:2*K,...
    2.2*K, 2.4*K, 2.8*K,...
    3.6*K, 5*K, 7.5*K, 10*K];

m = length(S);
a = 2;
b = m-1;
alpha_for=sigma^2*(S(a:b).^2)./((S(a:b)-S(a-1:b-1)).*(S(a+1:b+1)-S(a-1:b-1)));
beta_for=sigma^2*(S(a:b).^2)./((S(a+1:b+1)-S(a:b)).*(S(a+1:b+1)-S(a-1:b-1)))+r*S(a:b)./(S(a+1:b+1)-S(a:b));
alpha_back=sigma^2*(S(a:b).^2)./((S(a:b)-S(a-1:b-1)).*(S(a+1:b+1)-S(a-1:b-1))) - r*S(a:b)./(S(a:b)-S(a-1:b-1));
beta_back=sigma^2*(S(a:b).^2)./((S(a+1:b+1)-S(a:b)).*(S(a+1:b+1)-S(a-1:b-1)));
alpha_cen=sigma^2*(S(a:b).^2)./((S(a:b)-S(a-1:b-1)).*(S(a+1:b+1)-S(a-1:b-1))) - r*S(a:b)./(S(a+1:b+1)-S(a-1:b-1));
beta_cen=sigma^2*(S(a:b).^2)./((S(a+1:b+1)-S(a:b)).*(S(a+1:b+1)-S(a-1:b-1))) + r*S(a:b)./(S(a+1:b+1)-S(a-1:b-1));

%%precondition matrix elements to ensure alpha,beta >=0
f=alpha_for >=0 & beta_for >=0;
alpha_up(f)=alpha_for(f);
beta_up(f)=beta_for(f);
alpha_up(~f)=alpha_back(~f);
beta_up(~f)=beta_back(~f);
%get central co-efficients >=0
f= alpha_cen >=0 & beta_cen >=0 ;
alpha(f)=alpha_cen(f);
beta(f)=beta_cen(f);
%otherwise use forward co-efficients
alpha(~f)=alpha_up(~f);
beta(~f)=beta_up(~f);
dt = delta_t;
M=sparse([2:m-1,1,m],[1:m-2,1,m],[-dt*alpha,0,0])+sparse([2:m-1,1,m],[3:m,1,m],[-dt*beta,0,0]) + sparse(1:m,1:m,[1+r*dt,dt*alpha+dt*beta+r*dt+1,1]);
T1 = full(sparse([2:m-1,1,m],[1:m-2,1,m],[-dt*alpha,0,0]));
T2 = full(sparse([2:m-1,1,m],[3:m,1,m],[-dt*beta,0,0]));
T3 = full(sparse(1:m,1:m,[1+r*dt,dt*alpha+dt*beta+r*dt+1,1]));
diag = [r*dt dt*(alpha + beta + r) 0] + ones(1,m);
M1 = spdiags([[0 -dt*beta 0].' diag.' [0 -dt*alpha 0].'],-1:1,m,m).';
FM = full(M1);
V0 = max(K-S,0);
mindiag = ones(1,m) - 0.5*[r*dt dt*(alpha + beta + r) 0];
Mmin = spdiags([-0.5*[0 -dt*beta 0].' mindiag.' -0.5*[0 -dt*alpha 0].'],-1:1,m,m).';
F2 = full(Mmin);
%MM = full(spdiags([-dt*beta.' dt*(alpha.' + beta.' + r.') -dt*alpha.'],-2:0,m-2,m-2).');

TFULL = full(M);