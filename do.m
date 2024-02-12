t = 0:.2:20;
alpha =.055;
stem(t,exp(-alpha*t).*sin(5*t))