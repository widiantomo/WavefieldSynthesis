AA=[0.0 0.0];
x1=xx-AA(1);
y1=yy-AA(2);
r1=sqrt((x1.^2)+(y1.^2));
zz=sin(k*r1);

AA=[-2.0 0.0];
x1=xx-AA(1);
y1=yy-AA(2);
r1=sqrt((x1.^2)+(y1.^2));
zz=zz+sin(k*r1);
