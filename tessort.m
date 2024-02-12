% tes sorting
Phasedw = [0.5 0.2 0 0.2 0.5]   
h = length(Phasedw);

indd = tabulate(Phasedw); % tabulasikan matrix ; ind(:,1) untuk nilai; indd(:,1) untuk jumlah
uy = length(indd);
indd(:,3)=0;
    oio = 1:1:uy;
    pointers = zeros(1,h);
    indd(:,3)=oio';
    %invrsval = (fliplr(indd(:,1)'))';
    invrsnum = (fliplr(indd(:,3)'))';
Phasedwi = zeros(1,h);
    
    %kemudian tentukan lokasi
for rrr= 1:1:h 
for jjj= 1:1:uy
if Phasedw(rrr)== indd(jjj,1)
pointers(rrr)= indd(jjj,3);
end
end
end

%invrsval
for eee= 1:1:h 
for kkk= 1:1:uy
if pointers(eee)==invrsnum(kkk,1)
Phasedwi(eee)=indd(kkk,1);    
end
end
end
Phasedwi
