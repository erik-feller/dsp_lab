%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Erik Feller
% Lab 4
%
% This harness calls all of the necessary functions for lab 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

frames = framify('../lab4-data/sine1.wav',576,5);
S = pqmf(frames);
% S = pqmf('../lab4-data/sample2.wav',576);
m = ipqmf(S);

