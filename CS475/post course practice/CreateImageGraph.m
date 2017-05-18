function NL = CreateImageGraph(U)
%CreateImageGraph(U) ==> NL
%input: m x n image; output: normalized graph laplacian matrix mn x mn

%this is the version i submitted to learn
sigmasq_dist = 100;
sigmasq_int = 0.001;

[m, n] = size(U);
W = sparse(zeros(m*n,m*n));
D = sparse(zeros(m*n,m*n)); %we can compute D at same time as W; D is sum of all W at row i
NL = sparse(eye(m*n));

%W(U): iterating top to bottom, left to right (project.m StableFluidMatlab)
for j = 1:m
    for i = 1:n
        index = i+(j-1)*m;
        if i == 1                   %%%%%no top neighbour%%%%%
            if j == 1               %%%no left neighbors%%%
                right_neighbour(i,j);
                botrig_neighbour(i,j);
            elseif j == n           %%%no right neighbors%%%
                left_neighbour(i,j);
                botleft_neighbour(i,j);
            else                    %%%top middle%%%
                botleft_neighbour(i,j);
                botrig_neighbour(i,j);
                left_neighbour(i,j);
                botleft_neighbour(i,j);
            end
            bottom_neighbour(i,j);            
            D(index,index) = sum(W(index,:))^(-1/2);
        elseif i == m               %%%%%no neighbors below%%%%%
            if j == 1               %%%no left neighbors%%%
                right_neighbour(i,j);
                toprig_neighbour(i,j);
            elseif j == n           %%%no right neighbors%%%
                left_neighbour(i,j);
                topleft_neighbour(i,j);
            else                    %%%bottom middle%%%
                right_neighbour(i,j);
                toprig_neighbour(i,j);
                left_neighbour(i,j);
                topleft_neighbour(i,j);
            end
            top_neighbour(i,j);
            D(index,index) = sum(W(index,:))^(-1/2);
        else                        %%%%%it has neighbors above and below%%%%%
            if j == 1               %%%no left neighbors%%%
                right_neighbour(i,j);
                toprig_neighbour(i,j);
                botrig_neighbour(i,j);
            elseif j == n           %%%no right neighbors%%%
                left_neighbour(i,j);
                topleft_neighbour(i,j);
                botleft_neighbour(i,j);
            else                    %%%in the middle%%%
                right_neighbour(i,j);
                toprig_neighbour(i,j);
                botrig_neighbour(i,j);
                left_neighbour(i,j);
                topleft_neighbour(i,j);
                botleft_neighbour(i,j);
            end
            top_neighbour(i,j);
            bottom_neighbour(i,j);
            D(index,index) = sum(W(index,:))^(-1/2);
        end
    end    
end

NL = NL - D*W*D;

    function rn = right_neighbour(i,j)
        index = i+(j-1)*m;
        pdist = pixeldist(i,j,i,j+1);
        edist = exp(-pdist/sigmasq_dist);
        eint_r = exp( -abs(U(i,j) - U(i,j+1))^2 / sigmasq_int);
        W(index,index+m) = edist*eint_r;
    end
    function br = botrig_neighbour(i,j)
        index = i+(j-1)*m;
        pdist = pixeldist(i,j,i+1,j+1);
        edist = exp(-pdist/sigmasq_dist);
        eint_r = exp( -abs(U(i,j) - U(i+1,j+1))^2 / sigmasq_int);
        W(index,index+m+1) = edist*eint_r;
    end
    function tr = toprig_neighbour(i,j)
        index = i+(j-1)*m;
        pdist = pixeldist(i,j,i-1,j+1);
        edist = exp(-pdist/sigmasq_dist);
        eint_r = exp( -abs(U(i,j) - U(i-1,j+1))^2 / sigmasq_int);
        W(index,index+m-1) = edist*eint_r;
    end
    function tn = top_neighbour(i,j)
        index = i+(j-1)*m;
        pdist = pixeldist(i,j,i+1,j);
        edist = exp(-pdist/sigmasq_dist);
        eint_r = exp( -abs(U(i,j) - U(i-1,j))^2 / sigmasq_int);
        W(index,index-1) = edist*eint_r;
    end
    function bn = bottom_neighbour(i,j)
        index = i+(j-1)*m;
        pdist = pixeldist(i,j,i+1,j);
        edist = exp(-pdist/sigmasq_dist);
        eint_r = exp( -abs(U(i,j) - U(i+1,j))^2 / sigmasq_int);
        W(index,index+1) = edist*eint_r;
    end
    function ln = left_neighbour(i,j)
        index = i+(j-1)*m;
        pdist = pixeldist(i,j,i,j-1);
        edist = exp(-pdist/sigmasq_dist);
        eint_r = exp( -abs(U(i,j) - U(i,j-1))^2 / sigmasq_int);
        W(index,index-m) = edist*eint_r;
    end
    function bl = botleft_neighbour(i,j)
        index = i+(j-1)*m;
        pdist = pixeldist(i,j,i+1,j-1);
        edist = exp(-pdist/sigmasq_dist);
        eint_r = exp( -abs(U(i,j) - U(i+1,j-1))^2 / sigmasq_int);
        W(index,index-m+1) = edist*eint_r;
    end
    function tl = topleft_neighbour(i,j)
        index = i+(j-1)*m;
        pdist = pixeldist(i,j,i-1,j-1);
        edist = exp(-pdist/sigmasq_dist);
        eint_r = exp( -abs(U(i,j) - U(i-1,j-1))^2 / sigmasq_int);
        W(index,index-1-m) = edist*eint_r;
    end
    function dist = pixeldist(i1,j1,i2,j2)
        %calculating distance between pixels
        dist = (i1-i2)^2 + (j1-j2)^2;
    end
end