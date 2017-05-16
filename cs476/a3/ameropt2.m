function [optval, steps] = ameropt2(sigma, r, T, K, dt, S, method,type,dnorm)
%American Option Penalty Method - CN-Rannacher

%steps = T/dt;
%calculating initial option value
if strcmp(type,'call')
    V0 = max(S - K,0).';
elseif strcmp(type,'put')
    V0 = max(K - S,0).';
else
    error('bad type')
end
optval = V0;
poff = V0;
%initializing upstream weighting alpha and beta values
lenS = length(S);
a1 = 2;
a2 = lenS - 1;
Si = S(a1:a2);         %Si
Si_min1 = S(1:a2-1);     %Si-1
Si_pls1 = S(a1+1:lenS);  %Si+1

%cw - central weighting, fw - forward weighting, bw - backward weighting
alpha_cw = (sigma*sigma*Si.*Si)./((Si - Si_min1).*(Si_pls1 - Si_min1)) - (r*Si)./(Si_pls1 - Si_min1);
beta_cw = (sigma*sigma*Si.*Si)./((Si_pls1 - Si).*(Si_pls1 - Si_min1)) + (r*Si)./(Si_pls1 - Si_min1);

alpha_fw = (sigma*sigma*Si.*Si)./((Si - Si_min1).*(Si_pls1 - Si_min1));
beta_fw = (sigma*sigma*Si.*Si)./((Si_pls1 - Si).*(Si_pls1 - Si_min1)) + (r*Si)./(Si_pls1 - Si);

alpha_bw = (sigma*sigma*Si.*Si)./((Si - Si_min1).*(Si_pls1 - Si_min1)) - (r*Si)./(Si - Si_min1);
beta_bw = (sigma*sigma*Si.*Si)./((Si_pls1 - Si).*(Si_pls1 - Si_min1));

%get non-zero elements from central
av = alpha_cw >= 0;
bv = beta_cw >= 0;
if sum(av) == length(av) && sum(bv) == length(bv)
    alpha = alpha_cw;
    beta = beta_cw;
else
    %get the non zero elements of alpha and beta (forward weighting)
    af = alpha_fw >= 0;
    bf = beta_fw >= 0;
    
    %remove the non-zero elements of alpha and beta (central weighting)
    alpha = alpha_cw.*av;
    beta = beta_cw.*bv;
    
    %get the non-zero elements in forward method that aren't in central
    af = abs(av-af);
    bf = abs(bv-bf);    
    af_v = af.*alpha_fw;
    bf_v = bf.*beta_fw;
    
    %add non-zero elements from forward into central
    alpha = alpha + af_v;
    beta = beta + bf_v;
    av = av + af;
    bv = bv + bf;
    if(sum(av) ~= length(av) && sum(bv) ~= length(bv))
        %get the non-zero elements in backwards
        ab = alpha_bw >= 0;
        bb = beta_bw >= 0;

        %get the non-zero elements in backwards that aren't central+forward
        ab = abs(av-ab);
        bb = abs(bv-bb);
        ab_v = ab.*alpha_bw;
        bb_v = bb.*beta_bw;
    
        %add non-zero elements from backwards into central+forwards
        alpha = alpha + ab_v;
        beta = beta + bb_v;
    end
end

t = 0;
large = 10^6;
tol = 1/large;
stored_vs = zeros(lenS,2);
D = ones(lenS,1);
z = 0;
steps = 0;
if strcmp(method,'CNR')
    for i = 1:2
        %implicit time step
        diag1 = [r*dt dt*(alpha + beta + r) 0] + ones(1,lenS);
        M = spdiags([[0 -dt*beta 0].' diag1.' [0 -dt*alpha 0].'],-1:1,lenS,lenS).';
        pvect = optval - poff;
        pvect = large*(pvect < 0);
        P = diag(pvect);
        M = M+P;
        optval = M\(optval+P*poff);
        stored_vs(:,i) = optval;
        t = t + dt;
    end
    while z ~= 1 && t <= T
        %variable time step setup
        mrc_num = abs(stored_vs(:,2) - stored_vs(:,1));
        mrc_den1 = max(abs(stored_vs(:,2)),abs(stored_vs(:,1)));
        mrc_den2 = max(D,mrc_den1);
        maxrelchange = max(mrc_num./mrc_den2);            
        dt = dt*(dnorm/maxrelchange);

        %CN time-stepping
        diag1 = 0.5*[r*dt dt*(alpha + beta + r) 0] + ones(1,lenS);
        M = spdiags([0.5*[0 -dt*beta 0].' diag1.' 0.5*[0 -dt*alpha 0].'],-1:1,lenS,lenS).';
        mindiag = ones(1,lenS) - 0.5*[r*dt dt*(alpha + beta + r) 0];
        Mmin = spdiags([-0.5*[0 -dt*beta 0].' mindiag.' -0.5*[0 -dt*alpha 0].'],-1:1,lenS,lenS).';
        pvect = optval - poff;
        pvect = large*(pvect < 0);
        zs = zeros(lenS,1);
        P = spdiags([zs pvect zs],-1:1,lenS,lenS);
        M = M+P;
        optval = M\(Mmin*optval+P*poff);
        temp = stored_vs(:,2);
        stored_vs(:,2) = optval;
        stored_vs(:,1) = temp;
        converge_value1 = abs(optval - temp);
        converge_value2 = max(1,abs(optval));
        conv = max(converge_value1./converge_value2);
        t = t + dt;        
        if conv < tol
            z = 1;
        end
        steps = steps + 1;
    end
%     dt
%     t
else
    error('please enter a correct time-stepping method');
end
  
end