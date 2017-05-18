%
% CS475/675: Assignment 4
%
%   Cell image segmentation
%


%
% Read in a block from a cell image
%
U = imread('cellimage.tif');
U = U(365:465,170:270);
U = double(U);
U = U/max(U(:));


%
% Create the normalized graph Laplacian from image U
% You will need to implement this function in part (a).
%Note: 1) use sigma^2 = 0.001 for the intensity weight
%         and sigma^2 = 100 for the distance weight
%      2) use 8 neighbours for W

NL = CIG_adjusted2(U);



%
% Normalized spectral clustering
%
%K from [2,20]  - tried: 2
K = 9;

%*** Provide your code here for part (b)! ***

%%-------my code--------%%
[eigvecs,~] = eigs(NL,K,'sm');      %get the eigenvectors
[eig_m, eig_n] = size(eigvecs);     %get the height of eigenvectors
Q = eigvecs;                        
for i = 1:eig_m
    Q(i,:) = Q(i,:)/norm(Q(i,:));   %normalize each row of eigenvector
end
index = kmeans(Q,K,'Replicates',20); %get the kmeans clusters
%%-------my code--------%%

%result should be the variable 'index' produced by kmeans, 
%a vector of length m*n containing the 
%cluster index for each pixel

%
% Extract segments for the cell region
%
Clusters = reshape(index,size(U,1),size(U,2));

Disk = fspecial('disk',floor(size(U,1)/2));
Disk = Disk>0;

Cell = zeros(size(U));
for k=1:K
    seg_size = nnz(Clusters==k);
    overlap = (Clusters==(Disk*k));
    in_size = nnz(overlap);
    if in_size == seg_size,
        Cell = Cell + (Clusters==k);
    end
end
Cell = 2*(Cell-0.5);


%
% Visualize segmentation results
%
figure(1);

%input image
subplot(1,3,1);
imshow(U,[]);

%generated clusters
subplot(1,3,2);
imshow(Clusters,[]);
str1 = sprintf('K = %d', K);
title(str1);

%segmented result
subplot(1,3,3);
imshow(U,[]);
hold on;
contour(Cell,[0 0],'r', 'linewidth', 1.5);
hold off;
