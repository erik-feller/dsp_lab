function [ bitcode ] = ari_encode( symb )
%ari_encode: presents the arithmetic encoded values of symb
%   symb should be a collection of data streams from encode

bitcode = {}
for b = size(symb,2)
    %%
    %add the offest required to clean the coding up
    for m = 0:floor(size(symb{b},2)/3)-1
        if(symb{b}((m)*3+2) == 12)
            symb{b}((m)*3+3) = symb{b}((m)*3+3) + 2048;
        else
            symb{b}((m)*3+3) = symb{b}((m)*3+3) + 1024;
        end
    end
    centers = [0:max(symb{b})];
    pdf = hist(symb{b},centers);
    pdf = pdf+1;
    
    bitstream = arithenco(symb{b},pdf);
    bitcode{b} = bitstream;
end

