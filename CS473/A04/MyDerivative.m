function dfdx = MyDerivative(f, ax)
% function dfdx = MyDerivative(f, ax)
%
% Computes derivative of f with respect to its <ax> motion parameter.
% The value of ax determines which motion paramerter the derivative
% is taken with respect to.
% In particular:
%      ax = 1 :  with respect to rotation about the row axis
%      ax = 2 :  with respect to rotation about the column axis
%      ax = 3 :  with respect to rotation about the slice axis
%      ax = 4 :  with respect to row index
%      ax = 5 :  with respect to column index
%      ax = 6 :  with respect to slice index
%
% ==== Marking Scheme ====
% Total marks [6]

dfdx = zeros(size(f));

switch ax
    case 1
        %(1) rotation about r-axis (enumerates rows, positive down)
        c1 = p2m([1 0 0 0 0 0]);
        c2 = p2m([-1 0 0 0 0 0]);
        dfdx = 0.5*(MyAffine(f,c1,'linear','centred') - MyAffine(f,c2,'linear','centred'));
    case 2
        %(2) rotation about c-axis (enumerates columns)
        c1 = p2m([0 1 0 0 0 0]);
        c2 = p2m([0 -1 0 0 0 0]);
        dfdx = 0.5*(MyAffine(f,c1,'linear','centred') - MyAffine(f,c2,'linear','centred'));
    case 3
        %(3) rotation about s-axis (enumerates slices)
        c1 = p2m([0 0 1 0 0 0]);
        c2 = p2m([0 0 -1 0 0 0]);
        dfdx = 0.5*(MyAffine(f,c1,'linear','centred') - MyAffine(f,c2,'linear','centred'));
    case 4
        %(4) shift in positive r direction
        %central on middle, forward on first, backward last
        dfdx(2:end-1,:,:) = -0.5*(f(3:end,:,:) - f(1:end-2,:,:));
        dfdx(1,:,:) = -(f(2,:,:) - f(1,:,:));
        dfdx(end,:,:) = -(f(end,:,:) - f(end-1,:,:));
    case 5
        %(5) shift in positive c direction
        %central on middle, forward on first, backward last
        dfdx(:,2:end-1,:) = -0.5*(f(:,3:end,:) - f(:,1:end-2,:));
        dfdx(:,1,:) = -(f(:,2,:) - f(:,1,:));
        dfdx(:,end,:) = -(f(:,end,:) - f(:,end-1,:));
    case 6
        %(6) shift in positive s direction
        dfdx(:,:,2:end-1) = -0.5*(f(:,:,3:end) - f(:,:,1:end-2));
        dfdx(:,:,1) = -(f(:,:,2) - f(:,:,1));
        dfdx(:,:,end) = -(f(:,:,end) - f(:,:,end-1));
end

end