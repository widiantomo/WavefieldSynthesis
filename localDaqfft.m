function [f, mag] = localDaqfft(data,Fs,blockSize)

% Calculate the fft of the data.
xFFT = fft(data);
xfft = abs(xFFT);

% Avoid taking the log of 0.
index = find(xfft == 0);
xfft(index) = 1e-17;

mag = 20*log10(xfft);
mag = mag(1:blockSize/2);

f = (0:length(mag)-1)*Fs/blockSize;
f = f(:);