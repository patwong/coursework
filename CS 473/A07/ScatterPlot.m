
% function ScatterPlot(I, phi)
%
%  Produces a scatter plot for clustering using a Gaussian Mixture
%  Model (GMM).
%
%   I is a set of scatter points arranged in an NxD matrix.
%       Each row holds one point.
%
%   phi is a cell array holding descriptors for a Gaussian
%       Mixture Model (GMM).  In particular,
%        phi{k}.mu stores the mean for component k,
%        phi{k}.Sigma stores the covariance matrix for component k, and
%        phi{k}.pi stores the mass of component k.
%
%  The ellipses represent the dominant axes dimensinos for each of the K
%  Gaussian components.
%
function ScatterPlot(I, phi)

    [n_pixels D] = size(I); % D is number of images

    K = length(phi); % K is number of Gaussian components

    plot3D = 0;
    if D>2
        plot3D = 1;
    end
    
    % Draw scatter points first
    if plot3D==0
        plot(I(:,1), I(:,2), '.', 'MarkerEdgeColor', [0.6 0.6 0.9], 'MarkerSize', 2);
    else
        plot3(I(:,1), I(:,2), I(:,3), '.', 'MarkerEdgeColor', [0.2 0.2 0.5], 'MarkerSize', 2);
    end

    axis square;
    hold on;

    % For each Gaussian component, plot an ellipse.
    for k = 1:K

        % Find dominant directions (leading eigenvectors)
        [V, Lambda] = eig(phi{k}.Sigma);
        Lambda=sqrt(Lambda);
        [lam, idx] = sort(abs(diag(Lambda)), 'descend');

        % Compute the ellipse points.
        t = (0:360) / 180*pi;
        x = [cos(t) ; sin(t)];
        y = Lambda(idx(1),idx(1))*V(:,idx(1))*x(1,:) + Lambda(idx(2),idx(2))*V(:,idx(2))*x(2,:);
        % Shift it to be centred on mu
        y = y + repmat(phi{k}.mu', 1, size(y,2));

        % Draw the component ellipses and means
        if plot3D==0
            % Only 2D
            plot(y(1,:), y(2,:),'k-','LineWidth',2,'Color',[0 0 0]*(1-phi{k}.pi));
            plot(phi{k}.mu(1), phi{k}.mu(2), 'x');
        else
            % 3D version
            % Ellipse
            plot3(y(1,:),y(2,:),y(3,:),'k-','LineWidth',2,'Color',[0 0 0]*(1-phi{k}.pi));
            % Put a cross at the mean.
            plot3(phi{k}.mu(1), phi{k}.mu(2), phi{k}.mu(3), 'x');
        end
        
        % Fix axes to make it pretty.
        if plot3D==0
            axis([0 255 0 255]);
        else
            axis([0 255 0 255 0 255]);
        end

    end

    hold off;
    drawnow;

