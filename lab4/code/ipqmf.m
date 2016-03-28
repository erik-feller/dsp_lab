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
    for i = 0:63
        for k = 0:31
            if mod(k,2) == 1
                mul = -1;
            else
                mul = 1;
            end
            buffer(i+1) = buffer(i+1) + cos(((2.*k+1)*(16+i)*pi)/64).*coef(k+1,N)*mul;
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

