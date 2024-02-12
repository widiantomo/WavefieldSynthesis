
%kecepatan suara
sv = str2double(get(handles.kecSuara,'String'))   
fs = 44100;                 % Sample frequency (samples/s)

%get loudspeaker position
r = get(gcf,'UserData') % Receiver position [x y z] (m)
   
%get source position
s = get(gca,'UserData')              % Source position [x y z] (m)

% get room dimension
Xt = str2double(get(handles.Panjangr,'String'));
Yt = str2double(get(handles.Lebarr,'String'));
Zt = str2double(get(handles.tinggi,'String'));
L = [Xt Yt Zt]                % Room dimensions [x y z] (m)

c = 0.4;                    % Reverberation time (s)
n = 4096;                   % Number of samples
mtype = 'omnidirectional';  % Type of microphone
order = -1;                 % -1 equals maximum reflection order!
dim = 3;                    % Room dimension
orientation = 0;            % Microphone orientation (rad)
hp_filter = 1;              % Enable high-pass filter

rr=r(1,:);
h = rir_generator(sv, fs, r, s, L, c, n, mtype,order,dim,orientation,hp_filter);

save impulse h




% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
