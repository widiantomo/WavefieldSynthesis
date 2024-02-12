% The program produce an animation of the interferens pattern from two wave
% which interfer.
% Type Inter_patt and watch the animation.Then you can type movie(Inter) and
% watch it again
%
% By Farhad Aslani
% adress:  Salviagatan 28
%          424 40 Angered
%          Sweden
%
% email:   gu96faas@dd.chalmers.se
%
% The program is tested for version 5.2.0 of MATLAB on a Sun SOL2 computer

uu=-3:0.04:3;
vv=-2.5:0.04:2.5;
[xx,yy]=meshgrid(uu,vv);

AA=[0.6 0.0];  
BB=[-0.6 0.0];
x1=xx-AA(1);
y1=yy-AA(2);
x2=xx-BB(1);
y2=yy-BB(2);

r1=sqrt(x1.^2+y1.^2);
r2=sqrt(x2.^2+y2.^2);
zz=sin(20*r1)./r1+sin(20*r2)./r2;

pcolor(xx,yy,zz);shading interp
axx=axis;
   gc=gray;
 %  cm=gc(:,1);
 %  colormap([0*cm cm cm])
drawnow



