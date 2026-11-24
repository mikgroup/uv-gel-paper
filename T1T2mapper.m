%%
username = char(java.lang.System.getProperty('user.name'));

if ~exist('pathSet')
    pathSet=1;
end

if pathSet
switch(username)
    case{'joleneh'}
        disp('Hi Jolene -- added path');
        addpath /Users/joleneh/Library/CloudStorage/GoogleDrive-jolenehuey@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/ESPIRiT/
        addpath /Users/joleneh/Library/CloudStorage/GoogleDrive-jolenehuey@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/ESPIRiT/utils/
        addpath /Users/joleneh/Library/CloudStorage/GoogleDrive-jolenehuey@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/ESPIRiT/ESPIRiT_code/
        addpath /Users/joleneh/Library/CloudStorage/GoogleDrive-jolenehuey@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/orchestra-sdk-2.0-1-2.matlab
        addpath /Users/joleneh/Library/CloudStorage/GoogleDrive-jolenehuey@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/orchestra-sdk-2.0-1-2.matlab/Scripts/
        addpath /Users/joleneh/Library/CloudStorage/GoogleDrive-jolenehuey@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/orchestra-sdk-2.0-1-2.matlab/Examples/
        addpath /Users/joleneh/Library/CloudStorage/GoogleDrive-jolenehuey@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/phantom-building/src/Utils
        addpath /Users/joleneh/Library/CloudStorage/GoogleDrive-jolenehuey@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/phantom-building/src/UtilsExperimental
       pathSet=0;
        
    case{'mlustig'}
        disp('Hi Miki -- added path');

        addpath /Volumes/GoogleDrive/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/ESPIRiT/
        addpath /Volumes/GoogleDrive/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/ESPIRiT/utils/
        addpath /Volumes/GoogleDrive/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/ESPIRiT/ESPIRiT_code/
        addpath /Volumes/GoogleDrive/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/orchestra-sdk-2.0-1-2.matlab
        addpath /Volumes/GoogleDrive/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/orchestra-sdk-2.0-1-2.matlab/Scripts/
        addpath /Volumes/GoogleDrive/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/orchestra-sdk-2.0-1-2.matlab/Examples/
        addpath /Volumes/GoogleDrive/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/phantom-building/src/Utils
        addpath /Volumes/GoogleDrive/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/phantom-building/src/UtilsExperimental
        pathSet=0;
    
    case{'amandamcgraw'}
        disp('Hi Amanda -- added path');
        addpath /Users/amandamcgraw/Library/CloudStorage/GoogleDrive-amanda_mcgraw@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/ESPIRiT/
        addpath /Users/amandamcgraw/Library/CloudStorage/GoogleDrive-amanda_mcgraw@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/ESPIRiT/utils/
        addpath /Users/amandamcgraw/Library/CloudStorage/GoogleDrive-amanda_mcgraw@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/ESPIRiT/ESPIRiT_code/
        addpath /Users/amandamcgraw/Library/CloudStorage/GoogleDrive-amanda_mcgraw@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/orchestra-sdk-2.0-1-2.matlab
        addpath /Users/amandamcgraw/Library/CloudStorage/GoogleDrive-amanda_mcgraw@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/orchestra-sdk-2.0-1-2.matlab/Scripts/
        addpath /Users/amandamcgraw/Library/CloudStorage/GoogleDrive-amanda_mcgraw@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/orchestra-sdk-2.0-1-2.matlab/Examples/
        addpath /Users/amandamcgraw/Library/CloudStorage/GoogleDrive-amanda_mcgraw@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/phantom-building/src/Utils
        addpath /Users/amandamcgraw/Library/CloudStorage/GoogleDrive-amanda_mcgraw@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/phantom-building/src/UtilsExperimental
        pathSet=0;
    
    case{'bryanprabawa'}
        disp('Hi Bryan -- added path');
        addpath /Users/bryanprabawa/Library/CloudStorage/GoogleDrive-bprabawa@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/ESPIRiT/
        addpath /Users/bryanprabawa/Library/CloudStorage/GoogleDrive-bprabawa@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/ESPIRiT/utils/
        addpath /Users/bryanprabawa/Library/CloudStorage/GoogleDrive-bprabawa@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/ESPIRiT/ESPIRiT_code/
        addpath /Users/bryanprabawa/Library/CloudStorage/GoogleDrive-bprabawa@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/orchestra-sdk-2.0-1-2.matlab
        addpath /Users/bryanprabawa/Library/CloudStorage/GoogleDrive-bprabawa@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/orchestra-sdk-2.0-1-2.matlab/Scripts/
        addpath /Users/bryanprabawa/Library/CloudStorage/GoogleDrive-bprabawa@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/orchestra-sdk-2.0-1-2.matlab/Examples/
        addpath /Users/bryanprabawa/Library/CloudStorage/GoogleDrive-bprabawa@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/phantom-building/src/Utils
        addpath /Users/bryanprabawa/Library/CloudStorage/GoogleDrive-bprabawa@berkeley.edu/'Shared drives'/mikGroupDrive/Home/mlustig/Matlab/phantom-building/src/UtilsExperimental
        pathSet=0;

        
end
end
%%
%parameters

scaledown = 1; % scale images by (possibly non) integer factor
gradwarp = 0; % perform gradwarp;


if ~exist('displayImages')
    displayImages =1;
end


T1maskToll = 0.045;  % threshold % for T1 mapping 
T2maskToll = 0.045; % threshold % for T2 mapping 

flipVert = 0;
flipHorz = 0;

register2Ref = 0;
regFile = 'regRef.mat';


%%

try
    
    [kspaces] = loadMappingFiles('./Series*','ScanArchives');

% or 
    catch 
    [kspaces] = loadMappingFiles('./P*7*');
end
%%
% compute sensitivity maps 

disp('Performing ESPIRiT coil sensitivity calibration on first TE image');

% coil combine image

images = getImagesFrmKspace(kspaces, scaledown, displayImages, flipVert, flipHorz);

%%




% image registration to reference
if register2Ref
    load(regFile)
    images = registerMappingImages(images, regRef, 1,0,0, displayImages);
    
end



%% 
disp('T1 Mapping');
[T1est,proton1, proton2,  maskT1] = mapT1(images, T1maskToll);


%%
% Display T1


if displayImages
    
for n=1:images.nslices
    figure('Name',sprintf('slice %d',n));
    subplot(2,1,1), hist(T1est(T1est(:,:,n)>0.01 & T1est(:,:,n) < 4)*1000, 800); title("Histogram of T1 data"); 
    xlabel("T1 (ms)"); ylabel("Frequency"); faxis   

    drawnow;

    subplot(2,3,4)
    imshow(1000*bsxfun(@times, T1est(:,:,n), maskT1(:,:,n)), [0, 2500]); colormap('parula'), colorbar;
    title('T1 map (ms)'); faxis
    drawnow
    subplot(2,3,5)
    imshow(abs(bsxfun(@times, proton1(:,:,n), maskT1(:,:,n))),[]); colormap('parula'), colorbar;
    title('mag1 map'); faxis
    drawnow
    subplot(2,3,6)
    imshow(abs(bsxfun(@times, proton2(:,:,n), maskT1(:,:,n))),[]); colormap('parula'), colorbar;
    title('mag2 map'); faxis
    drawnow
end

end
%% 
% T2 fit:
% 300 sec on [256, 256, 6, 32]
disp('T2 Mapping')
[T2est, proton, maskT2] = mapT2(images,T2maskToll);



%%
% display T2

if displayImages
    
for n=1:images.nslices
    tmp = T2est(:,:,n);
    T2vals = tmp(tmp>0);
    figure('Name',sprintf('slice %d',n));
    subplot(2,1,1);
    hist(T2vals(T2vals<2)*1000, 800); title("Histogram of T2 data"); 
    xlabel("T2 (ms)"); ylabel("Frequency"); faxis
%
    drawnow
    subplot(2,2,3);
    imshow(1000*bsxfun(@times, T2est(:,:,n), maskT2(:,:,n)), [0, 1500]); colormap('parula'), colorbar;
    title('T2 map (ms)'); faxis
    subplot(2,2,4)
    imshow(abs(bsxfun(@times, proton(:,:,n), maskT2(:,:,n))),[]); colormap('parula'), colorbar;
    title('proton density'); faxis
    drawnow
end
end
%%
images.T1est = T1est;
images.T2est = T2est;
images.maskT1 = maskT1;
images.maskT2 = maskT2;

save T1T2fit.mat images

