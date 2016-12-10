%% Lesson 21 - Reblurring demo

% (C) 2013 Jeff Orchard
%     University of Waterloo


f = imread('t2.jpg');
f = double( f(:,:,1) );

g = GaussianBlur(f, 2); %MyGaussianBlur?

g = g + randn(size(g))*2;

figure(1);
imshow(g,[]);

beta = 1.5;
rs = 2; % sigma to use for reblurring

h = zeros(size(f));

figure(1);
for i=1:1000
    h = h + beta*MyGaussianBlur( g - MyGaussianBlur(h,rs) , rs);
    if mod(i,50)==0
        %figure(1);
        imshow(h,[]); title(['Iteration ' num2str(i)]); drawnow;
        %pause;
    end
end

figure(1); imshow(f,[]);
figure(2);
subplot(1,2,1), imshow(g,[]);
subplot(1,2,2), imshow(h,[]);
