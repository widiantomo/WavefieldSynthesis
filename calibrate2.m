function calibrate2(Fs)
    
close all; % close all figures
format bank
i=1;
n = 1024;
while i<100 % looping
    ibuffer=wavrecord(n,Fs); % read in one second singals
    mag=10*log10(mean(ibuffer.^2)); % RMS in dB
    mag=mag+94;
    disp(mag);    
    i=i+1;;
end
    
