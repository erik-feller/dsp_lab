%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Erik FEller
%Lab 5
%
%
% Harness to run functions written for lab 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
images = {};
saveim = 1; %Switch to allow turning off image saving
images = dir('../images/*.pgm');
loss_factors = [1, 10, 20];
peak_snr = zeros(size(images,1),size(loss_factors,2));
for i = 1:size(images,1)
    images(i).name = strrep(images(i).name,'.pgm','');
    for l = 1:size(loss_factors,2)
        img = imread(fullfile('../images/',strcat(images(i).name,'.pgm')));
        coef = dctmgr(img, loss_factors(l));
        encoded = encode(coef);
        rebuilt = idctmgr(coef, 64, 64, loss_factors(l));
        if(saveim)
            imwrite(rebuilt, fullfile('../output/', strcat(images(i).name, '-',num2str(loss_factors(l)),'.pgm')), 'pgm');
        end
        %%
        %PSNR
        peak_snr(i,l) = 10.*log10((255^2)/((1/size(img,1)^2)*sum(sum(abs(img-uint8(rebuilt)).^2))));
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