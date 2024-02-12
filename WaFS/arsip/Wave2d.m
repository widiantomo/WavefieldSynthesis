c=344;
f=750;
lamda=c/f;
k = (2*pi)/lamda;
r = 5;

%azimuth angle terhadap sumber plane
alpha = pi/6; 

%parameter penempatan loudspeaker
dl = 0.25;                 %meter

%speaker kiri dan kanan
rki=round(r/2);

%panjang dan lebar ruangan
p=3.5;
l=5;
l=l/2;

% Calculate mesh grid
uu=-l:0.05:l;
vv=-p:0.05:0;
[xx,yy]=meshgrid(uu,vv);

AA=[0.0 0.0];
hh=[0.0 -1];
x1=xx-(AA(1)-hh(1));
y1=yy-AA(2)-hh(2);

r1=sqrt((x1.^2)+(y1.^2));
zz=sin(k*r1);

%kanan
y=2;
while y<(rki+1)
AA=[(dl*(y-1)) 0.0];
%x1=xx-AA(1);
%y1=yy-AA(2);
x1=xx-(AA(1)-hh(1));
y1=yy-AA(2)-hh(2);

r1=sqrt((x1.^2)+(y1.^2));
zz=zz+sin(k*r1);
y=y+1;
end

%kiri
y=(-2);
while y>(-1*(rki+1))
AA=[(dl*(y+1)) 0.0];
%x1=xx-AA(1);
%y1=yy-AA(2);
x1=xx-(AA(1)-hh(1));
y1=yy-AA(2)-hh(2);

r1=sqrt((x1.^2)+(y1.^2));
zz=zz+sin(k*r1);
y=y-1;
end
zz;

size(zz,1);
pcolor(zz);shading interp;
axx=axis;
   %gc=gray;
   %cm=gc(:,1);
   %colormap([0*cm cm cm])

   drawnow



