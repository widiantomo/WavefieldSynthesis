function varargout = tes12(varargin)
% TES12 M-file for tes12.fig
%      TES12, by itself, creates a new TES12 or raises the existing
%      singleton*.
%
%      H = TES12 returns the handle to a new TES12 or the handle to
%      the existing singleton*.
%
%      TES12('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TES12.M with the given input arguments.
%
%      TES12('Property','Value',...) creates a new TES12 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tes12_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tes12_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help tes12

% Last Modified by GUIDE v2.5 16-Apr-2007 09:03:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tes12_OpeningFcn, ...
                   'gui_OutputFcn',  @tes12_OutputFcn, ...
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


% --- Executes just before tes12 is made visible.
function tes12_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tes12 (see VARARGIN)

% Choose default command line output for tes12
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tes12 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tes12_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press over pushbutton1 with no controls selected.
function pushbutton1_KeyPressFcn(hObject, eventdata, handles)

axes(handles.axes1);
x = -pi:.1:pi;
y = sin(x);
plot(x,y)
set(gca,'XTick',-pi:pi/2:pi)
set(gca,'XTickLabel',{'-pi','-pi/2','0','pi/2','pi'})


