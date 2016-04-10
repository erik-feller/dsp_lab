function [ symb ] = encode( coef )
%encode: encodes coefficients into a jpeg style code
%   coef should be taken from the dctmgr function

symb = {};
for b = 1:size(coef,2)
    symb_p = [];
    curr_block = coef(:,b);
    zip_count = 0;
    for i = 2:64
        start = i-1;
        zip_count = 0;
        while(curr_block(i)==0 && i < 64)
            zip_count = zip_count+1;
            i = i+1;
        end
        if start==1
            nbits = 12;
        else
            nbits = 11;
        end
        if curr_block(start) ~= 0
            symb_p = cat(2, symb_p, [zip_count, nbits, curr_block(start)]);
        end
    end
    symb_p = cat(2, symb_p, [00, 00]);
    symb{b} = symb_p;
end


end

