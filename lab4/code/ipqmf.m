function [ audio ] = ipqmf( coef, frames )
%ipqmf: inverse pqmf signal analysis
%   S should be taken from pqmf function

audio = zeros(1,size(coef,2)/18*576);
buffer = zeros(1,1024); %make the buffer V
U = zeros(1,512); %make pre windowed holder
[C, D] = loadwindow; %load in window
for N = 1:size(coef,2)
    buffer = circshift(buffer,64,2);
    buffer(1:64) = 0; %zero out the front of buffer so that the sum works well
    for i = 1:64
        for k = 1:32
            buffer(i) = buffer(i) + cos(((2.*k)*(15+i)*pi)/64).*coef(k,N);
        end
    end
    %Make U
    for i = 0:7
        for j = 0:31
            U(64*i+j+1) = buffer(128*i+j+1);
            U(64*i+j+32+1) = buffer(128*i+j+96+1);
        end
    end
    %window U
    W = U.*D;
    for j = 0:31
        for i = 0:15
            audio(j+(N-1)*32+1) = audio(j+(N-1)*32+1) + W(j+32*i+1);
        end
    end
end

figure(1)
hold
plot(audio)

end

