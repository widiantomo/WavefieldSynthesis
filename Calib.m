function varargout = Calib(varargin)
% CALIB M-file for Calib.fig
%      CALIB, by itself, creates a new CALIB or raises the existing
%      singleton*.
%
%      H = CALIB returns the handle to a new CALIB or the handle to
%      the existing singleton*.
%
%      CALIB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALIB.M with the given input arguments.
%
%      CALIB('Property','Value',...) creates a new CALIB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Calib_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Calib_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Calib

% Last Modified by GUIDE v2.5 05-Jun-2007 11:33:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Calib_OpeningFcn, ...
                   'gui_OutputFcn',  @Calib_OutputFcn, ...
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


% --- Executes just before Calib is made visible.
function Calib_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Calib (see VARARGIN)
handles.t = timer('ExecutionMode','fixedRate', 'Period', 0.1);

% Choose default command line output for Calib
handles.output = hObject;
handles.datas = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Calib wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Calib_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slidekor_Callback(hObject, eventdata, handles)
% hObject    handle to slidekor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.korval,'String',num2str(get(handles.slidekor,'value')));

% --- Executes during object creation, after setting all properties.
function slidekor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slidekor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton1,'value',0);
stop(handles.t);

% --- Executes on button press in startcal.
function startcal_Callback(hObject, eventdata, handles)
% hObject    handle to startcal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.t.TimerFcn = {@mycallback, handles};
start(handles.t)


function mycallback(obj, event, han)
nilai = str2num(get(han.korval,'String'));
ibuffer=wavrecord(1024,44100); % read in one second singals
mag=10*log10(mean(ibuffer.^2)); % RMS in dB
mag=mag+94+nilai; %+nilai;
set(han.measval,'string',num2str(mag));  
%cek = get(handles.pushbutton1,'value');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over korval.
function korval_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to korval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(handles.korval,'String'));
if isnumeric(val) & ...
    val >= get(handles.slidekor,'Min') & ...
    val <= get(handles.slidekor,'Max')
    set(handles.slidekor,'Value',val);
end 
    



% --- Executes during object creation, after setting all properties.
function korval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to korval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.t)
close(gcf)
