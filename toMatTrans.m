%code dibawah ini digunakan sebagai pembaca data
disp('Reading input file!')

[ndata, headertext] = xlsread('raw.xls');
[headdeb,headmon]=size(headertext);
[xdata,ydata]=size(ndata);

%kolom debitur
kreditur=(headertext(1:headdeb));

%bersihkan entrance exit dibawah
kreditur(1)=[];
kreditur(268:271)=[];%no. kreditur BERSIH!!!!

%baris penanggalan
bulan=headertext(1,2:headmon);%bulan bersih!!!!!

%siap pakai
kreditur;
bulan;

tempd=zeros(1,1);

for i=1:xdata
    for j=1:ydata
        tempd=ndata(i,j);
        if tempd>0 
            ndata(i,j)=ndata(i,j);
        else
            ndata(i,j)=0;
        end
    end
end

%%%%%%%%bersihin data dari perhitungan ga jelas?%%%%%%%%%%
tempkuning=ndata(:,ydata); 

%bilangan satu yg ga jelas darimana asalnya?
ndata(:,ydata)=[]; 

%bersihkan bilangan 1 itu dari data.. weks
%hapus entr and exit from xls file

%%%%%
tempexit=ndata(xdata,:);
tempentrance=ndata((xdata-1),:);
%%%%%
ndata((xdata-3:xdata),:)=[];%(data raw bersih!!!)

save temp ndata kreditur bulan
clear all
load temp
%
[xdata,ydata]=size(ndata);%data bersih!!!

% buat data pembanding 
x = [1 2 3 4 5];
y = [1 2 3 4 5];

for f=1:5
    for r=1:5
        selisih(f,r)=x(r)-x(f);
    end
end
clear x y;
trans = zeros(5,5);

for c=2:1:(ydata)
    for b=1:xdata
        diff = ndata(b,c)-ndata(b,c-1);
        % selisih | data sekarang | data sebelumnya
        if (diff == 0) & (ndata(b,c)==1) & (ndata(b,c-1)==1)
            trans(1,1)=trans(1,1)+1;
        elseif (diff == 1) & (ndata(b,c)==2) & (ndata(b,c-1)==1)
        trans(1,2)=trans(1,2)+1;
        elseif (diff == 2) & (ndata(b,c)==3) & (ndata(b,c-1)==1)
        trans(1,3)=trans(1,3)+1;
        elseif (diff == 3) & (ndata(b,c)==4) & (ndata(b,c-1)==1)
        trans(1,4)=trans(1,4)+1;
        elseif (diff == 4) & (ndata(b,c)==5) & (ndata(b,c-1)==1)
        trans(1,5)=trans(1,5)+1;
        elseif (diff == -1) & (ndata(b,c)==1) & (ndata(b,c-1)==2)
        trans(2,1)=trans(2,1)+1;
        elseif (diff == 0) & (ndata(b,c)==2) & (ndata(b,c-1)==2)
        trans(2,2)=trans(2,2)+1;
        elseif (diff == 1) & (ndata(b,c)==3) & (ndata(b,c-1)==2)
        trans(2,3)=trans(2,3)+1;
        elseif (diff == 2) & (ndata(b,c)==4) & (ndata(b,c-1)==2)
        trans(2,4)=trans(2,4)+1;
        elseif (diff == 3) & (ndata(b,c)==5) & (ndata(b,c-1)==2)
        trans(2,5)=trans(2,5)+1;
        elseif (diff == -2) & (ndata(b,c)==1) & (ndata(b,c-1)==3)
        trans(3,1)=trans(3,1)+1;
        elseif (diff == -1) & (ndata(b,c)==2) & (ndata(b,c-1)==3)
        trans(3,2)=trans(3,2)+1;
        elseif (diff == 0) & (ndata(b,c)==3) & (ndata(b,c-1)==3)
        trans(3,3)=trans(3,3)+1;
        elseif (diff == 1) & (ndata(b,c)==4) & (ndata(b,c-1)==3)
        trans(3,4)=trans(3,4)+1;
        elseif (diff == 2) & (ndata(b,c)==5) & (ndata(b,c-1)==3)
        trans(3,5)=trans(3,5)+1;
        elseif (diff == -3) & (ndata(b,c)==1) & (ndata(b,c-1)==4)
        trans(4,1)=trans(4,1)+1;
        elseif (diff == -2) & (ndata(b,c)==2) & (ndata(b,c-1)==4)
        trans(4,2)=trans(4,2)+1;
        elseif (diff == -1) & (ndata(b,c)==3) & (ndata(b,c-1)==4)
        trans(4,3)=trans(4,3)+1;
        elseif (diff == 0) & (ndata(b,c)==4) & (ndata(b,c-1)==4)
        trans(4,4)=trans(4,4)+1;
        elseif (diff == 1) & (ndata(b,c)==5) & (ndata(b,c-1)==4)
        trans(4,5)=trans(4,5)+1;
        elseif (diff == -4) & (ndata(b,c)==1) & (ndata(b,c-1)==5)
        trans(5,1)=trans(5,1)+1;
        elseif (diff == -3) & (ndata(b,c)==2) & (ndata(b,c-1)==5)
        trans(5,2)=trans(5,2)+1;
        elseif (diff == -2) & (ndata(b,c)==3) & (ndata(b,c-1)==5)
        trans(5,3)=trans(5,3)+1;
        elseif (diff == -1) & (ndata(b,c)==4) & (ndata(b,c-1)==5)
        trans(5,4)=trans(5,4)+1;
        elseif (diff == 0) & (ndata(b,c)==5) & (ndata(b,c-1)==5)
        trans(5,5)=trans(5,5)+1;
        else 
            
        end
        end
    transisi(:,:,c)=trans(:,:);
end

transisi



