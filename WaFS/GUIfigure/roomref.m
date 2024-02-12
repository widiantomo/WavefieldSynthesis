function varargout = roomref(varargin)
% ROOMREF M-file for roomref.fig
%      ROOMREF, by itself, creates a new ROOMREF or raises the existing
%      singleton*.
%
%      H = ROOMREF returns the handle to a new ROOMREF or the handle to
%      the existing singleton*.
%
%      ROOMREF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROOMREF.M with the given input arguments.
%
%      ROOMREF('Property','Value',...) creates a new ROOMREF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before roomref_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to roomref_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help roomref

% Last Modified by GUIDE v2.5 18-May-2007 23:48:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @roomref_OpeningFcn, ...
                   'gui_OutputFcn',  @roomref_OutputFcn, ...
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


% --- Executes just before roomref is made visible.
function roomref_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to roomref (see VARARGIN)

% Choose default command line output for roomref
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes roomref wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = roomref_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function ceilf_Callback(hObject, eventdata, handles)
% hObject    handle to ceilf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ceilf as text
%        str2double(get(hObject,'String')) returns contents of ceilf as a double


% --- Executes during object creation, after setting all properties.
function ceilf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ceilf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function frontf_Callback(hObject, eventdata, handles)
% hObject    handle to frontf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frontf as text
%        str2double(get(hObject,'String')) returns contents of frontf as a double


% --- Executes during object creation, after setting all properties.
function frontf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frontf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function rightf_Callback(hObject, eventdata, handles)
% hObject    handle to rightf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rightf as text
%        str2double(get(hObject,'String')) returns contents of rightf as a double


% --- Executes during object creation, after setting all properties.
function rightf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rightf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function backf_Callback(hObject, eventdata, handles)
% hObject    handle to backf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of backf as text
%        str2double(get(hObject,'String')) returns contents of backf as a double


% --- Executes during object creation, after setting all properties.
function backf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to backf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function leftf_Callback(hObject, eventdata, handles)
% hObject    handle to leftf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of leftf as text
%        str2double(get(hObject,'String')) returns contents of leftf as a double


% --- Executes during object creation, after setting all properties.
function leftf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to leftf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function floorf_Callback(hObject, eventdata, handles)
% hObject    handle to floorf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of floorf as text
%        str2double(get(hObject,'String')) returns contents of floorf as a double


% --- Executes during object creation, after setting all properties.
function floorf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to floorf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = gcf
ceil = str2double(get(h.ceilf,'String')); % error disini
front = str2double(get(handles.frontf,'String'));
left = str2double(get(handles.leftf,'String'));
right = str2double(get(handles.rightf,'String'));
back = str2double(get(handles.backf,'String'));
floor = str2double(get(handles.floorf,'String'));

roomr = [ceil front left right back floor];
save('roomref','roomr');
clf



