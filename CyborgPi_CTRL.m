function varargout = CyborgPi_CTRL(varargin)
% CYBORGPI_CTRL MATLAB code for CyborgPi_CTRL.fig
%      CYBORGPI_CTRL, by itself, creates a new CYBORGPI_CTRL or raises the existing
%      singleton*.
%
%      H = CYBORGPI_CTRL returns the handle to a new CYBORGPI_CTRL or the handle to
%      the existing singleton*.
%
%      CYBORGPI_CTRL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CYBORGPI_CTRL.M with the given input arguments.
%
%      CYBORGPI_CTRL('Property','Value',...) creates a new CYBORGPI_CTRL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CyborgPi_CTRL_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CyborgPi_CTRL_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CyborgPi_CTRL

% Last Modified by GUIDE v2.5 24-Jul-2019 14:55:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CyborgPi_CTRL_OpeningFcn, ...
                   'gui_OutputFcn',  @CyborgPi_CTRL_OutputFcn, ...
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
global rpi
% End initialization code - DO NOT EDIT


% --- Executes just before CyborgPi_CTRL is made visible.
function CyborgPi_CTRL_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CyborgPi_CTRL (see VARARGIN)

% Choose default command line output for CyborgPi_CTRL
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CyborgPi_CTRL wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CyborgPi_CTRL_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in StartButton.
function StartButton_Callback(hObject, eventdata, handles)
% hObject    handle to StartButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ip = '192.168.1.12'
usr = 'pi'
pass = 'ramanlab'
rpi = raspi(ip,usr,pass)
system(rpi, 'python /home/pi/CyborgPi/LineFollow.py >/dev/null 2>&1 &')
handles.pi = rpi


% --- Executes on button press in StopButton.
function StopButton_Callback(hObject, eventdata, handles)
% hObject    handle to StopButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%rpi = handles.pi
ip = '192.168.1.9'
usr = 'pi'
pass = 'ramanlab'
rpi = raspi(ip,usr,pass)
system(rpi, 'echo "1" > CyborgPi/command.txt')



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
