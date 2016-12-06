% CS 473: A6 Test Script

warning off;

% Read in 2 images
f = imread('rire_t2.jpg');
f = double( f(:,:,1) );

g = imread('rire_pd.jpg');
g = double( g(:,:,1) );

% Minor displacement
true_p = [0 0 -8.1 10.4 15.9 0];
true_p = [0 0 rand(1,3)*16-8 0];
M = p2m(true_p);

% Apply motion to g
g = MyAffine(g, M, 'cubic', 'centred');

% Multiresolution scales
scales = [0.2 0.33 0.5 1];
m_hires = [0 0 0 0 0 0];

% Create a figure that RigidRegMI can display on
figure(1);

% Looping over scales
for scale = scales
    
    % Resize f and g (you could use imresize instead)
    fs = MyResize(f, scale);
    gs = MyResize(g, scale);

    % We have to scale the translations.
    m_lowres = m_hires;
    m_lowres(4:6) = m_hires(4:6) * scale;

    % Register low-res images
    m_lowres = RigidRegMI(fs, gs, m_lowres);

    % We have to scale the translations back up.
    m_hires = m_lowres;
    m_hires(4:6) = m_hires(4:6) / scale;
    
end

p = m_hires; % copy the resulting best motion parameters

% Output
disp(['True motion: ' num2str(true_p)]);
disp(['Estimated motion: ' num2str(p)]);

% Display the outcome
figure(2);
subplot(1,2,1);
imshow(g+f, []); title('Before');

subplot(1,2,2);
f_moved = MyAffine(f,p2m(p),'cubic','centred');
imshow(g+f_moved, []); title('After');

