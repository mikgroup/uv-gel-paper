%%

% paramteters for fit. 

close all

load T1T2fit.mat images

%%

if ~exist('nslice')
    nslice=1;
end



T1est = images.T1est(:,:,nslice);
T2est = images.T2est(:,:,nslice);


minT1 = 0.400;
maxT1 = 3.000;

minT2 = 0.040;
maxT2 = 2.000;

% histogram and peak finding parameters for T1 T2

histSize = 60; % 100x100 2d histogram
expectedPeaks = 18; % number of expected peaks
peakThresh = 10;
peakDistance = 5;


% outlier rejection
xstd = 3; % multiples of standard deviations to reject.


% blind clustering using spatial and relaxation set to 1. 
blind = 1;
maxBlindClusters = 31;

%flip T1 and T2 images
flipVert = 0;
flipHorz = 0;

if blind
    disp('Blind spatial-relaxation clustering')
else
    disp('k-means with histogram init');
end


%%
if flipVert 
    T2est = T2est(end:-1:1,:);
    T1est = T1est(end:-1:1,:);
    flipVert = 0;
end

if flipHorz
    T2est = T2est(:,end:-1:1);
    T1est = T1est(:,end:-1:1);
    flipHorz = 0;
end




%%

%normalize data for clustering

idx = find(T2est>minT2 & T2est < maxT2 & T1est > minT1 & T1est < maxT1);
R1est = T1est*0; R1est(idx) = (1./T1est(idx));
R2est = T2est*0; R2est(idx) = 1./T2est(idx);
mask =R1est*0; mask(idx)=1;

meanR1est = mean(R1est(idx)); scaleR1est = norm(R1est(idx)-meanR1est);
meanR2est = mean(R2est(idx)); scaleR2est = norm(R2est(idx)-meanR2est);
R1norm = (R1est-meanR1est) ./ scaleR1est ;
R2norm = (R2est-meanR2est) ./ scaleR2est ;

[sx,sy] = size(R1est); smax = max(sx,sy);
[yy,xx] = meshgrid(([0:sy-1]-sy/2)/smax, ([0:sx-1]-sx/2)/smax);




%%

% histogram initialization for k-means

if blind==0 
[N,xedg,yedg] = histcounts2(R1norm(idx),R2norm(idx),histSize);

N = imgaussfilt(N,2).^2; % filter and sharpen histogram

xcent = xedg(1:end-1)/2+xedg(2:end)/2;
ycent = yedg(1:end-1)/2+yedg(2:end)/2;
[pks,x,y] = peaks2(N,'MinPeakHeight',peakThresh, 'MinPeakDistance',peakDistance);

if length(pks)~=expectedPeaks
    disp(sprintf('Number of expected peaks is %d, but found %d',expectedPeaks, length(pks)));
end

% plot spread in R1 and R2
figure(1), plot(R1est(idx),R2est(idx),'.');
hold on
plot(xcent(x)*scaleR1est+meanR1est,ycent(y)*scaleR2est + meanR2est,'k*')
xlabel('R1');
ylabel('R2');
title('R1/R2 distribution, x-max peak, o-kmeans');
drawnow;

end

%%

if blind ==0

    C0 = [xcent(x)',ycent(y)'];

    [kidx,C] = kmeans([R1norm(idx),R2norm(idx)],expectedPeaks,'Start',C0 );
    hold on, 
    plot(C(:,1)*scaleR1est+meanR1est,C(:,2)*scaleR2est+meanR2est,'or')

    drawnow;

else
    kidx = clusterdata([R1norm(idx),R2norm(idx), xx(idx),yy(idx)],'maxclust',maxBlindClusters);
    disp(sprintf('Blind clustering found %d clusters, and expected peaks are %d', max(kidx),expectedPeaks));
    
    if max(kidx)<expectedPeaks
        expectedPeaks = max(kidx);
    else %remove clusters
        clusterSize=[];
        for n=1:max(kidx);
            clusterSize(n) = sum(kidx==n);
        end
        [tmp,clstr_idx] = sort(clusterSize,'descend');
        
        newkidx = kidx*0;
        for n=1:expectedPeaks
            newkidx(kidx==clstr_idx(n))=n;
        end
        
        kidx=newkidx;
    end
    
end

    

%%
% plot clusters, remove outliers, and compute centers. 

CC = [];
idx_clust ={};
R1s_ = [];
R2s_ = [];
T1s_ = [];
T2s_ = [];
R1std_ = [];
R2std_ = [];
T1std_ = [];
T2std_ = [];

h = colormap('parula');


for n=1:expectedPeaks
    tmp = idx(kidx==n);
    R1_med = median(R1est(tmp));
    R1_std = 1.25*mad(R1est(tmp));
    R2_med = median(R2est(tmp));
    R2_std = 1.25*mad(R2est(tmp));
    
    idx_clust{n} = tmp((R1est(tmp)> R1_med-xstd*R1_std) & (R1est(tmp)< R1_med+xstd*R1_std) & (R2est(tmp)> R2_med-xstd*R2_std) & (R2est(tmp)< R2_med+xstd*R2_std));
    CC(n,:) = [mean(R1est(idx_clust{n})), mean(R2est(idx_clust{n}))] ;
    T1s_(n) = 1./CC(n,1); T2s_(n) = 1./CC(n,2);
    R1s_(n) = CC(n,1); R2s_(n) = CC(n,2);
    T1std_(n) = std(T1est(idx_clust{n})); T2std_(n) = std(T2est(idx_clust{n}));
    R1std_(n) = std(R1est(idx_clust{n})); R2std_(n) = std(R2est(idx_clust{n}));  
end

figure(2), subplot(1,2,1)
plot(R1est(idx),R2est(idx),'.');
hold on
for n=1:expectedPeaks
    plot(R1est(idx_clust{n}), R2est(idx_clust{n}),'.', 'Color', h(floor(255/expectedPeaks*n),:));
end



for n=1:expectedPeaks
    text(CC(:,1),CC(:,2),'x','Color','Black','FontSize',12, 'FontWeight','bold','VerticalAlignment','middle','HorizontalAlignment','center')

    text(R1s_(n),R2s_(n),sprintf('%d',n),'Color','Black', 'FontSize',16, 'FontWeight','bold','VerticalAlignment','top');
end

xlabel('R1');
ylabel('R2');
title('R1/R2 distribution, +centers');

drawnow;

% compute image centers
Cim = [];

for n=1:expectedPeaks
    Cim(n,:) = round([mean(xx(idx_clust{n})), mean(yy(idx_clust{n}))]*smax + [sx/2,sy/2]);
end


% plot segmentations

segMask = R1est*0;
for n = 1:expectedPeaks
    segMask(idx_clust{n}) = n;
end
figure(2)
subplot(1,2,2), imagesc(segMask),  axis('square')
hold on

for n=1:expectedPeaks
    text(Cim(n,2),Cim(n,1),sprintf('%d',n),'Color','Black', 'FontSize',12, 'FontWeight','bold','VerticalAlignment','middle','HorizontalAlignment','center');
end
title('clusters spatial order')
drawnow;


%%
% compute image centers
Cim = [];

for n=1:expectedPeaks
    Cim(n,:) = round([mean(xx(idx_clust{n})), mean(yy(idx_clust{n}))]*smax + [sx/2,sy/2]);
end



%idx_o = [1:expectedPeaks]';

if isfile('vialsOrder.mat')
    load vialsOrder.mat idx_o
    tmp_idxlust = idx_clust;   
    segMask = R1est*0;  %recompute segMask
    for n = 1:expectedPeaks
        idx_clust{n} = tmp_idxlust{idx_o(n)};
        segMask(idx_clust{n}) = n;
    end
    
    figure(3)
    imagesc(segMask),  axis('square')
    hold on

    for n=1:expectedPeaks
        text(Cim(idx_o(n),2),Cim(idx_o(n),1),sprintf('%d',n),'Color','Black', 'FontSize',12, 'FontWeight','bold','VerticalAlignment','middle','HorizontalAlignment','center');
    end
    title('loaded clusters spatial order')
    drawnow;
else
    idx_o = manual_order_labels(Cim, segMask);
    save vialsOrder.mat idx_o
end



R1s = R1s_(idx_o);
R2s = R2s_(idx_o);
T1s = T1s_(idx_o);
T2s = T2s_(idx_o);

R1std = R1std_(idx_o);
R2std = R2std_(idx_o);
T1std = T1std_(idx_o);
T2std = T2std_(idx_o);



for n=1:expectedPeaks
    disp(sprintf(' T1 = %.0f ± %.2f ms,  T2 = %.0f ± %.2f ms',T1s(n)*1000,T1std(n)*1000,T2s(n)*1000,T2std(n)*1000));
end

save T1T2proc.mat R1s R2s T1s T2s R1std T1std R2std T2std idx_clust segMask 
%%

% plot nice T1 T2 maps

figure(4), subplot(1,2,1)
imshow(T1est.*mask*1000,[0,2]*1000), colormap('parula'), colorbar;
hold on

for n=1:expectedPeaks
    text(Cim(n,2),Cim(n,1),sprintf('%.0f\n± %.0f',T1s_(n)*1000,T1std_(n)*1000),'Color','Black', 'FontSize',12, 'FontWeight','bold','VerticalAlignment','baseline','HorizontalAlignment','center');
end

title('T1 Map');

figure(4)
subplot(1,2,2)
imshow(T2est.*mask*1000,[0,0.9]*1000), colormap('parula'), colorbar;
hold on

for n=1:expectedPeaks
    text(Cim(n,2),Cim(n,1),sprintf('%.0f\n± %.0f',T2s_(n)*1000,T2std_(n)*1000),'Color','Black', 'FontSize',12, 'FontWeight','bold','VerticalAlignment','baseline','HorizontalAlignment','center');
end

title('T2 Map');

drawnow;

%%
% 
% % plot maps for segmentations
% figure, 
% for n=1:expectedPeaks
%     mask = segMask==n;
%     minval = min(T1est(segMask==n));
%     maxval = max(T1est(segMask==n));
%     subplot(2,expectedPeaks,n),imshow(T1est.*mask*1000,[minval,maxval]*1000);,colormap('jet');
%     title(sprintf('T1, cluster %d',n'));
%     colorbar
% end
% 
%  
% 
% for n=1:expectedPeaks
%     mask = segMask==n;
%     minval = min(T2est(segMask==n));
%     maxval = max(T2est(segMask==n));
%     subplot(2,expectedPeaks,expectedPeaks+n), imshow(T2est.*mask*1000,[minval,maxval]*1000);,colormap('jet'), 
%     title(sprintf('T2, cluster %d',n'));
%     colorbar
%     
% end
% 

%%
% manual order labels

function idx = manual_order_labels(centers, labels)

centers = [centers(:,2),centers(:,1)];
figure, imagesc(labels), axis('square')
hold on
plot(centers(:,1),centers(:,2),'ow')
idx = zeros(size(centers,1),1);

n=1;
while(1)
    [x,y] = ginput(1);
    dist = sqrt(sum((centers-[x,y]).^2,2));
    tmp = find(dist==min(dist));
    if sum(tmp==idx)==0
        text(centers(tmp,1),centers(tmp,2),sprintf('%d',n),'Color','red', 'FontSize',12);
        idx(n) = tmp;
        n=n+1;
        if n>size(centers,1)
            break;
        end
    end
end

end