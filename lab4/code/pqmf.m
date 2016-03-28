function [ coef ] = pqmf(frames)
%pqmf: filter for mp3
%   Detailed explanation goes here
coef = zeros(32,size(frames,3)*size(frames,2));
X = zeros(512,1);
window = loadwindow';
for frame = 1:size(frames,3)
    for sub_frame = 1:size(frames,2)
        X(33:512) = X(1:480);
        X(1:32) = flipud(frames(:,sub_frame,frame));
        Z = window.*X;
        Y = zeros(64,1);
        for i = 0:63
            for j = 0:7
                Y(i+1) = Y(i+1)+Z((i+64*j)+1);
            end
        end
%         for k = 1:size(Z,1)
%             Y(mod(k-1,64)+1) = Y(mod(k-1,64)+1) + Z(k);
%         end
        for k = 0:31 %For the different subbands
            Mk = zeros(64,1);
            for r = 0:63
                Mk(r+1) = cos(((2*k+1)*(r-16)*pi)/64); %Build Mk
            end
            coef(k+1,(frame-1)*18+sub_frame) = sum(Y.*Mk); %Apply Mk to make the 
            if mod(k,2) == 1
                coef(k+1,(frame-1)*18+sub_frame) = -coef(k+1,(frame-1)*18+sub_frame);
            end
        end 
    end
end

figure(2)
plot(unwrap_s(coef));
end

