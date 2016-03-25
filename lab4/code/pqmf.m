function [ song_data ] = pqmf( filename, frameSize )
%pqmf: filter for mp3
%   Detailed explanation goes here

[audio, fs] = audioread(filename);
nFrame = floor (length (audio)/frameSize);
buffer = zeros(1,512);
song_data = zeros(18,32,nFrame);
    for frame = 1:nFrame                % chunk the audio into blocks of 576 samples
        for segment = 1:18
            
        offset = (frame - 1)*frameSize;       % absolute address of the frame
        for index = 1:18    % 18 non overlapping blocks of size 32
            total_offset = (offset+(index-1)*32)+1;
            song_data(segment,:,frame) = audio(total_offset:total_offset+31);
            % process a block of 32 new input samples
            % see flow chart in Fig. 
            % Frequency inversion
%             if (mod (index,2) == 1)
%                 channel = 1:2:32;
%                 S(channel) = -S(channel);
%             end
        end
    end

end

