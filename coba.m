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


[xdata,ydata]=size(ndata);%data bersih!!!
