c=344;
f=500;
lamda=c/f;
k = (2*pi)/lamda;
r = 1;

%panjang dan lebar ruangan
p=2;
l=4;
l=l/2;

% Calculate mesh grid
uu=-l:0.05:l;
vv=-p:0.05:0;
[xx,yy]=meshgrid(uu,vv);


AA=[-0.5 0.0];
x1=xx-AA(1);
y1=yy-AA(2);
r1=sqrt((x1.^2)+(y1.^2));
zz=sin(k*r1);

AA=[0.0 0.0];
x1=xx-AA(1);
y1=yy-AA(2);
r1=sqrt((x1.^2)+(y1.^2));
zz=zz+sin(k*r1);

AA=[0.5 0.0];
x1=xx-AA(1);
y1=yy-AA(2);
r1=sqrt((x1.^2)+(y1.^2));
zz=zz+sin(k*r1);

AA=[-0.25 0.0];
x1=xx-AA(1);
y1=yy-AA(2);
r1=sqrt((x1.^2)+(y1.^2));
zz=zz+sin(k*r1);

AA=[0.25 0.0];
x1=xx-AA(1);
y1=yy-AA(2);
r1=sqrt((x1.^2)+(y1.^2));
zz=zz+sin(k*r1);



size(zz,1);
pcolor(zz);shading interp;
axx=axis;
   %gc=gray;
   %cm=gc(:,1);
   %colormap([0*cm cm cm])

   drawnow

