c=344;
f=500;
lamda=c/f;
k = (2*pi)/lamda;
r = 5;

%azimuth angle terhadap sumber plane
alpha = pi/6; 

%parameter penempatan loudspeaker
dl = 0.3;                 %meter

%panjang dan lebar ruangan
p=3.5;
l=5;

% Calculate mesh grid
uu=-l:0.05:l;
vv=-p:0.05:0;
[xx,yy]=meshgrid(uu,vv);

AA=[0.0 0.0];
x1=xx-AA(1);
y1=yy-AA(2);

r1=sqrt((x1.^2)+(y1.^2));
zz=sin(k*r1+1);

AA=[dl 0.0];
x1=xx-AA(1);
y1=yy-AA(2);

r1=sqrt((x1.^2)+(y1.^2));
zz=sin((k*r1)+0.5)+zz;

AA=[-dl 0.0];
x1=xx-AA(1);
y1=yy-AA(2);

r1=sqrt((x1.^2)+(y1.^2));
zz=sin((k*r1)+0.5)+zz;

AA=[2*dl 0.0];
x1=xx-AA(1);
y1=yy-AA(2);

r1=sqrt((x1.^2)+(y1.^2));
zz=sin((k*r1))+zz;

AA=[-dl*2 0.0];
x1=xx-AA(1);
y1=yy-AA(2);

r1=sqrt((x1.^2)+(y1.^2));
zz=sin((k*r1))+zz;

size(zz,1);
pcolor(zz);shading interp;
axx=axis;
   %gc=gray;
   %cm=gc(:,1);
   %colormap([0*cm cm cm])

   drawnow