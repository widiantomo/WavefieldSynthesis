function plotmultiwaverev

file = 'aa.wav';
load signalmulti
yy = wavread(file);
x = 1:1000;
baru = [yy(301:1300,1) sigout(301:1300,:)]; 
plot(x,baru(:,:));
