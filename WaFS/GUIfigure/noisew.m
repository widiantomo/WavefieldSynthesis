% 10 second White noise busrt function
%
% by    : Mohammad Adib W
%         Engineering Physics Students - buiding physics and acoustics
%         laboratory
%         Institute Technology of Bandung - Indonesia
% email : moh.adib.widiantomo@gmail.com
% info  : use with additional files white.mat
%

function noisew(channel)
load white
Fs = 44100;

wavplay(y,Fs);