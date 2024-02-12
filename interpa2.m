c=344;
lamda=c/500;
k = pi/lamda;
r = 128;

%azimuth angle terhadap sumber plane
alpha = pi/3; 

%parameter penempatan loudspeaker
dl = 0.05;                 %meter

%speaker kiri dan kanan
rki=round(r/2);

% Calculate mesh grid
uu=-5:0.05:5;
vv=-5:0.05:0;
[xx,yy]=meshgrid(uu,vv);

AA=[0.0 0.0];
x1=xx-AA(1);
y1=yy-AA(2);
r1=sqrt((x1.^2)+(y1.^2));
zz=sin(k*r1);

%kanan
y=2;
while y<(rki+1)
AA=[(dl*(y-1)) 0.0]
x1=xx-AA(1);
y1=yy-AA(2);
r1=sqrt((x1.^2)+(y1.^2));
zz=zz+sin(k*r1);
y=y+1;
end

%kiri
y=(-2);
while y>(-1*(rki+1))
AA=[(dl*(y+1)) 0.0]
x1=xx-AA(1);
y1=yy-AA(2);
r1=sqrt((x1.^2)+(y1.^2));
zz=zz+sin(k*r1);
y=y-1;
end

pcolor(zz);shading interp;
axx=axis;
   %gc=gray;
   %cm=gc(:,1);
   %colormap([0*cm cm cm])
drawnow



