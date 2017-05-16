%a1q2a
N = 5;
zz = zeros(N,7);
[Call, Put] = blsprice(100,100,0.015,1,0.3);

%loop to a create an array that stores these values
%array (table) does not need to be this big; determined that the
%difference between black scholes put versus tree put value, and similarly
%for call are exactly the same.
k = 1;
for j = 1:N    
    if j > 1
        k = k*2;
    end
    [call_tree1, put_tree1] = euroOpt(0.3,0.015,1,100,100*k,100,'BOTH');
    zz(j,1) = 1/(100*k);
    zz(j,2) = call_tree1;
    zz(j,3) = put_tree1;
    if j > 1
        zz(j,4) = call_tree1 - zz(j-1,2);
        zz(j,5) = put_tree1 - zz(j-1,3);
    end
    if j > 2
        zz(j,6) = (zz(j-1,2)-zz(j-2,2))/(call_tree1 - zz(j-1,2));
        zz(j,7) = (zz(j-1,3)-zz(j-2,3))/(put_tree1 - zz(j-1,3));
    end
end
%zz
