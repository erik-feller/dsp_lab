function [ coef, v_tiles, h_tiles ] = dctmgr( image_data )
%dctmgr: provides cosine transformed image data as requested
%   Detailed explanation goes here

%%
%Tilin the image into 8x8 chunks
v_tiles = floor(size(image_data,1)/8);
h_tiles = floor(size(image_data,2)/8);
nTiles = v_tiles*h_tiles;
tiles = zeros(8,8,nTiles);
for v = 1:v_tiles
    for h = 1:h_tiles
        h_offset = (h-1)*8+1;
        v_offset = (v-1)*8+1;
        tiles(:,:,(v-1)*v_tiles+h) = image_data(v_offset:v_offset+7,h_offset:h_offset+7);
    end
end

%%
%Take the DCT of each block
cos_tran = zeros(64,nTiles);
for tile = 1:nTiles
    %reorder into a zigzag
    indices = reshape(1:numel(tiles(:,:,tile)), size(tiles(:,:,tile)));
    indices_m = fliplr(spdiags(fliplr(indices)));
    indices_m(:,1:2:end) = flipud(indices_m(:,1:2:end));
    indices_m(indices_m==0) = [];
    vals = dct2(tiles(:,:,tile)); %Take the discrete cos trans
    vals = vals(indices_m);
    cos_tran(:,tile) = vals';
    
end

%%
%zero frequency stuff
coef = cos_tran;
for i = 2:size(cos_tran,2)
    coef(1,i) = cos_tran(1,i) - cos_tran(1,i-1);
end

end

