clear

N=1000;
t=linspace(0,1,N);
U=zeros(size(t));

%square impulse
U(1:N/10)=1;

Dt=t(2)-t(1);

%fourier
I=length(U);
Uf=fft(U,I);

freq=1/Dt*(0:0.5*I)/I;

w=2*pi*freq;

co=1.2;
wc=100;

%dispersion relation
k=-1/co*(w.^2-wc^2).^0.5;
k=k';

x=linspace(0,1,100);
Ww=zeros(length(t),length(x));

%calculating response in space
for ii=1:length(freq)
    Ww(ii,:)=Uf(ii)*exp(i*k(ii)*x);
end

%IFT
ww=ifft(Ww);

%plotting
figure
mesh(x,t,real(ww));

nn=length(x);

figure
plot

