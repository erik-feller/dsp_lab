function [ bitcode ] = ari_encode( symb )
%ari_encode: presents the arithmetic encoded values of symb
%   symb should be a collection of data streams from encode

for b = size(symb,2)
    centers = [0:max(symb{b})];
    pdf = hist(s,centers);
    pdf = pdf+1;
    bitstream = arithenco(s,pdf);
end

