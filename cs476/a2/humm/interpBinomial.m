function deltai = interpBinomial(delta, S, t, ti, simuS)
    %Find ti in array t. Diff should always be 0.
    [diff, n] = min(abs(t - ti));
    %we want to operate on nodes in column n
    %store these values, get rid of rest of matrix to conserve memory
    S = S(1:n,n);
    delta = delta(1:n,n);
    
    % How many prices?
    x = size(simuS);
    x = x(2);
    
    deltai=zeros(x,1);%Pre-allocate
    for i=1:x
        if simuS(i) <= S(1) %Boundary conditions
            deltai(i) = delta(1);
        elseif simuS(i) >= S(n)
            deltai(i) = delta(n);
        else %Inside range
            %find index of nearest price in S
            [ds, f] = min(abs(S - simuS(i)));
            % f is the index, ds is the difference.
            if (f == n)
                deltai(i)=delta(f);
            else
                interS = S(f+1)-S(f);
                df = ds/interS;%will be positive, not inifinite.
                interD = delta(f+1)-delta(f);
                if (interD == 0)
                    % No linear interpolation possible
                    deltai(i)=delta(f);
                else
                    % do linear interpolation
                    deltai(i)=delta(f)+interD*df;
                end
            end
        end
    end
