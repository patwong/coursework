%translate left by 9 pixels, down by 21 pixels
%rotate 10% counter-clockwise about (50,60)
%patrick wong 20317267

%translate left by 9 pixels, down by 21
m_trans = zeros(4);
m_trans(1,4) = 21;
m_trans(2,4) = -9;

%%%rotate by 10% around (50,60)
%first translate by moving away from (50,60)
m_rot = zeros(4,4);
m_rot(1,4) = -60;
m_rot(2,4) = -50;
m_rot2 = m_trans + m_rot;

%creating rotation matrix
%cartesian: x = xcos - ysin, y = xsin + ycos 
%==> in matlab should be y = -xsin - ycos since down %increases
m_r10 = [cosd(10) -sind(10) 0 0;
        -sind(10) -cosd(10) 0 0;
        0 0 1 0;
        0 0 0 1];

%rotating 10 degrees
M = m_r10*m_rot2;

%translate back to original position
M(1,4) = M(1,4) + 60;
M(2,4) = M(2,4) + 50;