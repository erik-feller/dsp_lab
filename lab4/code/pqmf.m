function [ out ] = pqmf( song_location )
%pqmf: filter for mp3
%   Detailed explanation goes here

[audio, fs] = wavread (filename);
frameSize = 576;
nFrame = floor (length (audio)/frameSize);
    for frame = 1:nFrame                % chunk the audio into blocks of 576 samples
        offset = (frame - 1)* frameSize;       % absolute address of the frame
        for index = 1:18                  % 18 non overlapping blocks of size 32
            % process a block of 32 new input samples
            % see flow chart in Fig. 
            % Frequency inversion
            if (mod (index,2) == 1)
                channel = 1:2:32;
                S(channel) = -S(channel);
            end
        end
    end

end

