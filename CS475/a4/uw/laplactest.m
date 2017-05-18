%laplacian test
origz = [1 2 3; 4 5 6; 7 8 9]
bigw = zeros(9,9);
[lm, ln] = size(origz);

i = 2;
j = 2;

%W((i-1)*m+j,(i-1)*m+j+1) = edistright*eint_r;
bigw((i-1)*lm+j,(i-1)*lm+j+1) = origz(i,j+1); %right
bigw((i-1)*lm+j,(i)*lm+j+1) = origz(i+1,j+1); %bottom right
bigw((i-1)*lm+j,(i-1)*lm+j-1) = origz(i,j-1); %left
bigw((i-1)*lm+j,(i)*lm+j-1) = origz(i+1,j-1); %bottom left
bigw((i-1)*lm+j,(i-2)*lm+j+1) = origz(i-1,j+1); %top right
bigw((i-1)*lm+j,(i-2)*lm+j-1) = origz(i-1,j-1); %top left
bigw((i-1)*lm+j,(i-2)*lm+j) = origz(i-1,j); %top
bigw((i-1)*lm+j,(i)*lm+j) = origz(i+1,j); %bottom

bigw
%IT WORKS!!!!!!!!!!!!!
