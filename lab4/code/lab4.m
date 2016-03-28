%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Erik Feller
% Lab 4
%
% This harness calls all of the necessary functions for lab 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[frames, song] = framify('../lab4-data/gilberto.wav',576,5);
S = pqmf(frames);
% S = pqmf('../lab4-data/sample2.wav',576);
m = ipqmf(S);

%%
%Plot the audio vs reconstructed
figure(1)
plot(song')
hold
plot(m)
hold

%%
%Find error
err_calc(song', m)

%%
%decare bands and determine
b = 0:15;
m_b = ipqmf_bands(S, b);

%%
%Plot original vs the reduced band restoration
figure(4)
plot(song)
hold
plot(m_b)
hold

