function tomo(tekan)

if nargin<1,
  tekan='pertama';
end;

if strcmp(tekan,'pertama')

   figur=figure('Menubar','none',...
		'Name','Easy Tomographic Image Reconstructor',...
		'NumberTitle','off',...
		'Visible','on',...
                'Color',[0.5 0.5 0.5]);
   axes('Position',[.08 .05 .65 .70],'units','normalized')

   % buat kotak tampilan
   h1=uicontrol('style','frame','units','normalized',...
	      'Position',[.03 .80 .45 .18],'BackgroundColor',[0.847058823529412 0.815686274509804 0.784313725490196]);
	
   h2=uicontrol('style','frame','units','normalized',...
	      'Position',[.52 .80 .45 .18],'BackgroundColor',[0.847058823529412 0.815686274509804 0.784313725490196]);
		

  % buat tombol-tombol
  text1=uicontrol('Style','text','Units','normalized',...
	    'Position',[.05 .87 .25 .05],'BackgroundColor',[0.847058823529412 0.815686274509804 0.784313725490196],...
	    'Horiz','left','String','Number of Sensor');

  tombol1=uicontrol('Style','edit','Units','normalized',...
		    'Position',[.25 .88 .15 .05],'BackgroundColor',[1 1 1],...
		    'Horiz','center','String',8);		
       
  uicontrol('Style','text','Units','normalized',...
	    'Position',[.04 .94 .17 .035],'BackgroundColor',[0.847058823529412 0.815686274509804 0.784313725490196],...
	    'Horiz','left','String','Data Configuration');
     
  ff = uicontrol('Style','text','Units','normalized',...
	    'Position',[.76 .71 .15 .05],'BackgroundColor',[0.5 0.5 0.5],...
	    'Horiz','left','String','m/s');
  
       
  text2=uicontrol('Style','text','Units','normalized',...
	    'Position',[.05 .82 .15 .05],'BackgroundColor',[0.847058823529412 0.815686274509804 0.784313725490196],...
	    'Horiz','left','String','Number of Angle');

  tombol2=uicontrol('Style','edit','Units','normalized',...
		    'Position',[.25 .82 .15 .05],'BackgroundColor',[1 1 1],...
		    'Horiz','center','String',8);		

  text3=uicontrol('Style','text','Units','normalized',...
	    'Position',[.54 .87 .25 .05],'BackgroundColor',[0.847058823529412 0.815686274509804 0.784313725490196],...
	    'Horiz','left','String','Interpolation');

  tombol3=uicontrol('Style','edit','Units','normalized',...
		    'Position',[.74 .88 .15 .05],'BackgroundColor',[1 1 1],...
		    'Horiz','center','String',1);		

  uicontrol('Style','text','Units','normalized',...
	    'Position',[.82 .68 .15 .05],'BackgroundColor',[.5 .5 .5],...
	    'Horiz','left','String','Display');

  callbackStr='tomo quickeval';
  
  cmdList=str2mat('surf(abs(md))','contour(md)',...
                  'mesh(abs(md)','pcolor(abs(md)'); 
               
  tombol4=uicontrol('Style','popupmenu','Units','normalized',...
		    'Position',[.82 .63 .15 .05],'BackgroundColor',[1 1 1],...
		    'Horiz','center','String','Mesh|Contour|Surf|pcolor',...
                    'Callback',callbackStr,'UserData',cmdList);		

  uicontrol('Style','text','Units','normalized',...
	    'Position',[.54 .82 .15 .05],'BackgroundColor',[0.847058823529412 0.815686274509804 0.784313725490196],...
	    'Horiz','left','String','Read Data');

  tombol5=uicontrol('Style','popupmenu','Units','normalized',...
		    'Position',[.74 .82 .15 .05],'BackgroundColor',[1 1 1],...
		    'Horiz','center','String','Simulation|Measurement',...
                    'Callback','tomo(''data'')');		
                 
  text9=uicontrol('Style','text','Units','normalized',...
	    'Position',[.82 .43 .15 .05],'BackgroundColor',[0.5 0.5 0.5],...
       'Horiz','left','String','');
    
  tombol9=uicontrol('Style','text','Units','normalized',...
	    'Position',[.82 .38 .15 .05],'BackgroundColor',[0.5 0.5 0.5],...
       'Horiz','left','String','');
   
  tombol6=uicontrol('Style','pushbutton','Units','normalized',...
		    'Position',[.82 .27 .15 .08],...
		    'String','Execute','Callback','tomo(''execute'')');		

  tombol7=uicontrol('Style','pushbutton','Units','normalized',...
		    'Position',[.82 .16 .15 .08],...
		    'String','Info','Callback','tomo(''info'')');		

  tombol8=uicontrol('Style','pushbutton','Units','normalized',...
		    'Position',[.82 .05 .15 .08],...
		    'String','Exit','Callback','close(gcf);clear all');		

  

% mengatur akses tombol
  aksestombol=[text1 tombol1 text2 tombol2 text3 tombol3 tombol4 tombol5 tombol6 tombol7 tombol8 text9 tombol9 ff];
            
  set(figur,'UserData',aksestombol); 
  AksesTombol=get(gcf,'UserData'); 
  %set(AksesTombol(5:6),'Enable','off');
  set(AksesTombol(12:13),'HandleVisibility','on');
  %set(ff,'String','');
  set(AksesTombol(14),'String','');
  drawnow;
 
elseif strcmp(tekan,'data')
  AksesTombol=get(gcf,'UserData'); 
  if get(AksesTombol(8),'Value')==2,
    set(AksesTombol(1),'String','File Name');
    set(AksesTombol(2),'String','Insert file');
    set(AksesTombol(3:4),'Enable','off');
    set(AksesTombol(5:6),'Enable','on');
    drawnow;
 else
    set(AksesTombol(1),'String','No. of Sensor');
    set(AksesTombol(2),'String','8');
    set(AksesTombol(5:6),'Enable','on');
    set(AksesTombol(3:4),'Enable','on');
    drawnow;
 end; 

elseif strcmp(tekan,'info'),
    ttlStr='Program Tomography ';
    hlpStr={'                                                                '  
         ' Tomografi merupakan suatu teknik rekonstruksi citra            '  
         ' suatu obyek(benda) berdasarkan proyeksi-proyeksinya.           '  
         ' Proyeksi diperoleh dari data pengukuran atau data simulasi.    '  
         '                                                                '  
         ' Dalam program tomo.m ini, data simulasi disebut sebagai data   '  
         ' buatan sedangkan data pengukuran disebut data asli.            '  
         ' Hasil rekonstruksi dapat ditampilkan dalam empat bentuk pola   '  
         ' sesuai dengan keperluan. Empat bentuk pola itu adalah surf,    '  
         ' contour, pcolor, dan mesh.                                     '  
         '                                                                '  
         ' Dalam data buatan diperlukan tiga data masukan yaitu jumlah    '
         ' sensor, jumlah sudut, dan jumlah interpolasi. Jumlah sensor    '
         ' adalah banyaknya pasangan transduser yang digunakan.           '  
         ' Jumlah sudut adalah banyaknya posisi pengambilan proyeksi      '  
         ' (banyaknya pemutaran sensor). Sedangkan jumlah interpolasi     '  
         ' adalah berapa kali kita akan melakukan interpolasi terhadap    '
         ' data proyeksi. Bila tidak dibutuhkan interpolasi maka jumlah   '
         ' jumlah proyeksi = 1. Sedangkan pada data asli maka diperlukan  '
         ' dua data masukan yaitu nama file (harus dalam bentuk .dat)     '
         ' dan banyaknya jumlah interpolasi                               '};
    helpwin(hlpStr,ttlStr);   

elseif strcmp(tekan,'execute')
  clear global 
  prj4;
  AksesTombol=get(gcf,'UserData'); 
  if get(AksesTombol(8),'Value')==2,
    set(AksesTombol(1),'String','File Name');
    set(AksesTombol(2),'String','   ');
    set(AksesTombol(3:4),'Enable','off');
    set(AksesTombol(5:6),'Enable','on');
    drawnow;
  else
    set(AksesTombol(1),'String','No. of Sensor');
    set(AksesTombol(2),'String','8');
    set(AksesTombol(5:6),'Enable','off');
    set(AksesTombol(3:4),'Enable','on');
    drawnow;
  end
  return
  
elseif strcmp(tekan,'quickeval')
   
global md ;
[x,y] = meshgrid(-1:2/(size(md,2)-1):1,-1:2/(size(md,2)-1):1);
AksesTombol=get(gcf,'UserData');

%======
if get(AksesTombol(7),'Value')==1,
   mesh(x,y,abs(md));
   zlabel('[m/s]');
   set(AksesTombol(14),'String','');
  
else  
   if get(AksesTombol(7),'Value')==2,
      contour(x,y,abs(md));
      set(AksesTombol(14),'String','m/s');
      colorbar
      colormap('jet');
      drawnow;
   else 
      if get(AksesTombol(7),'Value')==3,
         surf(x,y,abs(md)); 
         set(AksesTombol(14),'String','m/s');
         colorbar
   	   colormap('jet');
         drawnow;
      else
         pcolor(x,y,abs(md));         
         set(AksesTombol(14),'String','m/s');
         shading('interp');
         colorbar
	      colormap('jet');
         drawnow;
      end
   end
end
x
y
abs(md)

end;  % akhir program ...

function prj4

  clear global 
  AksesTombol=get(gcf,'UserData');
  mulai = cputime;
  nn=1/eval((get(AksesTombol(6),'String')));     % jumlah interpolasi

%----------------------------------------------------------------------------
%  MENGGUNAKAN DATA BUATAN
%----------------------------------------------------------------------------
  if get(AksesTombol(8),'Value')==1,                % menggunakan data buatan
  % variabel
  Jmlsensor =eval(get(AksesTombol(2),'String')); %--------- jumlah sensor yang digunakan
  ts = 2/(Jmlsensor-1);                          %------- interval sampling
  SdtScan =eval(get(AksesTombol(4),'String'));   %------------ banyaknya posisi proyeksi
  k=-1:2/(Jmlsensor-1):1; 
  
  mx=zeros(Jmlsensor,Jmlsensor);

  sensor=get(AksesTombol(2),'String');


%----------------------------------------------------------------------------
%  MENGGUNAKAN DATA ASLI/FILE
%----------------------------------------------------------------------------
  else													    % dengan data asli
    file=[get(AksesTombol(2),'String') '.dat'];              
    if ~exist(file),
       error('File tidak ada atau Semua file harus berextension .dat');
       return;
   end
   load (file) %             dipakai untuk mengakses file dalam format double
   agf=eval(get(AksesTombol(2),'String'));

   for i = 1:1:size(agf,1)
        a1=1:1:size(agf,2);
        d1=1:nn:size(agf,2);
        pa(i,:)=(interp1(a1,agf(i,:),d1,'spline'));
   end

   Jmlsensor=size(pa,2);
   ts = 2/(size(pa,2)-1);
   mx = zeros(size(pa,2),size(pa,2)); 
   SdtScan=size(pa,1);
   
 end;                                            % akhir pilihan asli / buatan
 set(AksesTombol(3:10),'Enable','off');
 
% ============== MENGHITUNG DATA PROYEKSI (Ptetha(k/(2W)) ===================

%--------Pembuatan filter (lihat file filter1.m)
tss=ts;
k2 = (-1:ts:-ts);  
a2=1:1:size(k2,2);

for je=1:1:size(a2,2)
    if a2(je) == 0
        h2 = 1/(4*tss^2);   
    else
        if a2(je)/2 == a2(je/2)
            h2 = 0;
        else 
            h2 = -1/(a2(je)*pi*tss)^2;
        end
    end
        
    hb(:,je)=h2;
    Hb = fft2(hb); 
 end 
 
 
k1 = (max(k2)+ts:ts:1); %+tss); %*(2.54*4/100); %-tss;  
a1 = 0:1:size(k1,2)-1;

for jf=1:1:size(a1,2)
    if a1(jf) == 0
        h1 = 1/(4*tss^2);   
    else
        if a1(jf)/2 == a1(jf/2)
            h1 = 0;
        else 
            h1 = -1/(a1(jf)*pi*tss)^2;
        end
    end 
        
    ha(:,jf)=h1;
    Ha = fft2(ha);
 end 
 
%---------------------------akhir jf

hc=[hb fliplr(ha)];
k3=[k2 k1];
Hc=fft([hc]);

aa=1:1:size(Hc,2);
cc=hc;
dd=1:nn:size(Hc,2);

%---- selesai filter



mc = mx; 
set(AksesTombol(12),'String','Calculating...');

for Sdt = (0/180)*pi:pi/SdtScan:pi-pi/SdtScan

    Sudut = Sdt*180/pi;
    set(AksesTombol(13),'String',Sudut);
    drawnow;
    if get(AksesTombol(8),'Value')==1,   % menggunakan data buatan
       for je=1:1:size(k,2)
         p=(pi)^(1/2)*gamma(2)/gamma(2.5)*(1-k(je)^2)^(3/2);   
         pz(:,je) = p;
       end %--------------------------- akhir je
    else
       pz=pa(1+Sdt*SdtScan/(pi),:);
      
    end
    Pa = fft(pz); %----transf. Fourier Proyeksi    
    
    Qo = Pa.*Hc;
    Qr = ts*ifft(Qo);
    for ss=1:1:size(Qr,2)
        if ss==1
            Q(1,ss)=Qr(1,size(Qr,2));
        else
            Q(1,ss)=Qr(1,ss-1);
        end
    end

%======================================================================
%       BAGIAN PROYEKSI-BALIK TERFILTER (FILTERED-BACKPROJECTION)     =
%======================================================================
    
    mb = mx;
    ko =  (-(Jmlsensor-1)/2:1:(Jmlsensor-1)/2);
    ma = mx;
    for j = 1:1:size(ko,2)
        ka = ko(j);
        xo =  -(Jmlsensor-1)/2:0.05:(Jmlsensor-1)/2;
        for jj = 1:1:size(xo,2)

            m = mx;

            if Sdt == pi
                Sdt = 0;
            end

	    a = sin(Sdt);
            if a == 0
                y1 = (xo(jj));
                x1 = -ka;
            else 
                x1 = -xo(jj);
                y1 = ((ka-xo(jj)*cos(Sdt))/a);
	    end
	    x = y1+Jmlsensor/2+0.5;
	    y = -x1+Jmlsensor/2+0.5;
 
            if x>size(Q,2) | y>size(Q,2)
	        x = 1;
                y = 1;
                ma(x,y) = 0;        
	    else
                if x<1 | y<1
	            x = 1;
                    y = 1;
                    ma(x,y) = 0;        
                else
                    ma(x,y) = Q(j)  ;   

                end
                
            end
            xx(jj,j)=x;
            yy(jj,j)=y;

        end %----- akhir jj

end 
%================ AKHIR PROYEKSI BALIK-TERFILTER ===================

    mc = ma + mc;
 end 
 %=========================================== akhir looping Sudut
if get(AksesTombol(8),'Value')==1,
   set(AksesTombol(1:10),'Enable','on');
   set(AksesTombol(1),'String','No. of Sensor');
   set(AksesTombol(12),'String','');
   set(AksesTombol(13),'String','');
   set(AksesTombol(2),'String',sensor);
else
   set(AksesTombol(7:10),'Enable','on');
   set(AksesTombol(12),'String','');
   set(AksesTombol(13),'String','');
   set(AksesTombol(1),'String','File Name');
end;

global md;
md=pi/SdtScan*mc;

%persiapkan mesh -nolkan
[x,y] = meshgrid(-1:2/(size(md,2)-1):1,-1:2/(size(md,2)-1):1);
d = (size(md,2)/2)^2-(Jmlsensor/6)^2;

for i=1:1:size(md,2)
    x1=i;
    x2=i-(size(md,2)-1)/2-1;
    for j=1:1:size(md,1)
        y1=j;
        y2=j-(size(md,1)-1)/2-1;
        r=x2^2+y2^2;
        if r>=d
            md(x1,y1)=0;
        end
    end
end

selesai=cputime;
runtime=selesai-mulai;
mesh(x,y,abs(md))
xlabel('m');
ylabel('m');
zlabel('m/det');

if get(AksesTombol(7),'Value')==1,
   mesh(x,y,abs(md));
   xlabel('m');
	ylabel('m');
	zlabel('m/det');
else  
   if get(AksesTombol(7),'Value')==2,
      contour(x,y,abs(md));
      colorbar
   else 
      if get(AksesTombol(7),'Value')==3,
         surf(x,y,abs(md));
         colorbar
      else
         pcolor(x,y,abs(md));        
         shading('interp');
	 colorbar
	 colormap('jet');
      end
   end
end

