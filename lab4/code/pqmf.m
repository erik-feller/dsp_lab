function [ S ] = pqmf( filename, frameSize, dur)
%pqmf: filter for mp3
%   filename is the file location
%   frameSize is the size of frame to be used
%   length is the length of the sample to be used. Input sanitized

[audio, fs] = audioread(filename);
if size(audio,1) > dur*fs
    audio = audio(1:dur*fs);
else
    disp('length longer than audio track, using whole track...');
end
%%
%Plot the original audio
figure(1);
plot(audio);

nFrame = floor (length (audio)/frameSize);
buffer = zeros(1,512); %Make circular buffer
window = loadwindow;
S = zeros(32,nFrame*18); %Create S to hold a number for each computation
for frame = 1:nFrame                % chunk the audio into blocks of 576 samples   
    offset = (frame - 1)*frameSize;       % absolute address of the frame
    for index = 1:18   
        total_offset = (offset+(index-1)*32)+1;
        buffer = circshift(buffer,32,2);% shift old data to front
        buffer(1:32) = fliplr(audio(total_offset:total_offset+31)); %replace oldest data flip for conv
        Z = buffer.*window; %Calculate Z (apply window)
        Y = zeros(1,64); %Create a place for Y
        for i = 1:size(buffer,2)
            Y(mod(i-1,64)+1) = Y(mod(i-1,64)+1) + Z(i); %Build Y
        end
        for k = 1:32
            for r = 1:size(Y,2)
                S(k,((frame-1)*18+index)) = S(k,((frame-1)*18+index)) + (cos(((2*k)*(r-17)*pi)/64)*Y(r)); %Build S
            end
            %disp((frame-1)*18+index)
            %Frequency inversion
            if mod(k,2) == 0
                S(k,((frame-1)*18+index)) = -S(k,((frame-1)*18+index));
            end
        end
    end
end
%%
%plot things
figure(2);
plot(unwrap_s(S));

end

