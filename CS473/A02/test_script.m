
% Assignment 2 test script


%% MyInterp test
% Create a simple, known volume
row = repmat((1:10)', [1 10 10]);
col = repmat(1:10, [10 1 10]) * 1000;
slc = repmat(reshape(1:10,[1 1 10]), [10 10 1]) * 1000000;
f = col + row + slc;

r = 1.2;
c = 2.8;
s = 3.9;

x = MyInterp(f, [r c s], 'linear');

disp('Test volume intensity of voxel (row, col, slice) = (a.b, c.d, e.f)');
disp('should be ab0cd0e.f');
disp(' ');
disp(['Interpolation at (' num2str(r), ', ' num2str(c) ', ' num2str(s) ') ...']);
disp(['  Your value    = ' num2str(x, '%11.2f')]);
disp(['  Correct value = ' num2str(r + c*1000 + s*1000000, '%11.2f')])


%% MyAffine test
load test_data_v6.mat; % load a small 3D MRI volume

M = p2m([45 0 30 0 0 -15]);
rot_tinyJ = MyAffine(tinyJ, M, 'linear');

% You can also test 2D transforms...
%M = p2m([0 0 30 0 10 0]);
%rot_tinyJ = MyAffine(tinyJ(:,:,16), M, 'linear');

figure(1); imshow(rot_tinyJ(:,:,21),[]);
title('My version');

figure(2); imshow(correct_rotated_tinyJ(:,:,21),[]);
title('What it should look like');


%% MyGaussianBlur test
blurry_tinyJ = MyGaussianBlur(tinyJ, 2);

figure(3); imshow(correct_blurry_tinyJ, []);
title('Correctly blurred');

figure(4); imshow(blurry_tinyJ(:,:,5), []);
title('My blurred version');

%% MyLens (if you are taking CS673)
% Here's how you can run MyLens.

figure(5);
f = imread('cameraman.tif');
g = MyLens(f);
imshow(g,[]);



