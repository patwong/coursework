% function M = p2m([R1 R2 R3 T1 T2 T3])
%
%   Converts motion parameters to a 4x4 homogeneous transformation matrix.
%   The order of operations is:
%     (1) rotate about axis 1, then axis 2, then axis 3
%     (2) translate by [T1 T2 T3]
%
%   Rotation angles are in degrees
%
%%% [4] marks total %%%

%patrick wong 20317267
function M = p2m(th1,th2,th3,t1,t2,t3)
%p2m: R^6 -> R^(4x4)
    
%source for matrix rotations about an axis:
%http://inside.mines.edu/fs_home/gmurray/ArbitraryAxisRotation/

%x-axis rotation (axis 1)
rx = [1 0 0 0;
    0 cosd(th1) -sind(th1) 0;
    0 sind(th1) cosd(th1) 0;
    0 0 0 1];
    
%y-axis rotation (axis 2)
ry = [cosd(th2) 0 sind(th2) 0;
    0 1 0 0;
    -sind(th2) 0 cosd(th2) 0
    0 0 0 1];

%z-axis rotation (axis 2)
rz = [cosd(th3) -sind(th3) 0 0
    sind(th3) cosd(th3) 0 0;
    0 0 1 0;
    0 0 0 1];

M = [1 0 0 t1;
    0 1 0 t2;
    0 0 1 t3;
    0 0 0 1];
     
M = M*rz*ry*rx;
end