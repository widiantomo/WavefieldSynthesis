focused_s = 1;
%frekuensi
f = 500;   
%kecepatan suara
c = 344;   
%get loudspeaker position
r = [-0.5 0;-0.25 0;0 0;0.25 0;0.5 0];  % Receiver position [x y z] (m)
%get source position
sr = [0 -3];   % Source position [x y z] (m)
%get room dimension


ttt=1:1:size(r,1);
vt(ttt,1) = sr(1)-r(ttt,1);
vt(ttt,2) = sr(2)-r(ttt,2);
gg = sqrt((vt(:,1).*vt(:,1))+(vt(:,2).*vt(:,2)));

% check apakah focused source?
if r(1,2)>sr(2)
    focused_s = 1
else
    focused_s = 0
end


% menghitung wave vektor tiap jarak
z=min(gg);
ttt=1:size(r,1);
ph(ttt) = gg(ttt)-z;
Phasedw(ttt) = ph(ttt)*2*f/c;   %phase delay for every source receiver distance
% ubah kordinat receiver pada ruangan ke kordinat ruang reproduksi
r(:,2)=0;

if focused_s == 1
indd = tabulate(Phasedw); % tabulasikan matrix ; ind(:,1) untuk nilai; indd(:,1) untuk jumlah
uy = length(indd);
indd(:,3)=0;
    oio = 1:1:uy;
    pointers = zeros(1,h);
    indd(:,3)=oio';
    invrsval = (fliplr(indd(:,1)'))';
    invrsnum = (fliplr(indd(:,3)'))';
Phasedwi = zeros(1,h);
    
    %kemudian tentukan lokasi
for rrr= 1:1:h 
for jjj= 1:1:uy
if Phasedw(rrr)== indd(jjj,1)
pointers(rrr)= indd(jjj,3);
end
end
end

for eee= 1:1:h 
for kkk= 1:1:uy
if pointers(eee)==invrsnum(kkk,1)
Phasedw(eee)=invrsval(kkk,1);    
end
end
end

else
end

p=3.5;
l=2;
lamda=c/f;
k = (2*pi)/lamda;

%phasedw=phasedw*2;
% Calculate mesh grid
uu=-l:0.05:l;
vv=-p:0.05:0;
[xx,yy]=meshgrid(uu,vv);

% initialize matrix zz by calculating first speaker
x1=xx-r(1,1);
y1=yy-r(1,2);
r1=sqrt((x1.^2)+(y1.^2));
zzz=sin((k*r1)+Phasedw(1));

for ttt=2:size(r,1)
x1=xx-r(ttt,1);
y1=yy-r(ttt,2);
r1=sqrt((x1.^2)+(y1.^2));
zzz=sin((k*r1)+Phasedw(ttt))+zzz;
end

pcolor(zzz);shading interp;
Xtick=(0:1:(l+l))';
Ytick=(0:1:p)';
set(gca,'XTickMode','manual');
set(gca,'YTickMode','manual');
set(gca,'XTickLabel',Xtick);
set(gca,'YTickLabel',Ytick);


