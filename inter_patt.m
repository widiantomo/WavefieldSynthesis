c=344;
lamda=c/500;
k = pi/lamda;
r = 5;

%azimuth angle terhadap sumber plane
alpha = pi/3; 

%parameter penempatan loudspeaker
dl = 0.25;                 %meter


% Calculate mesh grid
uu=-10:0.04:10;
vv=-10:0.04:0;
[xx,yy]=meshgrid(uu,vv);

AA(1,:)=[0.0 0.0];
for u=2:r
AA(u,:)=[(dl*(u-1)) 0.0];
end

for xx=1:r
x1(:,:,xx)=xx-AA(xx,1);
y1(:,:,xx)=yy-AA(xx,2);
r1(:,:,xx)=sqrt((x1(:,:,xx).^2)+(y1(:,:,xx).^2));
end
r1(:,:,2);

%for zu=1:r
zz=sin(k*r1(:,:,2))./r1(:,:,2);
%end


pcolor(zz);shading interp;
axx=axis;
   gc=gray;
   cm=gc(:,1);
   colormap([0*cm cm cm])
drawnow



