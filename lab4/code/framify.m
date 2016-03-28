function [ frame_audio, audio ] = framify( song_location, frameSize, dur )
%framify: frame-ify the audio 
%   Detailed explanation goes here

[audio, fs] = audioread(song_location);
if size(audio,1) > dur*fs
    audio = audio(1:dur*fs);
end
nFrame = floor (length (audio)/frameSize);
frame_audio = zeros(32,18,nFrame);
for frame = 1:nFrame                % chunk the audio into blocks of 576 samples   
    offset = (frame - 1)*frameSize;       % absolute address of the frame
    for index = 1:18 
        total_offset = (offset+(index-1)*32)+1;
        frame_audio(:,index,frame) = audio(total_offset:total_offset+31);
    end
end

figure(1)
plot(audio)
end

