function varargout = main(varargin)
% main.m
% Rutin pengendali figure wfs
% Mohammad Adib Widiantomo
% 13302025

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @main_OpeningFcn, ...
                       'gui_OutputFcn',  @main_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);

                    if nargin && ischar(varargin{1})
                        gui_State.gui_Callback = str2func(varargin{1});
                    end

                    if nargout
                        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
                    else
                        gui_mainfcn(gui_State, varargin{:});
                    end
    % End initialization code - DO NOT EDIT

% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
    % initialize
    set(gcf,'Pointer','crosshair')
    
    % Choose default command line output for main
    handles.output = hObject;
    
    % Update handles structure
    guidata(hObject, handles);
    pushbutton3_Callback(hObject, eventdata, handles);
    set(handles.grid1,'Value',1);
    set(gca,'XGrid','on','YGrid','on');
    
    % set simulate button
    Jumls = str2double(get(handles.JS,'String'));
    if Jumls > 1
    set(handles.Simulate,'Enable','off');
        else
    set(handles.Simulate,'Enable','on');
    end
    set(handles.StringPop,'Enable','off');
    set(handles.Sum_wave,'Enable','off');

% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% -----------------------------------------------------------------------%
% --- Executes on button press in Simulate.------------------------------%
% -----------------------------------------------------------------------%
% --- Wavefield simulation ----------------------------------------------%
% -----------------------------------------------------------------------%

function Simulate_Callback(hObject, eventdata, handles)
    % wavefield axes
    % get source position
    cd('c:\matlab71\work\WaFS\GUIfigure');
    set(handles.inffo,'String','[Rendering wavefield model prediction...(please wait)]')

    %if hObject == handles.Simulate
    %    evendata = 1;
    %else
    %    evendata = get(handles.StringPop,'Value');
    %end

%data_file=dir(fullfile(matlabroot,'work/tes/*.mat'));
%fileallr = [num2str(evendata) '.mat'];

axes(handles.axes1);
sri = get(gca,'UserData');   % Source position [x y z] (m)
if length(sri)==0
    return
end

%frekuensi
f = str2num(get(handles.Frek,'String'));   
%kecepatan suara
c = str2num(get(handles.kecSuara,'String'));   
% jumlah sumber virtual
jsv = str2num(get(handles.JS,'String'));   

drawnow
for ty=1:jsv
    evendata = ty;
    sr = sri(evendata,:);

   %get loudspeaker position
    r = get(gcf,'UserData');  % Receiver position [x y z] (m)
    r(:,3) = [];

    Xt = str2double(get(handles.Panjangr,'String'));
    minuu = Xt/2;

    ttt=1:1:size(r,1);
    vt(ttt,1) = sr(1)-r(ttt,1);
    vt(ttt,2) = sr(2)-r(ttt,2);
    gg = sqrt((vt(:,1).*vt(:,1))+(vt(:,2).*vt(:,2)));

    % check apakah focused source?
    if r(1,2)>sr(2)
        focused_s = 1;
    else
        focused_s = 0;
    end

    % menghitung wave vektor tiap jarak
    z=min(gg);
    ttt=1:size(r,1);
    ph(ttt) = gg(ttt)-z;
    Phasedw(ttt) = ph(ttt)*2*f/c;   % phase delay for every source receiver distance
    % ubah kordinat receiver pada ruangan ke kordinat ruang reproduksi
    r(ttt,1)=r(ttt,1)-minuu;
    r(:,2)=0;

    if focused_s == 1
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

        for eee= 1:1:h 
            for kkk= 1:1:uy
                if pointers(eee)==invrsnum(kkk,1)
                    Phasedw(eee)=indd(kkk,1);    
                end
            end
        end
    else
end

axes(handles.axes2);

% panjang dan lebar ruangan
p=6;
l=4;
lamda=c/f;
k = (2*pi)/lamda;

% phasedw=phasedw*2;
% Calculate mesh grid
uu=-l:0.05:l;
vv=-p:0.05:0;
[xx,yy]=meshgrid(uu,vv);

% initialize matrix zz by calculating first speaker
x1=xx-r(1,1);
y1=yy-r(1,2);
r1=sqrt((x1.^2)+(y1.^2));

zzz=cos((k*r1)+Phasedw(1));

for ttt=2:size(r,1)
x1=xx-r(ttt,1);
y1=yy-r(ttt,2);
r1=sqrt((x1.^2)+(y1.^2));
zzz =(cos((k*r1)+Phasedw(ttt))+zzz);
end

if evendata == 1
    resultss = zzz;
else
    resultss = (resultss + zzz);
end

mmmm = num2str(evendata);   
save(mmmm,'zzz');   
end

save('resultan','resultss');   

pcolor(resultss);shading interp;
axx=axis;
   gc=gray;
   cm=gc(:,1);
   colormap([0*cm cm cm])
   drawnow
   
    set(handles.StringPop,'Enable','on');
    set(handles.Sum_wave,'Enable','on');
set(handles.inffo,'String','')

    
function Panjangr_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Panjangr as text
%        str2double(get(hObject,'String')) returns contents of Panjangr as a double
handles.panjangr=str2double(get(hObject,'String'));
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function Panjangr_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function Lebarr_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Lebarr as text
%        str2double(get(hObject,'String')) returns contents of Lebarr as a double
handles.lebarr=str2double(get(hObject,'String'));
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function Lebarr_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of radiobutton2

       
function Jumlah_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Jumlah as text
%        str2double(get(hObject,'String')) returns contents of Jumlah as a double


% --- Executes during object creation, after setting all properties.
function Jumlah_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function dl_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of dl as text
%        str2double(get(hObject,'String')) returns contents of dl as a double
dl=str2double(get(hObject,'String'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.

function dl_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function Frek_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Frek as text
%        str2double(get(hObject,'String')) returns contents of Frek as a double
handles.frekuensi=str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Frek_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function SourceDir_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of SourceDir as text
%        str2double(get(hObject,'String')) returns contents of SourceDir as a double


% --- Executes during object creation, after setting all properties.
function SourceDir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SourceDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function wavfile_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of wavfile as text
%        str2double(get(hObject,'String')) returns contents of wavfile as a double


% --- Executes during object creation, after setting all properties.
function wavfile_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes during object creation, after setting all properties.
function JS_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% -----------------------------------------------------------------------%
% --- Executes on button press in Initilize.-----------------------------%
% -----------------------------------------------------------------------%
% --- Room Model Setup --------------------------------------------------%
% -----------------------------------------------------------------------%

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
axes(handles.axes2);
cla;
axes(handles.axes1);
cla;

ptList=[];
set(gca,'UserData',ptList);

% now get the parameter
Xt = str2double(get(handles.Panjangr,'String'));
Yt = str2double(get(handles.Lebarr,'String'));
set(handles.axes1,'XLim',[0 Xt]);
set(handles.axes1,'YLim',[0 Yt]);

Xtick=(0:1:Xt)';
Ytick=(0:1:Yt)';
set(handles.axes1,'XTick',Xtick);
set(handles.axes1,'YTick',Ytick);

if Yt>20
set(handles.axes1,'YTickMode','auto');
end

%set speaker array
JumLS = str2double(get(handles.Jumlah,'String'));
Spasi = str2double(get(handles.dl,'String'));

% set speaker array location
xcent_array = str2double(get(handles.x_arrPos,'String'));
ycent_array = str2double(get(handles.y_arrPos,'String'));

% set listener position (head position)
poslist_x = xcent_array;
poslist_y = ycent_array - 1.25;

% jumlah speaker ganjil ato genap
remind = mod(JumLS,2);
side = floor(JumLS/2);

% to built line prespective annotations off the listener
% calculate...claculate

if remind == 1
b = 1.25;
a = (xcent_array) - (xcent_array - side*Spasi);
d = xcent_array;
hhhy = atan(a/b);
c1 = d / tan(hhhy);
d = Xt - xcent_array;
c2 = d / tan(hhhy);
else 
b = 1.25;
startki = (xcent_array-(Spasi/2));
a = (xcent_array) - (startki - ((side-1)*Spasi));
d = xcent_array;
hhhy = atan(a/b);
c1 = d / tan(hhhy);
d = Xt - xcent_array;
c2 = d / tan(hhhy);
end

line([poslist_x 0],[poslist_y (poslist_y + c1)], ...
           'LineStyle','--', ...
           'Marker','.', ...
           'Color','r', ...
           'MarkerSize',15, ...
           'EraseMode','none');

line([poslist_x Xt],[poslist_y (poslist_y + c2)], ...
           'LineStyle','--', ...
           'Marker','.', ...
           'Color','r', ...
           'MarkerSize',15, ...
           'EraseMode','none');       
           
%Built the array boy!!!
%1. View the centre of the room
cent = xcent_array;

LSxpost = zeros(JumLS,1);
LSypost = ones(JumLS,1) * ycent_array;
LSzpost = ones(JumLS,1)*1.8;

if remind == 1
% make the speaker side by side
centre = ceil(JumLS/2);
%centre of the speaker
LSxpost(centre,1) = cent;

for kk=1:side
    %kanan
    LSxpost(centre+kk)= kk*Spasi + cent;
    %kiri
    LSxpost(centre-kk) = cent - kk*Spasi;
end    
for kk=1:JumLS
line(LSxpost(kk,1),LSypost(kk,1), ...
           'LineStyle','none', ...
           'Marker','.', ...
           'Color','b', ...
           'MarkerSize',15, ...
           'EraseMode','none');
end
else 
centre = JumLS/2;
kan=centre+1;
kiri=side-1;
startka = (cent+(Spasi/2));
startki = (cent-(Spasi/2));
for kk=0:1:kiri
    %kanan
LSxpost(kan+kk) = startka + kk*Spasi;
LSxpost(centre-kk) = startki - kk*Spasi;
end    
for kk=1:JumLS
line(LSxpost(kk,1),LSypost(kk,1), ...
           'LineStyle','none', ...
           'Marker','.', ...
           'Color','b', ...
           'MarkerSize',15, ...
           'EraseMode','none');
end
end    

% Draw listeners head annotation
line(poslist_x,poslist_y, ...
           'LineStyle','none', ...
           'Marker','.', ...
           'Color','k', ...
           'MarkerSize',24, ...
           'EraseMode','none');

rList = [LSxpost(:,1) LSypost(:,1) LSzpost(:,1)];
set(gcf,'UserData',rList);


% --- Executes on button press in reverrb.
function reverrb_Callback(hObject, eventdata, handles)
% hObject    handle to reverrb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of reverrb


% -----------------------------------------------------------------------%
% --- Executes on button press in Calculate -----------------------------%
% -----------------------------------------------------------------------%
% --- Calculate the wave multichannel output ----------------------------%
% -----------------------------------------------------------------------%

% --- Executes on button press in calculate wave output.
function pushbutton4_Callback(hObject, eventdata, handles)
% Untuk mengontrol kalkulasi simulasi ruangan terhadap microphone array?
set(handles.inffo,'String','[Mixing down signal...(please wait)]')
drawnow
cd('c:\matlab71\work\WaFS2\Dry source\');
%get source position
sr = get(gca,'UserData');   % Source position [x y z] (m)

if length(sr)==0
    return
end

axes(handles.axes1);
max=0;

%matikan tombol
set(handles.pushbutton4,'Enable','inactive');

%kecepatan suara
sv = str2num(get(handles.kecSuara,'String'));   

%get loudspeaker position
r = (get(gcf,'UserData')); % Receiver position [x y z] (m)
r=r';

for gg=1:size(sr,1);
s(gg,:) = [sr(gg,:) 1.8]; 
end
s=s';

fs = 44100; % Frequency sampel
%baca file dry source signal
filen = get(handles.SourceDir,'UserData')
lll=size(filen,1);

% baca tiap file
for bub=1:lll
wavuf = char(filen(bub,:));
[y,Fs,bits] = wavread(wavuf);
lengthfile(bub) = length(y);
[xx,yy]=size(y);
if yy==2
   y(:,2)=[];
else
end
end

max = 0;
for uiu=1:length(lengthfile)
if max < lengthfile(uiu)
    max = lengthfile(uiu);
else
    max = max;
end
end

sigarray = zeros(max,lll);
size(sigarray);

for bub=1:lll
wavuf = char(filen(bub,:));
[y,Fs,bits] = wavread(wavuf);
[xx,yy]=size(y);
if yy==2
   y(:,2)=[];
else
end
for tttt=1:length(y)
sigarray(tttt,bub) = sigarray(tttt,bub)+y(tttt);
end
end
size(sigarray);

% with reverb
if (get(handles.reverrb,'Value') == get(handles.reverrb,'Max'))
    rvrb = 1;
else
    rvrb = 0;
end

[sigout, tax] = simarraysig(sigarray, fs, s, r, sv, rvrb);
save signalmulti sigout
set(handles.pushbutton4,'Enable','on');
set(handles.inffo,'String','')
%  Written by Kevin D. Donohue (donohue@engr.uky.edu) July 2005


% --- Executes on button press in InfoPenggunaan.
function InfoPenggunaan_Callback(hObject, eventdata, handles)
    ttlStr='Program Wavefield Synthesis - Model Based Rendering ';
    hlpStr={' '};
    helpwin(hlpStr,ttlStr);   

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
sigout=load(signalmulti);
[x,y] = size(sigout);
waveblast = zeros(x,10);
waveblast(:,(1:y)) = waveblast(:,(1:y))+sigout;
pa_wavplay(waveblast, 44100, 0, 'asio');    %blast it of to the speaker array


function sudutPlane_Callback(hObject, eventdata, handles)
% hObject    handle to sudutPlane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sudutPlane as text
%        str2double(get(hObject,'String')) returns contents of sudutPlane as a double


% --- Executes during object creation, after setting all properties.
function sudutPlane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sudutPlane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
     axes(handles.axes1);
     hhhh=[];
     numm = 0;
     figNumber=gcf;
     txtHndl=get(figNumber,'UserData');
     ptList=get(gca,'UserData');
     val = str2double(get(handles.JS,'String'));
     
     if val>5
         disp('Jumlah sumber virtual maksimum = 5')
         set(handles.JS,'String',5);
     else
     end
     
     if size(ptList,1)<val
        currPt=get(gca,'CurrentPoint');
        currPt=currPt(1,1:2);
        ptList=[ptList; currPt];
        set(gca,'UserData',ptList);
        
        hhhh = get(handles.StringPop,'UserData');
        numm=num2str(size(ptList,1));
        hhhh = [hhhh;numm];
        set(handles.StringPop,'String',hhhh);
        set(handles.StringPop,'UserData',hhhh);
        
        FileName = get(handles.SourceDir,'UserData');
        [Filename,PathName] = uigetfile('*.wav','Select wave to be played');
        text((currPt(1)+0.20),(currPt(2)+0.25),[numm,':',Filename]);
        FileName = [FileName;Filename];
        set(handles.SourceDir,'UserData',FileName);
         
        line(currPt(1),currPt(2), ...
           'LineStyle','none', ...
           'Marker','.', ...
           'Color','r', ...
           'MarkerSize',25, ...
           'EraseMode','none');
     %if ~normal click
     else
     end
        

% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2);
cla;
axes(handles.axes1);
cla;
ptList=[];
hhhh=['x'];
set(gca,'UserData',ptList);
set(handles.StringPop,'String',hhhh);
set(handles.StringPop,'UserData',ptList);
pushbutton3_Callback(hObject, eventdata, handles);
        

function kecSuara_Callback(hObject, eventdata, handles)
% hObject    handle to kecSuara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kecSuara as text
%        str2double(get(hObject,'String')) returns contents of kecSuara as a double


% --- Executes during object creation, after setting all properties.
function kecSuara_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kecSuara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function JS_Callback(hObject, eventdata, handles)
% hObject    handle to JS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of JS as text
%        str2double(get(hObject,'String')) returns contents of JS as a double


% --- Executes on button press in grid1.
function grid1_Callback(hObject, eventdata, handles)
% hObject    handle to grid1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of grid1
if (get(hObject,'Value') == get(hObject,'Max'))
    set(gca,'XGrid','on','YGrid','on');
else
    set(gca,'XGrid','off','YGrid','off');
end

% -----------------------------------------------------------------------%
% --- Executes on button press in RIR -----------------------------------%
% -----------------------------------------------------------------------%
% --- Room Impulse response simulation ----------------------------------%
% -----------------------------------------------------------------------%


% --- Executes on button press in Impuls_button.
function Impuls_button_Callback(hObject, eventdata, handles)
% hObject    handle to Impuls_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.inffo,'String','[please set room reflection factor]')
load roomref % perlu tindak lanjut berikutnya....
set(handles.inffo,'String','[Calculating impulse response with every source receiver]')

%get source position
sr = get(gca,'UserData');   % Source position [x y z] (m)
if length(sr)==0
    return
end

axes(handles.axes1);
%kecepatan suara
sv = str2num(get(handles.kecSuara,'String'));   
fs = 44100;                 % Sample frequency (samples/s)

%get loudspeaker position
r = (get(gcf,'UserData')); % Receiver position [x y z] (m)

for gg=1:size(sr,1);
s(gg,:) = [sr(gg,:) 1.8]; 
end

% get room dimension
Xt = str2double(get(handles.Panjangr,'String'));
Yt = str2double(get(handles.Lebarr,'String'));
Zt = str2double(get(handles.tinggi,'String'));
L = [Xt Yt Zt];                % Room dimensions [x y z] (m)

c = 0.4;                    % Reverberation time (s)
n = 4096;                      % Number of samples

for gg=1:size(sr,1)
h = rir_generator(sv, fs, r, s(gg,:), L, c, n);
num=num2str(gg);
filenm=['impuse',num];
save(filenm,'h')
end
set(handles.inffo,'String','')


function tinggi_Callback(hObject, eventdata, handles)
% hObject    handle to tinggi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tinggi as text
%        str2double(get(hObject,'String')) returns contents of tinggi as a double


% --- Executes during object creation, after setting all properties.
function tinggi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tinggi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in StringPop.
function StringPop_Callback(hObject, eventdata, handles)
% hObject    handle to StringPop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(hObject,'Value');
axes(handles.axes2);
%string_list = get(hObject,'String');
%g = str2num(string_list{val}); 
load(num2str(val));
pcolor(zzz);shading interp;
axx=axis;
   gc=gray;
   cm=gc(:,1);
   colormap([0*cm cm cm])
   drawnow


% --- Executes during object creation, after setting all properties.
function StringPop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StringPop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in PureMode.
function PureMode_Callback(hObject, eventdata, handles)
% hObject    handle to PureMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PureMode



% --- Executes on button press in Browse_fileIR.
function Browse_fileIR_Callback(hObject, eventdata, handles)
% hObject    handle to Browse_fileIR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function x_arrPos_Callback(hObject, eventdata, handles)
% hObject    handle to x_arrPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_arrPos as text
%        str2double(get(hObject,'String')) returns contents of x_arrPos as a double


% --- Executes during object creation, after setting all properties.
function x_arrPos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_arrPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function y_arrPos_Callback(hObject, eventdata, handles)
% hObject    handle to y_arrPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_arrPos as text
%        str2double(get(hObject,'String')) returns contents of y_arrPos as a double


% --- Executes during object creation, after setting all properties.
function y_arrPos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_arrPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes on button press in Sum_wave.
function Sum_wave_Callback(hObject, eventdata, handles)
% hObject    handle to Sum_wave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('resultan.mat')
pcolor(resultss);shading interp;
axx=axis;
   gc=gray;
   cm=gc(:,1);
   colormap([0*cm cm cm])
   drawnow



% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
openfig('roomref.fig')

