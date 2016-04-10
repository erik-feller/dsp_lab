%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Erik FEller
%Lab 5
%
%
% Harness to run functions written for lab 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
images = {};
images = dir('../images/*.pgm');
loss_factors = [1, 10, 20]
for i = 1:size(images,1)
    images(i).name = strrep(images(i).name,'.pgm','')
    for l = 1:size(loss_factors,2)
        img = imread(fullfile('../images/',strcat(images(i).name,'.pgm')));
        coef = dctmgr(img, l);
        rebuilt = idctmgr(coef, 64, 64, l);
        imwrite(rebuilt, fullfile('../output/', strcat(images(i).name, '-',num2str(loss_factors(l)),'.png')), 'png');
    end
end

%%
%plotting the reconstruction
figure()
imagesc(rebuilt,[0,255])
colormap gray
axis square
axis off

%%