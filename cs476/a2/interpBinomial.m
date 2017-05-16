function delta_i = interpBinomial(delta,S,t,ti,simuS)
%delta interpolation

%n tells us which element of t is closest to ti
%a1 should be 0
[a1, n] = min(abs(t - ti));

%get the column of S and delta we want
Sn = S(:,n);
deltan = delta(:,n);

%find the size of the vector and create our deltai vector
[sz1, sz2] = size(Sn);
delta_i = zeros(sz1:1);

for z = 1:n
    if simuS(z) >= Sn(sz2,1)
        delta_i(z,1) = deltan(n,1);
    elseif simuS(z) <= Sn(1,1)
        delta_i(z,1) = deltan(1,1);
    else
        [a2,k] = min(abs(Sn - simuS(z)));  %n index of Sn closest to simu(S)
        if k == z && a2 == 0
            delta_i(z,1) = deltan(k,1);
        elseif Sn(k) < simuS(z)
            dx1 = Sn(k+1,1)-Sn(k,1);
            dx0 = simuS(z)-Sn(k,1);
            dxx = dx0/dx1;
            dy = deltan(k+1,1) - deltan(k,1);
            delta_i(z,1) = deltan(k) + dy*dxx;
        else
            dx1 = Sn(k,1)-Sn(k-1,1);
            dx0 = simuS(z)-Sn(k-1,1);
            dxx = dx0/dx1;
            dy = deltan(k,1) - deltan(k-1,1);
            delta_i(z,1) = deltan(k-1) + dy*dxx;
        end
    end
end

end