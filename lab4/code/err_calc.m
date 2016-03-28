function [ max_err ] = err_calc( original, recons )
%err_calc: calculate the error between these two signals
%   Detailed explanation goes here

%%
%estimate the delay
% copy = recons;
% delay = 0;
% while copy(delay+1) == 0
%     copy = circshift(copy, -1, 2)
%     delay = delay+1;
% end

%%
%Now calculate the error for each sample
delay = finddelay(original, recons)
recons = circshift(recons, -delay, 2);
figure(3)
% plot(original)
% hold
plot(recons)

err = zeros(1,size(recons,2)-delay);
for i = 1:size(recons,2)-delay %loop over the delay adjusted signal
    err(i) = abs((original(i)-recons(i)));
end
max_err = max(err);
end

