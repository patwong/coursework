%% Lesson 30 - Joint Entropy

% (C) 2013 Jeff Orchard
%     University of Waterloo


%% Two options

method = 'histogram';  % either 'scatter' or 'histogram'

%% Get two images to compare

f = imread('ct.jpg');
f = double( f(:,:,1));
f = circshift(f, [-4 -18]); % ct needs to be aligned slightly

g = imread('t1.jpg');
g = double(g(:,:,1));

figure(1);


%% Set up a bunch of offsets to try

ranges = [-30:2:30];
%ranges = [-30:2:-2 -2:0.2:2 2:2:30];
%ranges = [-20:0.2:20];

counter = 1;
cost = zeros(size(ranges));

for offset = ranges

    moved_f = MyAffine(f,p2m([0 0 0 0 offset 0]),'linear');
    
    switch method
        case 'scatter'
            % Add a bit of noise to avoid the points plotting
            % directly atop each other. (just for visualization)
            pts = [g(:) moved_f(:)] + randn(length(f(:)),2)*2;
            
            subplot(1,2,1); imshow(moved_f - g, []); drawnow;
            subplot(1,2,2);
            plot(pts(:,1),pts(:,2),'.','Markersize',4);
            axis([0 255 0 255]);
            
            
        case 'histogram'
            p = JointHist(g, moved_f, 32);
            imshow(flipud(log(p+1)'),[], 'InitialMagnification', 'fit');
            
            cost(counter) = entropy(p);
            
            disp(['Offset =' num2str(offset) ' , entropy = ' num2str(cost(counter))])
    end
    
    title(['Offset = ' num2str(offset)]);
    xlabel('g Intensity');
    ylabel('f Intensity');
    drawnow;
    %pause(0.2);

    counter = counter + 1;

end

if strcmp(method, 'histogram')==1
    figure(2);
    plot(ranges,cost);
    ylabel('Joint entropy');
    xlabel('Offset');
end

