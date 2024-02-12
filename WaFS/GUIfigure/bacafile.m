function [y,format,Fs]=bacafile(filename)

filename='aa.wav';
[y,Fs,bits] = wavread('filename')

if y==2
    format = 'stereo'
elseif y>2
    format = 'mutichannel'
else
    format = 'mono'
end

