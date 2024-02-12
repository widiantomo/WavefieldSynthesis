set(handles.inffo,'String','[Mixing down signal...(please wait)]')
drawnow
%path = get(handles.checkbox4, 'UserData');

% otomasi pembuatan file output
%cd('C:\MATLAB71\work\WaFS\GUIfigure\Dry Source\Speech');
cd('C:\MATLAB71\work\WaFS\GUIfigure\Dry Source\Speech');

filewav = 'AL.wav';

cd(path);
%get source position
sr = get(gca,'UserData')   % Source position [x y z] (m)
sr = [4 3.73;6 3.73;3 5.47;7 5.47;5 4;5 6;7.07 9.73;2.93 9.73; -21.79 100; 31.79 100]

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
r = (get(gcf,'UserData')) % Receiver position [x y z] (m)
r=r';

for gg=1:size(sr,1);
s(gg,:) = [sr(gg,:) 1.8]; 
end
s=s';

fs = 44100; % Frequency sampel
%baca file dry source signal  
%filen = get(handles.SourceDir,'UserData') ------
%lll=size(filen,1); ----------

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

%sigle file
y = wavread('AL.wav');


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
if num2str(get(handles.Jumlah,'String')) == 2
    [file,path] = uiputfile('stereo.wave','Save file name');
    wavwrite(sigout,FS,file);
else
[file,path] = uiputfile('[250]5m[000 000].mat','Save file name');    
save(file,'sigout')
end
set(handles.pushbutton4,'Enable','on');
set(handles.inffo,'String','')

%  Written by Kevin D. Donohue (donohue@engr.uky.edu) July 2005
