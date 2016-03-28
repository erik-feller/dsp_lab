%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Erik Feller
% Lab 4
%
% This harness calls all of the necessary functions for lab 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[frames, song] = framify('../lab4-data/sample1.wav',576,5);
S = pqmf(frames);
% S = pqmf('../lab4-data/sample2.wav',576);
m = ipqmf(S);
b = 19:30;

err_calc(song', m)
m_b = ipqmf_bands(S, b);
figure(4)
plot(song)
hold
plot(m_b)
hold

