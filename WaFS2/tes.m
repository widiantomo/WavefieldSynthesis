f=500
lamda = 344/f
k = (2*pi)/lamda;

tt=10;

x=0:0.01:10;
a=sin(k*x)';
b=sin((k*x)-(0.2/lamda))';

plot(x,[a b]);

