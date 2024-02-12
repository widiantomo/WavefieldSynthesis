%r1(r)=sqrt(x1.^2+y1.^2);
%zz(r)=sin(k*r1(r));


imagesc(zz);shading interp;
view(-30,50);
axx=axis;
   gc=gray;
  % cm=gc(:,1);
 %  colormap([0*cm cm cm])
drawnow


