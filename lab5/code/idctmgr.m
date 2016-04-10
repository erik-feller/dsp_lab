function [ img, img_f ] = idctmgr( coef, v_tiles, h_tiles, loss_factor )
%idctmgr: converts from dct coefficients to an image
%   Detailed explanation goes here

%%
%Reconstruct the indices of the tile
indices = reshape(1:numel(coef(:,1)), [8, 8]);
indices_m = fliplr(spdiags(fliplr(indices)));
indices_m(:,1:2:end) = flipud(indices_m(:,1:2:end));
indices_m(indices_m==0) = [];
q_tab = [16 11 10 16 24 40 51 61; 12 12 14 19 26 58 60 55; 14 13 16 24 40 57 69 56; 14 17 22 29 51 87 80 62;...
      18 22 37 56 68 109 103 77; 24 35 55 64 81 104 113 92; 49 64 78 87 103 121 120 101; 72 92 95 98 112 100 103 99];
img_f = zeros(8,8,size(coef,2));
img = zeros(512,512);
for b = 1:size(coef,2)
    %reverse the diff encoding
    if b > 1
        coef(1,b) = coef(1,b)+coef(1,b-1);
    end
    %rebuild the tile
    for i = 1:64
        [r , c] = find(indices_m(i)==indices,1);
        img_f(r,c,b) = coef(i,b);
    end
    
    img_f(:,:,b) = idct2(img_f(:,:,b).*loss_factor.*q_tab);
end

%rebuild whole image
for v = 1:v_tiles
    for h = 1:h_tiles
        h_offset = (h-1)*8+1;
        v_offset = (v-1)*8+1;
        img(v_offset:v_offset+7,h_offset:h_offset+7) = img_f(:,:,(v-1)*v_tiles+h);
    end
end
    

