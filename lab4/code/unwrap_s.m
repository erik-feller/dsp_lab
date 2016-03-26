function [ S_unwrap ] = unwrap_s( S )
%unwrap_s: unwraps a NxM matrix into a single row vector
%   accepts input of S coefficients

S_unwrap = []; %initialize the destination array
for i = 1:size(S,1)
    S_unwrap = cat(2,S_unwrap,S(i,:));
end

end

