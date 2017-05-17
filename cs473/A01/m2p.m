% function params = m2p(HTM)
%    HTM - homogeneous transformation matrix (4x4)
%    params - return value is a row vector of the form
%             [Rx Ry Rz Tx Ty Tz]
%%%% [4] marks total %%%%

%patrick wong 20317267
function params = m2p(HTM)
% input: M    output:R^6

%x: phi, y: theta, z: omega
%matrix = [cos(theta)cos(omega)  

%getting translation is just extracting the values from the 4th column
t1 = HTM(1,4);
t2 = HTM(2,4);
t3 = HTM(3,4);

%used this to determine how to get the angles
%http://inside.mines.edu/fs_home/gmurray/ArbitraryAxisRotation/
th2 = asind(-HTM(3,1));
th1 = ceil(asind(HTM(3,2)/cosd(th2)));
th3 = acosd(HTM(1,1)/cosd(th2));

params = [th1 th2 th3 t1 t2 t3];

end