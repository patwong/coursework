function NL = CreateImageGraph(U)
%CreateImageGraph(U) ==> NL
%input: m x n image; output: normalized graph laplacian matrix mn x mn

sigmasq_dist = 100;
sigmasq_int = 0.001;

%pg90 of notes to determine W
% or not?

[m, n] = size(U);
W = zeros(m*n,m*n);
D = zeros(m*n,m*n); %we can compute D at same time as W; D is sum of all W at row i
NL = eye(m*n);

% U = [1 2 3; 4 5 6; 7 8 9];
%iterate through U and write entries for W and D
for i = 1:m
    for j = 1:n
        if i == 1 %no top neighbour
            if j == 1 %no left neighbors                
                %right neighbor
                pdist = pixeldist(i,j,i,j+1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i,j+1)) / sigmasq_int);
                W((i-1)*m+j,(i-1)*m+j+1) = edist*eint_r;   %correct 100%
                
                %bottom right neighbor - check this (laplactest)
                pdist = pixeldist(i,j,i+1,j+1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i+1,j+1) + U(i+1,j+1)) / sigmasq_int);
                W((i-1)*m+j,(i)*m+j+1) = edist*eint_r;
            elseif j == n  %no right neighbors                
                %left neighbor
                pdist = pixeldist(i,j,i,j-1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i,j-1)) / sigmasq_int);
                W((i-1)*m+j,(i-1)*m+j-1) = edist*eint_r;
                
                %bottom left neighbor
                pdist = pixeldist(i,j,i+1,j-1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i+1,j-1)) / sigmasq_int);
                W((i-1)*m+j,(i)*m+j-1) = edist*eint_r;
            else %in the middle
                %right neighbor
                pdist = pixeldist(i,j,i,j+1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i,j+1)) / sigmasq_int);
                W((i-1)*m+j,(i-1)*m+j+1) = edist*eint_r;   %correct 100%
                
                %bottom right neighbor - check this (laplactest)
                pdist = pixeldist(i,j,i+1,j+1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i+1,j+1)) / sigmasq_int);
                W((i-1)*m+j,(i)*m+j+1) = edist*eint_r;
                
                %left neighbor
                pdist = pixeldist(i,j,i,j-1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i,j-1)) / sigmasq_int);
                W((i-1)*m+j,(i-1)*m+j-1) = edist*eint_r;
                
                %bottom left neighbor
                pdist = pixeldist(i,j,i+1,j-1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i+1,j-1)) / sigmasq_int);
                W((i-1)*m+j,(i)*m+j-1) = edist*eint_r;
            end            
            %bottom neighbor
            pdist = pixeldist(i,j,i+1,j);
            edist = exp(-pdist/sigmasq_dist);
            eint_r = exp( -abs(U(i,j) + U(i+1,j)) / sigmasq_int);
            W((i-1)*m+j,i*m+j) = edist*eint_r;
            
            D((i-1)*m+j,(i-1)*m+j) = sum(W((i-1)*m+j,:)); %compute D
        elseif i == m           %no neighbors below
            if j == 1           %no left neighbors
                %right neighbor
                pdist = pixeldist(i,j,i,j+1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i,j+1)) / sigmasq_int);
                W((i-1)*m+j,(i-1)*m+j+1) = edist*eint_r;   %correct 100%
                
                %top right neighbor
                pdist = pixeldist(i,j,i-1,j+1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i-1,j+1)) / sigmasq_int);
                W((i-1)*m+j,(i-2)*m+j+1) = edist*eint_r;   %correct 100%
            elseif j == n       %no right neighbors
                %left neighbor
                pdist = pixeldist(i,j,i,j-1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i,j-1)) / sigmasq_int);
                W((i-1)*m+j,(i-1)*m+j-1) = edist*eint_r;
                
                %top left neighbor
                pdist = pixeldist(i,j,i-1,j-1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i-1,j-1)) / sigmasq_int);
                W((i-1)*m+j,(i-2)*m+j-1) = edist*eint_r;
            else                %bottom middle
                %right neighbor
                pdist = pixeldist(i,j,i,j+1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i,j+1)) / sigmasq_int);
                W((i-1)*m+j,(i-1)*m+j+1) = edist*eint_r;   %correct 100%
                
                %top right neighbor
                pdist = pixeldist(i,j,i-1,j+1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i-1,j+1)) / sigmasq_int);
                W((i-1)*m+j,(i-2)*m+j+1) = edist*eint_r;   %correct 100%                
                
                %left neighbor
                pdist = pixeldist(i,j,i,j-1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i,j-1)) / sigmasq_int);
                W((i-1)*m+j,(i-1)*m+j-1) = edist*eint_r;
                
                %top left neighbor
                pdist = pixeldist(i,j,i-1,j-1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i-1,j-1)) / sigmasq_int);
                W((i-1)*m+j,(i-2)*m+j-1) = edist*eint_r;
            end
            %top neighbor
            pdist = pixeldist(i,j,i-1,j);
            edist = exp(-pdist/sigmasq_dist);
            eint_r = exp( -abs(U(i,j) + U(i-1,j)) / sigmasq_int);
            W((i-1)*m+j,(i-2)*m+j) = edist*eint_r;
            
            D((i-1)*m+j,(i-1)*m+j) = sum(W((i-1)*m+j,:)); %compute D
        else        %it has neighbors above and below
            if j == 1           %no left neighbors
                %right neighbor
                pdist = pixeldist(i,j,i,j+1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i,j+1)) / sigmasq_int);
                W((i-1)*m+j,(i-1)*m+j+1) = edist*eint_r;   %correct 100%
                
                %top right neighbor
                pdist = pixeldist(i,j,i-1,j+1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i-1,j+1)) / sigmasq_int);
                W((i-1)*m+j,(i-2)*m+j+1) = edist*eint_r;   %correct 100%                
                
                %bottom right neighbor - check this (laplactest)
                pdist = pixeldist(i,j,i+1,j+1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i+1,j+1)) / sigmasq_int);
                W((i-1)*m+j,(i)*m+j+1) = edist*eint_r;                
            elseif j == n       %no right neighbors
                %left neighbor
                pdist = pixeldist(i,j,i,j-1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i,j-1)) / sigmasq_int);
                W((i-1)*m+j,(i-1)*m+j-1) = edist*eint_r;
                
                %top left neighbor
                pdist = pixeldist(i,j,i-1,j-1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i-1,j-1)) / sigmasq_int);
                W((i-1)*m+j,(i-2)*m+j-1) = edist*eint_r;                
                
                %bottom left neighbor
                pdist = pixeldist(i,j,i+1,j-1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i+1,j-1)) / sigmasq_int);
                W((i-1)*m+j,(i)*m+j-1) = edist*eint_r;
            else                %in the middle
                %right neighbor
                pdist = pixeldist(i,j,i,j+1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i,j+1)) / sigmasq_int);
                W((i-1)*m+j,(i-1)*m+j+1) = edist*eint_r;   %correct 100%
                
                %top right neighbor
                pdist = pixeldist(i,j,i-1,j+1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i-1,j+1)) / sigmasq_int);
                W((i-1)*m+j,(i-2)*m+j+1) = edist*eint_r;   %correct 100%                
                
                %bottom right neighbor - check this (laplactest)
                pdist = pixeldist(i,j,i+1,j+1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i+1,j+1)) / sigmasq_int);
                W((i-1)*m+j,(i)*m+j+1) = edist*eint_r;                                
                
                %left neighbor
                pdist = pixeldist(i,j,i,j-1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i,j-1)) / sigmasq_int);
                W((i-1)*m+j,(i-1)*m+j-1) = edist*eint_r;
                
                %top left neighbor
                pdist = pixeldist(i,j,i-1,j-1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i-1,j-1)) / sigmasq_int);
                W((i-1)*m+j,(i-2)*m+j-1) = edist*eint_r;                
                
                %bottom left neighbor
                pdist = pixeldist(i,j,i+1,j-1);
                edist = exp(-pdist/sigmasq_dist);
                eint_r = exp( -abs(U(i,j) + U(i+1,j-1)) / sigmasq_int);
                W((i-1)*m+j,(i)*m+j-1) = edist*eint_r;                
            end
            %top neighbor
            pdist = pixeldist(i,j,i-1,j);
            edist = exp(-pdist/sigmasq_dist);
            eint_r = exp( -abs(U(i,j) + U(i-1,j)) / sigmasq_int);
            W((i-1)*m+j,(i-2)*m+j) = edist*eint_r;
            
            %bottom neighbor
            pdist = pixeldist(i,j,i+1,j);
            edist = exp(-pdist/sigmasq_dist);
            eint_r = exp( -abs(U(i,j) + U(i+1,j)) / sigmasq_int);
            W((i-1)*m+j,i*m+j) = edist*eint_r;
            
            D((i-1)*m+j,(i-1)*m+j) = sum(W((i-1)*m+j,:)); %compute D
        end
    end
end

% NL = W;
sqrtd = sqrt(D);
NL = NL - sqrtd*W*sqrtd;
%remember to sparse the result - i.e. sparse(L)
    function dist = pixeldist(i1,j1,i2,j2)
        dist = (i1-i2)^2 + (j1-j2)^2;
    end
end

