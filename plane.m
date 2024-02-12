
%function plane membangkitkan plane wave dengan asumsi medan jauh
%sinyal sinusoida murni dibangkitkan, berdasarkan sudut antara arah sinyal
%dan garis loudspeaker array time delay antar sinyal dihitung
%delay ini diubah ke variabel zeropad yang membuat matrix pembangkitan siap
%untuk diblast... viva rocks!!!

%created by : Mohammad Adib w
%             feb 2007
clear all

%acoustic parameter parameter
c = 344;            %m/s

%jumlah loudspeaker
r = 5

% set pure tone parameter
f= 500;             %(hertz)
time = 5;           %signal generation period (second)
lamda = c/f;
k = (2*pi)/lamda;   %wave number

%setup sample
Fs = 44100;
Ts = 1/Fs;

%sample period per time
sampertime = (2*pi*Fs)/(f)

%azimuth angle terhadap sumber plane
alpha = pi/3; 

%parameter penempatan loudspeaker
dl = 0.25;                 %meter

sptime=zeros(5,1);         %speaker matrix delay time
spposition=zeros(5,1);     %speaker position relative to reference speaker
splength=zeros(5,1);

%create matrix loudspeaker position considering the side speaker as reference speaker 
%ref LS
spposition(1) = 0;
%next LS
for ii=2:(r)
    spposition(ii)=dl*(ii-1);
end

%calculate the side length of phytagorian triangle between spposition and
%angle of incidence
for qq=1:r
    splength(qq) = spposition(qq) * cos(alpha);
    sptime(qq) = splength(qq)/c;
end

sptimed = round(sptime/Ts)';
sptimedr = fliplr(sptimed);
ff = sptimed(1)+sptimedr(1); %differentiator...

%for amount of time
t=0:Ts:time;

clear v
%generate signal (sinusoidal) with phase
for cc=1:r
x = sin(f*2*pi*t);
v(cc,:) = x';
end 

clear t;
wave=v';

%wave=sparse(waveform);
ff  =length(wave);

%concantenate matrix
    for bb=1:r
        if sptimed(bb)==sptimedr(bb) & (length(sptimed(bb))+length(sptimedr(bb)))== ff 
          con = zeros(1,sptimed(bb));
          pro = zeros(1,sptimedr(bb)-1);
        else
          con = zeros(1,sptimed(bb));
          pro = zeros(1,sptimedr(bb));
        end 
        
        hhh = wave(:,bb)';
        newwave = [con hhh pro]';
        length(newwave);
        wwave(:,bb) = newwave;
    end 
    clear wave;

%taperring window : window to reduce truncation effect
%depend on the size of array
wintap = [0.5;1;1;1;0.5];

for vvv=1:r
    wwave(:,vvv)=wintap(vvv)*wwave(:,vvv);
end
    
%t = 1:length(wwave);
%plot(t,wwave);

y=[wwave(:,1) wwave(:,2)];
sound(y,Fs);





