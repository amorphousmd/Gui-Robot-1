function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 07-Oct-2022 20:37:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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

% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using untitled.
initialize_gui(hObject, handles, false);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles)
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



% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% axes(handles.axes1);
% cla;
% 
% popup_sel_index = get(handles.popupmenu1, 'Value');
theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
T1 = createDHmatrix(0, pi/2 , 7.7, theta1/180*pi)
T2 = createDHmatrix(12.8, 0 , 0, theta2/180*pi)
T3 = createDHmatrix(12.4, 0 , 0, theta3/180*pi)
T20 = T1*T2;
T30 = T1*T2*T3
ry_angle = 90*pi/180; 
Ry = makehgtform('yrotate',ry_angle);

r = 1.2;
[X, Y, Z] = cylinder(r);
Z = Z * 7.7;
s1 = surf(X,Y,Z);
hold on
xlim([-50 50])
ylim([-60 60])
zlim([0 40])
rotate3d 'on'

Z = [-3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3;
    3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3]
t = hgtransform;
t.Matrix = T1;
s2 = surf(X,Y,Z, 'parent', t);


t = hgtransform;
t.Matrix = T20;
t.Matrix
s3 = surf(X,Y,Z, 'parent', t);
O2 = transpose(T20([1:3],[4:4]));
O1 = transpose(T1([1:3],[4:4]));
[Xp, Yp, Zp] = cylinder2P(1, 5,O1, O2);
surf(Xp, Yp, Zp);


t = hgtransform;
t.Matrix = T30;
t.Matrix
s4 = surf(X,Y,Z, 'parent', t);
O3 = transpose(T30([1:3],[4:4]));
[Xp, Yp, Zp] = cylinder2P(1, 5,O2, O3);
surf(Xp, Yp, Zp);
hold off





function editTheta1_Callback(hObject, eventdata, handles)
% hObject    handle to editTheta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTheta1 as text
%        str2double(get(hObject,'String')) returns contents of editTheta1 as a double
theta1 = str2double(get(hObject, 'String'));
if isnan(theta1)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.jointAngles.theta1 = theta1;
set(handles.sliderTheta1,'value',theta1);
guidata(hObject,handles)

theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
forwardUpdate(theta1, theta2, theta3);

% --- Executes during object creation, after setting all properties.
function editTheta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTheta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTheta2_Callback(hObject, eventdata, handles)
% hObject    handle to editTheta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTheta2 as text
%        str2double(get(hObject,'String')) returns contents of editTheta2 as a double
theta2 = str2double(get(hObject, 'String'));
if isnan(theta2)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.jointAngles.theta2 = theta2;
set(handles.sliderTheta2,'value',theta2);
guidata(hObject,handles)

theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);

% --- Executes during object creation, after setting all properties.
function editTheta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTheta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTheta3_Callback(hObject, eventdata, handles)
% hObject    handle to editTheta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTheta3 as text
%        str2double(get(hObject,'String')) returns contents of editTheta3 as a double
theta3 = str2double(get(hObject, 'String'));
if isnan(theta3)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.jointAngles.theta3 = theta3;
set(handles.sliderTheta3,'value',theta3);
guidata(hObject,handles)

theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);


% --- Executes during object creation, after setting all properties.
function editTheta3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTheta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTheta4_Callback(hObject, eventdata, handles)
% hObject    handle to editTheta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTheta4 as text
%        str2double(get(hObject,'String')) returns contents of editTheta4 as a double
theta4 = str2double(get(hObject, 'String'));
if isnan(theta4)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.jointAngles.theta4 = theta4;
set(handles.sliderTheta4,'value',theta4);
guidata(hObject,handles)

theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);


% --- Executes during object creation, after setting all properties.
function editTheta4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTheta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.
if isfield(handles, 'metricdata') && ~isreset
    return;
end

handles.jointAngles.theta1 = 0;
handles.jointAngles.theta2 = 90;
handles.jointAngles.theta3 = -90;
handles.jointAngles.theta4 = 0;

set(handles.editTheta1, 'String', handles.jointAngles.theta1);
set(handles.editTheta2, 'String', handles.jointAngles.theta2);
set(handles.editTheta3, 'String', handles.jointAngles.theta3);
set(handles.editTheta4, 'String', handles.jointAngles.theta4);

% Update handles structure
guidata(handles.figure1, handles);
theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);



% --- Executes on slider movement.
function sliderTheta1_Callback(hObject, eventdata, handles)
% hObject    handle to sliderTheta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
theta1 = get(hObject, 'Value');
% Save the new density value
handles.jointAngles.theta1 = theta1;
set(handles.editTheta1,'String',num2str(theta1));
guidata(hObject,handles)

theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);


% --- Executes during object creation, after setting all properties.
function sliderTheta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderTheta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderTheta2_Callback(hObject, eventdata, handles)
% hObject    handle to sliderTheta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
theta2 = get(hObject, 'Value');
% Save the new density value
handles.jointAngles.theta2 = theta2;
set(handles.editTheta2,'String',num2str(theta2));
guidata(hObject,handles)

theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);


% --- Executes during object creation, after setting all properties.
function sliderTheta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderTheta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderTheta3_Callback(hObject, eventdata, handles)
% hObject    handle to sliderTheta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
theta3 = get(hObject, 'Value');
% Save the new density value
handles.jointAngles.theta3 = theta3;
set(handles.editTheta3,'String',num2str(theta3));
guidata(hObject,handles);

theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);


% --- Executes during object creation, after setting all properties.
function sliderTheta3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderTheta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderTheta4_Callback(hObject, eventdata, handles)
% hObject    handle to sliderTheta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
theta4 = get(hObject, 'Value');
% Save the new density value
handles.jointAngles.theta4 = theta4;
set(handles.editTheta4,'String',num2str(theta4));
guidata(hObject,handles);

theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);


% --- Executes during object creation, after setting all properties.
function sliderTheta4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderTheta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in resetButton.
function resetButton_Callback(hObject, eventdata, handles)
% hObject    handle to resetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.jointAngles.theta1 = 0;
handles.jointAngles.theta2 = 90;
handles.jointAngles.theta3 = -90;
handles.jointAngles.theta4 = 0;

set(handles.editTheta1, 'String', handles.jointAngles.theta1);
set(handles.editTheta2, 'String', handles.jointAngles.theta2);
set(handles.editTheta3, 'String', handles.jointAngles.theta3);
set(handles.editTheta4, 'String', handles.jointAngles.theta4);

% Update handles structure
guidata(handles.figure1, handles);
theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);
