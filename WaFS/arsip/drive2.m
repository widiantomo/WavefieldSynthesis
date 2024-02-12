function [A,f,t]=drive()

%program menghitung jarak dan delay antara sumber notional dan masing-masing
%loudspeaker array
%geometri ruang virtual
%driving function untuk loudspeaker
px=1000;            % 10 meter
py=1000;

ImS = zeros(py,px); %image daerah virtual

%Lokasi pendengar (dalam meter)
text='Lokasi pendengar (dlm m)'
pix = 350;
piy = 500;

pixm = pix/100
piym = piy/100

%frekuensi sumber
frek = 500 * (pi/180); 

%hertz
c = 344;    %kecepatan suara

%scaling faktor (daerah simulasi dalam cm)
scf = 100;

%lokasi sumber titik 
x1n = 900;
y1n = 400;
%x2n = 700;
%y2n = 450;
%x3n = 700;
%y3n = 550;

%letakan pada grid map
ImS(x1n,y1n)=1;
%ImS(x2n,y2n)=1;
%ImS(x3n,y3n)=1;

[virX,virY] = find(ImS)

%sumber yang didefine diletakan pada default
text='Lokasi virtual source (m)'
virX = virX/100%?
virY = virY/100

jumlah_sumber = size(virX,1)

%konfigurasi 
jumlah_loudspeaker = 6
deltax = 0.2; %20 cm

%rutine pembuatan loudspeaker array pada image
%Lokasi tengah speaker
Xref = px/2;
Yref = 500;

%fungsi pembuatan lokasi loudspeaker array
%kekanan
for j=1:1:(jumlah_loudspeaker/2)
    if j==1;
        Yre = Yref + j*((deltax*scf/2));
    else
        Yre = Yref + (j-0.5)*(deltax*scf);
    end
    ix(j)=Xref;
    iy(j)=Yre;
    ImS(Xref,Yre)=1;
end
iy=fliplr(iy);

%kekiri
for j=1:1:(jumlah_loudspeaker/2)
    if j==1
        Yre = Yref - j*((deltax*scf/2));
    else
        Yre = Yref - (j-0.5)*(deltax*scf);
    end
    ix((jumlah_loudspeaker/2)+j)=Xref;
    iy((jumlah_loudspeaker/2)+j)=Yre;
    ImS(Xref,Yre)=1;
end

text='Lokasi komponen loudspeaker(dlm m)'
ix=ix/100;
x_tem = ix;
iy=iy/100;
y_tem = iy;
ix= fliplr(y_tem)
iy= x_tem

%selesai routine pembuatan loudspeaker array

%Ubah meter ke satuan piksel
%virX=round(xn*scf);
%virY=round(yn*scf);

%hitung vektor resultan sumber virtual dengan tiap loudspeaker
n=1;

%bilangan gelombang
k = (pi*frek)/c;

%kuadrat jk -> 3 dB roll off
Dm = sqrt((i*k)/(2*pi));
magDm = abs(Dm);
angleDm = angle(Dm);

%Jarak notional speaker ke pendengar
text='Panjang antara sumber virtual dengan pendengar';
rp = (virX-pix);
rpm = rp/100;

%jarak array loudspeaker ke pendengar
ra = (Yref-pix);
rap = ra/100;

%perhitungan amplitude weight (jarak array-pendengar)dibagi(jarak
%sumber-pendengar
Em = rap/rpm;

ImS(pix,piy)=1;

%gambarkan tiap-tiap posisi (loudspeaker, pendengar, sumber)
imagesc(ImS);

%single virtual source (point source)
for m=1:1:jumlah_sumber
while n<=jumlah_loudspeaker
    %Hitung jarak antara notional source dengan tiap loudspeaker
    r(m,n)=sqrt(((virY(m)-(ix(n)))*(virY(m)-(ix(n))))+(((virX(m)-(iy(n)))*(virX(m)-(iy(n)))))); %rev
        
    delx=(virX(m)-(ix(n)));
    dely=(virY(m)-(iy(n)));
    teta(n)=atan(delx/dely);  %sudut antara notional speaker dengan loudspeaker ke-n

    Bm(m,n)=cos(teta(n));
    
    teta(m,n)=abs(rad2deg(teta(n)));
    
    %r(n)=r(n)/100;%ke meter
    Amp(m,n)=(r(m,n));%amplitudo factor
    a=cos(k*r(m,n));
    b=-1*(sin(k*r(m,n)));
    Am(m,n)=complex(a,b);%phasa delay
    
    %magnitude
    magR(m,n)=abs(Am(m,n));
    %phasa
    angleR(m,n)=angle(Am(m,n));    
        
    %ff(n)=abs(delay(n));
    n=n+1;
end
end 

%angleR;
for n=1:1:jumlah_loudspeaker
Cm(n)=(1/Amp(n));
AmpF(n)=magR(n)*Cm(n);
end

for n=1:1:jumlah_loudspeaker
fctrM(n)= AmpF(n)*magDm;
AnglM(n)= angleR(n)+angleDm;
Qe(n)=Bm(n)*Em*fctrM(n);
Qphase(n)=AnglM(n); 
end

text='jarak antara tiap loudspeaker ke sumber virtual (m)'
r
text='filter attenuation'
Qe
text='fasa delay (m)'
angleR

text='waktu propagasi (s)'
t=r/c

text='waktu propagasi (s)'
sample_delay = t*44100


