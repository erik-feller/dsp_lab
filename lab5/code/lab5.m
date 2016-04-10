%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Erik FEller
%Lab 5
%
%
% Harness to run functions written for lab 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img = imread('../images/fingerprint.pgm');
coef = dctmgr(img);
rebuilt = idctmgr(coef, 64, 64);

%%
%plotting the reconstruction
figure()
imagesc(rebuilt,[0,255])
colormap gray
axis square
axis off

%%