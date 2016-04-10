function [ bitcode ] = ari_encode( symb )
%ari_encode: presents the arithmetic encoded values of symb
%   symb should be a collection of data streams from encode

bitcode = {}
for b = size(symb,2)
    %%
    %add the offest required to clean the coding up
    for i = 0:floor(size(symb{b},2))
        if(symb{b}((i)*3+2) == 12)
            symb{b}((i)*3+3) = symb{b}((i)*3+3) + 2048;
        else
            symb{b}((i)*3+3) = symb{b}((i)*3+3) + 1024;
        end
    end
    
    centers = [0:max(symb{b})];
    pdf = hist(s,centers);
    pdf = pdf+1;
    bitstream = arithenco(s,pdf);
end

