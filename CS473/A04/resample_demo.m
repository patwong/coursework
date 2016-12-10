%resample_demo.m
%Patrick Wong
%two rotations - 30% followed by -30%, to f
%final image: fa
f = imread('pd.jpg');
m_1a1 = p2m([0 0 30 0 0 0]);
m_1a2 = p2m([0 0 -30 0 0 0]);
fa = MyAffine(f,m_1a1,'linear','centred');
fa = MyAffine(fa,m_1a2,'linear','centred');

%% 1b
%six rotations of 5 deg, followed by 6 rotations of -5 deg
%final image: fb
m_1b1 = p2m([0 0 5 0 0 0]);
m_1b2 = p2m([0 0 -5 0 0 0]);
fb = f;
for c = 1:6
    fb = MyAffine(fb,m_1b1,'linear','centred');
end
for c = 1:6
    fb = MyAffine(fb,m_1b2,'linear','centred');
end

%% 1c
fa_diff = imabsdiff(fa,f);
fb_diff = imabsdiff(fb,f);
fai = imadjust(fa_diff,[0 .196], [0 1]);
fbi = imadjust(fb_diff,[0 .196], [0 1]);
subplot(1,2,1), imshow(fai);
subplot(1,2,2), imshow(fbi);

%% 1d
SAD_fa = sum(fa_diff(:));
SAD_fb = sum(fb_diff(:));
outstr = 'absolute difference of fa: %d, absolute difference of fb: %d\n';
fprintf(outstr,SAD_fa,SAD_fb);
%absolute difference of fa: 308790, absolute difference of fb: 817338
%(a) is more accurate because the sum of absolute difference between the original
%image and the resampled image is smaller.
