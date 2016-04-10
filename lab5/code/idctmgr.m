function [ img, img_f ] = idctmgr( coef )
%idctmgr: converts from dct coefficients to an image
%   Detailed explanation goes here

%%
%Reconstruct the indices of the tile
indices = reshape(1:numel(coef(:,1)), [8, 8]);
indices_m = fliplr(spdiags(fliplr(indices)));
indices_m(:,1:2:end) = flipud(indices_m(:,1:2:end));
indices_m(indices_m==0) = [];
img_f = zeros(8,8,size(coef,2));
img = zeros(512,512);
for b = 1:size(coef,2)
    %rebuild the tile
    for i = 1:64
        [r , c] = find(indices_m(i)==indices,1);
        img_f(r,c) = coef(i,b);
    end
    img_f(:,:,b) = idct2(img_f(:,:,b));
    
end

