function optval = ifd_lvf(vol, r, T, K, dt, S, method,type)
%black-scholes PDE implicit/CN/CN-Rannacher method
%method: 'implicit', 'CN', 'CNR'
%type: 'call','put'
%MODIFIED TO ACCEPT A VOLATILITY MATRIX

steps = T/dt;
%calculating initial option value
if strcmp(type,'call')
    V0 = max(S - K,0).';
elseif strcmp(type,'put')
    V0 = max(K - S,0).';
else
    error('bad type')
end
optval = V0;
%initializing upstream weighting alpha and beta values
lenS = length(S);
a1 = 2;
a2 = lenS - 1;
Si = S(a1:a2);           %Si
Si_min1 = S(1:a2-1);     %Si-1
Si_pls1 = S(a1+1:lenS);  %Si+1

if strcmp(method,'implicit')
    for i = 1:steps
        %use one volatility vector per time step
        %used to calculate alpha, beta
        volvect = vol(:,i);
        volvect = volvect(2:end-1)';
        alpha_cw = (volvect.*Si.*Si)./((Si - Si_min1).*(Si_pls1 - Si_min1)) - (r*Si)./(Si_pls1 - Si_min1);
        beta_cw = (volvect.*Si.*Si)./((Si_pls1 - Si).*(Si_pls1 - Si_min1)) + (r*Si)./(Si_pls1 - Si_min1);

        alpha_fw = (volvect.*Si.*Si)./((Si - Si_min1).*(Si_pls1 - Si_min1));
        beta_fw = (volvect.*Si.*Si)./((Si_pls1 - Si).*(Si_pls1 - Si_min1)) + (r*Si)./(Si_pls1 - Si);

        alpha_bw = (volvect.*Si.*Si)./((Si - Si_min1).*(Si_pls1 - Si_min1)) - (r*Si)./(Si - Si_min1);
        beta_bw = (volvect.*Si.*Si)./((Si_pls1 - Si).*(Si_pls1 - Si_min1));

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
            af_v = af*alpha_fw;
            bf_v = bf*beta_fw;

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
                ab_v = ab*alpha_bw;
                bb_v = bb*beta_bw;

                %add non-zero elements from backwards into central+forwards
                alpha = alpha + ab_v;
                beta = beta + bb_v;
            end
        end
        diag = [r*dt dt*(alpha + beta + r) 0] + ones(1,lenS);
        M = spdiags([[0 -dt*beta 0].' diag.' [0 -dt*alpha 0].'],-1:1,lenS,lenS).';    
        optval = M\optval;
    end
elseif strcmp(method,'CN')
    for i = 1:steps
        %use one volatility vector per time step
        %used to calculate alpha, beta
        volvect = vol(:,i);
        volvect = volvect(2:end-1)';
        alpha_cw = (volvect.*Si.*Si)./((Si - Si_min1).*(Si_pls1 - Si_min1)) - (r*Si)./(Si_pls1 - Si_min1);
        beta_cw = (volvect.*Si.*Si)./((Si_pls1 - Si).*(Si_pls1 - Si_min1)) + (r*Si)./(Si_pls1 - Si_min1);

        alpha_fw = (volvect.*Si.*Si)./((Si - Si_min1).*(Si_pls1 - Si_min1));
        beta_fw = (volvect.*Si.*Si)./((Si_pls1 - Si).*(Si_pls1 - Si_min1)) + (r*Si)./(Si_pls1 - Si);

        alpha_bw = (volvect.*Si.*Si)./((Si - Si_min1).*(Si_pls1 - Si_min1)) - (r*Si)./(Si - Si_min1);
        beta_bw = (volvect.*Si.*Si)./((Si_pls1 - Si).*(Si_pls1 - Si_min1));

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
            af_v = af*alpha_fw;
            bf_v = bf*beta_fw;

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
                ab_v = ab*alpha_bw;
                bb_v = bb*beta_bw;

                %add non-zero elements from backwards into central+forwards
                alpha = alpha + ab_v;
                beta = beta + bb_v;
            end
        end
        diag = 0.5*[r*dt dt*(alpha + beta + r) 0] + ones(1,lenS);
        M = spdiags([0.5*[0 -dt*beta 0].' diag.' 0.5*[0 -dt*alpha 0].'],-1:1,lenS,lenS).';
        mindiag = ones(1,lenS) - 0.5*[r*dt dt*(alpha + beta + r) 0];
        Mmin = spdiags([-0.5*[0 -dt*beta 0].' mindiag.' -0.5*[0 -dt*alpha 0].'],-1:1,lenS,lenS).';
        optval = M\(Mmin*optval);
    end
elseif strcmp(method,'CNR')
    for j = 1:steps
        %use one volatility vector per time step
        %used to calculate alpha, beta
        volvect = vol(:,j);
        volvect = volvect(2:end-1)';
        alpha_cw = (volvect.*Si.*Si)./((Si - Si_min1).*(Si_pls1 - Si_min1)) - (r*Si)./(Si_pls1 - Si_min1);
        beta_cw = (volvect.*Si.*Si)./((Si_pls1 - Si).*(Si_pls1 - Si_min1)) + (r*Si)./(Si_pls1 - Si_min1);

        alpha_fw = (volvect.*Si.*Si)./((Si - Si_min1).*(Si_pls1 - Si_min1));
        beta_fw = (volvect.*Si.*Si)./((Si_pls1 - Si).*(Si_pls1 - Si_min1)) + (r*Si)./(Si_pls1 - Si);

        alpha_bw = (volvect.*Si.*Si)./((Si - Si_min1).*(Si_pls1 - Si_min1)) - (r*Si)./(Si - Si_min1);
        beta_bw = (volvect.*Si.*Si)./((Si_pls1 - Si).*(Si_pls1 - Si_min1));

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
            af_v = af*alpha_fw;
            bf_v = bf*beta_fw;

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
                ab_v = ab*alpha_bw;
                bb_v = bb*beta_bw;

                %add non-zero elements from backwards into central+forwards
                alpha = alpha + ab_v;
                beta = beta + bb_v;
            end
        end
        if j <= 2 %implicit time step
            diag = [r*dt dt*(alpha + beta + r) 0] + ones(1,lenS);
            M = spdiags([[0 -dt*beta 0].' diag.' [0 -dt*alpha 0].'],-1:1,lenS,lenS).';
            optval = M\optval;          
        else %Rannacher smoothing
            diag = 0.5*[r*dt dt*(alpha + beta + r) 0] + ones(1,lenS);
            M = spdiags([0.5*[0 -dt*beta 0].' diag.' 0.5*[0 -dt*alpha 0].'],-1:1,lenS,lenS).';
            mindiag = ones(1,lenS) - 0.5*[r*dt dt*(alpha + beta + r) 0];
            Mmin = spdiags([-0.5*[0 -dt*beta 0].' mindiag.' -0.5*[0 -dt*alpha 0].'],-1:1,lenS,lenS).';
            optval = M\(Mmin*optval);
        end
    end
else
    error('please enter a correct time-stepping method');
end

end