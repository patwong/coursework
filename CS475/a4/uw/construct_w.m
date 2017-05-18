function [D, W] = construct_w(U)
%lol

[m, n] = size(U);
W = zeros(m*n,m*n);
D = zeros(m*n,m*n);
for i = 1:m
    for j = 1:n
        if i == 1 %no top neighbour
            if j == 1 %no left neighbors                
                %right neighbor                
                W((i-1)*m+j,(i-1)*m+j+1) = U(i,j+1);   %correct 100%
                
                %bottom right neighbor - check this (laplactest)
                W((i-1)*m+j,(i)*m+j+1) = U(i+1,j+1);
            elseif j == n  %no right neighbors                
                %left neighbor
                W((i-1)*m+j,(i-1)*m+j-1) = U(i,j-1);
                
                %bottom left neighbor
                W((i-1)*m+j,(i)*m+j-1) = U(i+1,j-1);
            else %in the middle
                %right neighbor
                W((i-1)*m+j,(i-1)*m+j+1) = U(i,j+1);
                
                %bottom right neighbor - check this (laplactest)
                W((i-1)*m+j,(i)*m+j+1) = U(i+1,j+1);
                
                %left neighbor                
                W((i-1)*m+j,(i-1)*m+j-1) = U(i,j-1);
                
                %bottom left neighbor
                W((i-1)*m+j,(i)*m+j-1) = U(i+1,j-1);
            end            
            %bottom neighbor
            W((i-1)*m+j,i*m+j) = U(i+1,j);
            D((i-1)*m+j,(i-1)*m+j) = sum(W((i-1)*m+j,:)); %compute D
        elseif i == m           %no neighbors below
            if j == 1           %no left neighbors
                %right neighbor
                W((i-1)*m+j,(i-1)*m+j+1) = U(i,j+1);
                
                %top right neighbor
                W((i-1)*m+j,(i-2)*m+j+1) = U(i-1,j+1);
            elseif j == n       %no right neighbors
                %left neighbor                
                W((i-1)*m+j,(i-1)*m+j-1) = U(i,j-1);
                
                %top left neighbor
                W((i-1)*m+j,(i-2)*m+j-1) = U(i-1,j-1);
            else                %bottom middle
                %right neighbor
                W((i-1)*m+j,(i-1)*m+j+1) = U(i,j+1);
                
                %top right neighbor
                W((i-1)*m+j,(i-2)*m+j+1) = U(i-1,j+1);                
                
                %left neighbor
                W((i-1)*m+j,(i-1)*m+j-1) = U(i,j-1);
                
                %top left neighbor                
                W((i-1)*m+j,(i-2)*m+j-1) = U(i-1,j-1);
            end
            %top neighbor
            W((i-1)*m+j,(i-2)*m+j) = U(i-1,j);
            D((i-1)*m+j,(i-1)*m+j) = sum(W((i-1)*m+j,:)); %compute D
        else        %it has neighbors above and below
            if j == 1           %no left neighbors
                %right neighbor
                W((i-1)*m+j,(i-1)*m+j+1) = U(i,j+1);
                
                %top right neighbor
                W((i-1)*m+j,(i-2)*m+j+1) = U(i-1,j+1);
                
                %bottom right neighbor - check this (laplactest)
                W((i-1)*m+j,(i)*m+j+1) = U(i+1,j+1);
            elseif j == n       %no right neighbors
                %left neighbor
                W((i-1)*m+j,(i-1)*m+j-1) = U(i,j-1);
                
                %top left neighbor
                W((i-1)*m+j,(i-2)*m+j-1) = U(i-1,j-1);
                
                %bottom left neighbor
                W((i-1)*m+j,(i)*m+j-1) = U(i+1,j-1);
            else                %in the middle
                %right neighbor
                W((i-1)*m+j,(i-1)*m+j+1) = U(i,j+1);
                
                %top right neighbor
                W((i-1)*m+j,(i-2)*m+j+1) = U(i-1,j+1);
                
                %bottom right neighbor - check this (laplactest)
                W((i-1)*m+j,(i)*m+j+1) = U(i+1,j+1);
                
                %left neighbor
                W((i-1)*m+j,(i-1)*m+j-1) = U(i,j-1);
                
                %top left neighbor
                W((i-1)*m+j,(i-2)*m+j-1) = U(i-1,j-1);
                
                %bottom left neighbor
                W((i-1)*m+j,(i)*m+j-1) = U(i+1,j-1);
            end
            %top neighbor
            W((i-1)*m+j,(i-2)*m+j) = U(i-1,j);
            
            %bottom neighbor            
            W((i-1)*m+j,i*m+j) = U(i+1,j);
            D((i-1)*m+j,(i-1)*m+j) = sum(W((i-1)*m+j,:)); %compute D
        end
    end
end
end