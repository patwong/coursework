%%% CS 473 A2 - Patrick Wong 20317267

% function y = MyInterp(f, x, method)
%  Interpolate an array f.
%
%  Input:
%    f is a 2D or 3D array (image or volume)
%    x is a 2-vector or 3-vector
%    method is either 'nearest' or 'linear'
%
%  Output:
%    y is the interpolation value of f at location x
%
%    If x is outside f, then the return value is 0.
%    eg. if f is a 10x15 pixel image, then
%        x=[0.9 4.8] and x=[3.7 15.1] are both outside f
%
%%%% [5] marks total
function y = MyInterp(f, x, method)

% Get dimensions of array
dims = size(f);
numDims = length(dims);
if numDims == 2
    [m,n] = size(f);
else
    % Input array is not 2D (then it's 3D)
    [m,n,z] = size(f); 
end
switch method
    case 'nearest'
        if numDims == 2
            %checking bounds
            if x(1) < 1 || x(1) > m || x(2) > n || x(2) < 1
                y = 0;
            else
                %want the closest (r, c) - find which one has the min absolute distance
                %closest row dist
                if abs(x(1) - ceil(x(1))) < abs(x(1)-floor(x(1)))
                    xtemp = min(ceil(x(1)),m);
                else
                    xtemp = max(floor(x(1)),1);
                end
                %closest col distance
                if abs(x(2) - ceil(x(2))) < abs(x(2)-floor(x(2)))
                    ytemp = min(ceil(x(2)),n);
                else
                    ytemp = max(floor(x(2)),1);
                end
                y = f(xtemp,ytemp);
            end
        elseif numDims == 3
            %ohecking bounds
            if x(1) > m || x(1) < 1 || x(2) > n || x(2) < 1 || x(3) > z || x(3) < 1
                y = 0;
            else
                %want the closest (r, c, d) - find which one has the min absolute distance
                %closest row dist
                if abs(x(1) - ceil(x(1))) < abs(x(1)-floor(x(1)))
                    xtemp = min(ceil(x(1)),m);
                else
                    xtemp = max(floor(x(1)),1);
                end
                %closest col distance
                if abs(x(2) - ceil(x(2))) < abs(x(2)-floor(x(2)))
                    ytemp = min(ceil(x(2)),n);
                else
                    ytemp = max(floor(x(2)),1);
                end
                %closest depth distance
                if abs(x(3) - ceil(x(3))) < abs(x(2)-floor(x(3)))
                    ztemp = min(ceil(x(3)),z);
                else
                    ztemp = max(floor(x(3)),1);
                end
                y = f(xtemp,ytemp,ztemp);
            end
        end
    case 'linear'
        if numDims == 2
            if x(1) < 1 || x(1) > m || x(2) < 1 || x(2) > n
                %out of bounds
                y = 0;
            else %inbounds
                f_toprow = floor(x(1));     %row above
                f_botrow = ceil(x(1));      %row below
                f_rcol = ceil(x(2));        %right column
                f_lcol = floor(x(2));       %left column
                a1 = abs(x(1) - f_toprow);
                b1 = abs(x(2) - f_lcol);
                y = f(f_toprow,f_lcol)*(1-a1)*(1-b1) + f(f_toprow,f_rcol)*(1-a1)*b1 + f(f_botrow,f_lcol)*a1*(1-b1) + f(f_botrow,f_rcol)*a1*b1;
            end
        elseif numDims == 3
            if x(1) < 1 || x(1) > m || x(2) < 1 || x(2) > n || x(3) < 1 || x(3) > z
                %out of bounds
                y = 0;
            else %inbounds
                f_toprow = floor(x(1));     %row above
                f_botrow = ceil(x(1));      %row below
                f_rcol = ceil(x(2));        %right column
                f_lcol = floor(x(2));       %left column
                f_indepth = floor(x(3));    %"in" depth
                f_outdepth = ceil(x(3));    %"out" depth
                a1 = abs(x(1) - f_toprow);  %alpha
                b1 = abs(x(2) - f_lcol);    %beta
                g1 = abs(x(3) - f_indepth); %gamma
                %default: top, left, in - for consistency
                y = f(f_toprow,f_lcol,f_indepth)*(1-a1)*(1-b1)*(1-g1) + f(f_botrow,f_lcol,f_indepth)*a1*(1-b1)*(1-g1) ...
                    + f(f_toprow,f_rcol,f_indepth)*(1-a1)*b1*(1-g1) + f(f_toprow,f_lcol,f_outdepth)*(1-a1)*(1-b1)*g1 ...
                    + f(f_botrow,f_lcol,f_outdepth)*a1*(1-b1)*g1 + f(f_toprow,f_rcol,f_outdepth)*(1-a1)*b1*g1 ...
                    + f(f_botrow,f_rcol,f_indepth)*a1*b1*(1-g1) + f(f_botrow,f_rcol,f_outdepth)*a1*b1*g1;                    
            end
        end
end

end