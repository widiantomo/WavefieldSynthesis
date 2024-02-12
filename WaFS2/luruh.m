f =500;
w = 2*pi*f;

c = 344;
lamda = c/f
k = ((2*pi)/lamda)
w = 1:0.001:10;
y = 1./w;

plot(w,y);