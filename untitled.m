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

% Last Modified by GUIDE v2.5 03-Dec-2022 00:08:58

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

% Initialise tabs
handles.tabManager = TabManager( hObject );

% Set-up a selection changed function on the create tab groups
tabGroups = handles.tabManager.TabGroups;
for tgi=1:length(tabGroups)
    set(tabGroups(tgi),'SelectionChangedFcn',@tabChangedCB)
end

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
theta4 = handles.jointAngles.theta4;
forwardUpdateIncrement(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);
global theta1Old
global theta2Old
global theta3Old
global theta4Old
theta1Old = theta1;
theta2Old = theta2;
theta3Old = theta3;
theta4Old = theta4;



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
forwardUpdateIncrement(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);
global theta1Old
global theta2Old
global theta3Old
global theta4Old
theta1Old = theta1;
theta2Old = theta2;
theta3Old = theta3;
theta4Old = theta4;

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
forwardUpdateIncrement(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);
global theta1Old
global theta2Old
global theta3Old
global theta4Old
theta1Old = theta1;
theta2Old = theta2;
theta3Old = theta3;
theta4Old = theta4;


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
forwardUpdateIncrement(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);
global theta1Old
global theta2Old
global theta3Old
global theta4Old
theta1Old = theta1;
theta2Old = theta2;
theta3Old = theta3;
theta4Old = theta4;


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
global prevS1;
global prevS2;
global prevS3;
global prevS4;
global prevS5;
global prevS6;
global prevS7;
global endEffectorX;
global endEffectorY;
global endEffectorZ;
global prevX10;
global prevX20;
global prevY10;
global prevY20;
global prevZ10;
global prevZ20;
global prevX11;
global prevX21;
global prevY11;
global prevY21;
global prevZ11;
global prevZ21;
global prevX12;
global prevX22;
global prevY12;
global prevY22;
global prevZ12;
global prevZ22;
global prevX13;
global prevX23;
global prevY13;
global prevY23;
global prevZ13;
global prevZ23;
global prevX14;
global prevX24;
global prevY14;
global prevY24;
global prevZ14;
global prevZ24;
global drawCoordsAllow;
global drawPathAllow;
global drawWorkspaceAllow;
global geometricSolve;
drawCoordsAllow = 0;
drawPathAllow = 0;
drawWorkspaceAllow = 0;
geometricSolve = 0;
global theta1Old;
global theta2Old;
global theta3Old;
global theta4Old;
handles.jointAngles.theta1 = 0;
handles.jointAngles.theta2 = 90;
handles.jointAngles.theta3 = -90;
handles.jointAngles.theta4 = 0;

theta1Old = 0;
theta2Old = 90;
theta3Old = -90;
theta4Old = 0;

handles.inverseAngles.theta1 = 0;
handles.inverseAngles.theta2 = 90;
handles.inverseAngles.theta3 = -90;
handles.inverseAngles.theta4 = 0;

handles.inverseAngles.EEffectorX = 27.4;
handles.inverseAngles.EEffectorY = 0;
handles.inverseAngles.EEffectorZ = 20.5;
handles.inverseAngles.EEffectorPitch = 0;

set(handles.editTheta1, 'String', handles.jointAngles.theta1);
set(handles.editTheta2, 'String', handles.jointAngles.theta2);
set(handles.editTheta3, 'String', handles.jointAngles.theta3);
set(handles.editTheta4, 'String', handles.jointAngles.theta4);

set(handles.editInverseX, 'String', handles.inverseAngles.EEffectorX);
set(handles.editInverseY, 'String', handles.inverseAngles.EEffectorY);
set(handles.editInverseZ, 'String', handles.inverseAngles.EEffectorZ);
set(handles.editInversePitch, 'String', handles.inverseAngles.EEffectorPitch);

set(handles.sliderInverseX, 'Value', handles.inverseAngles.EEffectorX);
set(handles.sliderInverseY, 'Value', handles.inverseAngles.EEffectorY);
set(handles.sliderInverseZ, 'Value', handles.inverseAngles.EEffectorZ);
set(handles.sliderInversePitch, 'Value', handles.inverseAngles.EEffectorPitch);

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
updateEndEffector(hObject, eventdata, handles);
global theta1Old
global theta2Old
global theta3Old
global theta4Old
theta1Old = theta1;
theta2Old = theta2;
theta3Old = theta3;
theta4Old = theta4;

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
updateEndEffector(hObject, eventdata, handles);
global theta1Old
global theta2Old
global theta3Old
global theta4Old
theta1Old = theta1;
theta2Old = theta2;
theta3Old = theta3;
theta4Old = theta4;


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
updateEndEffector(hObject, eventdata, handles);
global theta1Old
global theta2Old
global theta3Old
global theta4Old
theta1Old = theta1;
theta2Old = theta2;
theta3Old = theta3;
theta4Old = theta4;


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
updateEndEffector(hObject, eventdata, handles);
global theta1Old
global theta2Old
global theta3Old
global theta4Old
theta1Old = theta1;
theta2Old = theta2;
theta3Old = theta3;
theta4Old = theta4;


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
hold off
global theta1Old;
global theta2Old;
global theta3Old;
global theta4Old;
theta1Old = 0;
theta2Old = 90;
theta3Old = -90;
theta4Old = 0;
handles.jointAngles.theta1 = 0;
handles.jointAngles.theta2 = 90;
handles.jointAngles.theta3 = -90;
handles.jointAngles.theta4 = 0;

set(handles.editTheta1, 'String', handles.jointAngles.theta1);
set(handles.editTheta2, 'String', handles.jointAngles.theta2);
set(handles.editTheta3, 'String', handles.jointAngles.theta3);
set(handles.editTheta4, 'String', handles.jointAngles.theta4);

set(handles.sliderTheta1, 'Value', handles.jointAngles.theta1);
set(handles.sliderTheta2, 'Value', handles.jointAngles.theta2);
set(handles.sliderTheta3, 'Value', handles.jointAngles.theta3);
set(handles.sliderTheta4, 'Value', handles.jointAngles.theta4);


% Update handles structure
guidata(handles.figure1, handles);
theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);

function updateEndEffector(hObject, eventdata, handles)
global endEffectorX;
global endEffectorY;
global endEffectorZ;
global endEffectorRoll;
global endEffectorPitch;
global endEffectorYaw;
set(handles.editEndEffectorX, 'String', num2str(endEffectorX));
set(handles.editEndEffectorY, 'String', num2str(endEffectorY));
set(handles.editEndEffectorZ, 'String', num2str(endEffectorZ));
set(handles.editEndEffectorRoll, 'String', num2str(endEffectorRoll / pi * 180));
set(handles.editEndEffectorPitch, 'String', num2str(endEffectorPitch / pi * 180));
set(handles.editEndEffectorYaw, 'String', num2str(endEffectorYaw / pi * 180));

function calculateInverseKinematics(hObject, eventdata, handles)
global geometricSolve
if geometricSolve == 1
    offsetAngle = 10.6197;
    EEffectorX = handles.inverseAngles.EEffectorX;
    EEffectorY = handles.inverseAngles.EEffectorY;
    EEffectorZ = handles.inverseAngles.EEffectorZ;
    pitch = handles.inverseAngles.EEffectorPitch;

    theta1 = atan2(EEffectorY, EEffectorX) * 180 / pi;

    Y = EEffectorZ - 7.7;
    X = sqrt(EEffectorX * EEffectorX + EEffectorY * EEffectorY) ;
    beta = -pitch;
    % beta = pitch;
    P2x = X - 12.6 * cos(beta * pi / 180);
    P2y = Y - 12.6 * sin(beta * pi / 180);
    theta3 = acos((P2x*P2x + P2y*P2y - 13.0231*13.0231 - 12.4*12.4) / (2 * 13.0231 * 12.4)) * 180 / pi ;
    theta2 = (atan(P2y/ P2x) - atan2( (12.4 * sin(theta3 * pi / 180)) , (13.0231 + 12.4 * cos(theta3 * pi / 180))))* 180 / pi + 10.6197;
    theta4 = beta - theta3 - theta2;
    theta3 = theta3 - 10.6197;
    theta4 = theta4 + 10.6197;
else
    x = handles.inverseAngles.EEffectorX * 10;
    y = handles.inverseAngles.EEffectorY * 10;
    z = handles.inverseAngles.EEffectorZ * 10;
    pitch = handles.inverseAngles.EEffectorPitch;
    yaw = atan2(y, x) * 180 / pi;
    theta1o = handles.jointAngles.theta1;
    theta2o = handles.jointAngles.theta2;
    theta3o = handles.jointAngles.theta3;
    theta4o = handles.jointAngles.theta4;
    [theta1c, theta2c, theta3c, theta4c] = inversekinematic(x,z,pitch,yaw, theta1o, theta2o, theta3o, theta4o);
    theta1 = double(wrapAngle(theta1c)); 
    theta2 = double(wrapAngle(theta2c)) + 90;
    theta3 = double(wrapAngle(theta3c)) - 90;
    theta4 = double(wrapAngle(theta4c)); 
end
set(handles.editTheta1,'String',num2str(theta1));
set(handles.editTheta2,'String',num2str(theta2));
set(handles.editTheta3,'String',num2str(theta3));
set(handles.editTheta4,'String',num2str(theta4));
set(handles.sliderTheta1,'value',theta1);
set(handles.sliderTheta2,'value',theta2);
set(handles.sliderTheta3,'value',theta3);
set(handles.sliderTheta4,'value',theta4);
handles.jointAngles.theta1 = theta1;
handles.jointAngles.theta2 = theta2;
handles.jointAngles.theta3 = theta3;
handles.jointAngles.theta4 = theta4;
guidata(hObject,handles)

forwardUpdate(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);

function [theta1, theta2, theta3, theta4] = calculateInverseKinematicsPath(hObject, eventdata, handles, EEffectorX, EEffectorY, EEffectorZ, pitch)
global geometricSolve
if geometricSolve == 1
    offsetAngle = 10.6197;
    EEffectorX = handles.inverseAngles.EEffectorX
    EEffectorY = handles.inverseAngles.EEffectorY
    EEffectorZ = handles.inverseAngles.EEffectorZ
    pitch = handles.inverseAngles.EEffectorPitch

    theta1 = atan2(EEffectorY, EEffectorX) * 180 / pi;

    Y = EEffectorZ - 7.7;
    X = sqrt(EEffectorX * EEffectorX + EEffectorY * EEffectorY) ;
    beta = -pitch;
    % beta = pitch;
    P2x = X - 12.6 * cos(beta * pi / 180);
    P2y = Y - 12.6 * sin(beta * pi / 180);
    theta3 = acos((P2x*P2x + P2y*P2y - 13.0231*13.0231 - 12.4*12.4) / (2 * 13.0231 * 12.4)) * 180 / pi ;
    theta2 = (atan(P2y/ P2x) - atan2( (12.4 * sin(theta3 * pi / 180)) , (13.0231 + 12.4 * cos(theta3 * pi / 180))))* 180 / pi + 10.6197;
    theta4 = beta - theta3 - theta2;
    theta3 = theta3 - 10.6197;
    theta4 = theta4 + 10.6197;
else
    x = EEffectorX * 10;
    y = EEffectorY * 10;
    z = EEffectorZ * 10;
    pitch = pitch;
    yaw = atan2(y, x) * 180 / pi;
    theta1o = handles.jointAngles.theta1;
    theta2o = handles.jointAngles.theta2;
    theta3o = handles.jointAngles.theta3;
    theta4o = handles.jointAngles.theta4;
    [theta1c, theta2c, theta3c, theta4c] = inversekinematic(x,z,pitch,yaw, theta1o, theta2o, theta3o, theta4o);
    theta1 = double(wrapAngle(theta1c)) ;
    theta2 = double(wrapAngle(theta2c)) + 90;
    theta3 = double(wrapAngle(theta3c)) - 90;
    theta4 = double(wrapAngle(theta4c)) ;
end

set(handles.editTheta1,'String',num2str(theta1));
set(handles.editTheta2,'String',num2str(theta2));
set(handles.editTheta3,'String',num2str(theta3));
set(handles.editTheta4,'String',num2str(theta4));
set(handles.sliderTheta1,'value',theta1);
set(handles.sliderTheta2,'value',theta2);
set(handles.sliderTheta3,'value',theta3);
set(handles.sliderTheta4,'value',theta4);
guidata(hObject,handles)

forwardUpdate(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);


function editEndEffectorX_Callback(hObject, eventdata, handles)
% hObject    handle to editEndEffectorX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEndEffectorX as text
%        str2double(get(hObject,'String')) returns contents of editEndEffectorX as a double


% --- Executes during object creation, after setting all properties.
function editEndEffectorX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEndEffectorX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editEndEffectorY_Callback(hObject, eventdata, handles)
% hObject    handle to editEndEffectorY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEndEffectorY as text
%        str2double(get(hObject,'String')) returns contents of editEndEffectorY as a double


% --- Executes during object creation, after setting all properties.
function editEndEffectorY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEndEffectorY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editEndEffectorZ_Callback(hObject, eventdata, handles)
% hObject    handle to editEndEffectorZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEndEffectorZ as text
%        str2double(get(hObject,'String')) returns contents of editEndEffectorZ as a double


% --- Executes during object creation, after setting all properties.
function editEndEffectorZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEndEffectorZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editEndEffectorRoll_Callback(hObject, eventdata, handles)
% hObject    handle to editEndEffectorRoll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEndEffectorRoll as text
%        str2double(get(hObject,'String')) returns contents of editEndEffectorRoll as a double


% --- Executes during object creation, after setting all properties.
function editEndEffectorRoll_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEndEffectorRoll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editEndEffectorPitch_Callback(hObject, eventdata, handles)
% hObject    handle to editEndEffectorPitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEndEffectorPitch as text
%        str2double(get(hObject,'String')) returns contents of editEndEffectorPitch as a double


% --- Executes during object creation, after setting all properties.
function editEndEffectorPitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEndEffectorPitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editEndEffectorYaw_Callback(hObject, eventdata, handles)
% hObject    handle to editEndEffectorYaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEndEffectorYaw as text
%        str2double(get(hObject,'String')) returns contents of editEndEffectorYaw as a double


% --- Executes during object creation, after setting all properties.
function editEndEffectorYaw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEndEffectorYaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInverseX_Callback(hObject, eventdata, handles)
% hObject    handle to editInverseX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInverseX as text
%        str2double(get(hObject,'String')) returns contents of editInverseX as a double
EEffectorX = str2double(get(hObject, 'String'));
if isnan(EEffectorX)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.inverseAngles.EEffectorX = EEffectorX;
guidata(hObject,handles)
calculateInverseKinematics(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editInverseX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInverseX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInverseY_Callback(hObject, eventdata, handles)
% hObject    handle to editInverseY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInverseY as text
%        str2double(get(hObject,'String')) returns contents of editInverseY as a double
EEffectorY = str2double(get(hObject, 'String'));
if isnan(EEffectorY)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.inverseAngles.EEffectorY = EEffectorY;
guidata(hObject,handles)
calculateInverseKinematics(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editInverseY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInverseY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInverseZ_Callback(hObject, eventdata, handles)
% hObject    handle to editInverseZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInverseZ as text
%        str2double(get(hObject,'String')) returns contents of editInverseZ as a double
EEffectorZ = str2double(get(hObject, 'String'));
if isnan(EEffectorZ)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.inverseAngles.EEffectorZ = EEffectorZ;
guidata(hObject,handles)
calculateInverseKinematics(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editInverseZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInverseZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInversePitch_Callback(hObject, eventdata, handles)
% hObject    handle to editInversePitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInversePitch as text
%        str2double(get(hObject,'String')) returns contents of editInversePitch as a double
EEffectorPitch = str2double(get(hObject, 'String'));
if isnan(EEffectorPitch)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.inverseAngles.EEffectorPitch = EEffectorPitch;
guidata(hObject,handles)
calculateInverseKinematics(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function editInversePitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInversePitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnCalculateInverseKinematics.
function btnCalculateInverseKinematics_Callback(hObject, eventdata, handles)
% hObject    handle to btnCalculateInverseKinematics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global geometricSolve
if geometricSolve == 1
    offsetAngle = 10.6197;
    EEffectorX = handles.inverseAngles.EEffectorX;
    EEffectorY = handles.inverseAngles.EEffectorY;
    EEffectorZ = handles.inverseAngles.EEffectorZ;
    pitch = handles.inverseAngles.EEffectorPitch;

    theta1 = atan2(EEffectorY, EEffectorX) * 180 / pi;

    Y = EEffectorZ - 7.7;
    X = sqrt(EEffectorX * EEffectorX + EEffectorY * EEffectorY) ;
    beta = -pitch;
    % beta = pitch;
    P2x = X - 12.6 * cos(beta * pi / 180);
    P2y = Y - 12.6 * sin(beta * pi / 180);
    theta3 = acos((P2x*P2x + P2y*P2y - 13.0231*13.0231 - 12.4*12.4) / (2 * 13.0231 * 12.4)) * 180 / pi ;
    theta2 = (atan(P2y/ P2x) - atan2( (12.4 * sin(theta3 * pi / 180)) , (13.0231 + 12.4 * cos(theta3 * pi / 180))))* 180 / pi + 10.6197;
    theta4 = beta - theta3 - theta2;
    theta3 = theta3 - 10.6197;
    theta4 = theta4 + 10.6197;
else
    x = handles.inverseAngles.EEffectorX * 10;
    y = handles.inverseAngles.EEffectorY * 10;
    z = handles.inverseAngles.EEffectorZ * 10;
    pitch = handles.inverseAngles.EEffectorPitch;
    yaw = atan2(y, x) * 180 / pi;
    theta1o = handles.jointAngles.theta1;
    theta2o = handles.jointAngles.theta2;
    theta3o = handles.jointAngles.theta3;
    theta4o = handles.jointAngles.theta4;
    [theta1c, theta2c, theta3c, theta4c] = inversekinematic(x,z,pitch,yaw, theta1o, theta2o, theta3o, theta4o);
    theta1 = double(wrapAngle(theta1c)) ;
    theta2 = double(wrapAngle(theta2c)) + 90;
    theta3 = double(wrapAngle(theta3c)) - 90;
    theta4 = double(wrapAngle(theta4c)) ;
end

forwardUpdate(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);

set(handles.editTheta1,'String',num2str(theta1));
set(handles.editTheta2,'String',num2str(theta2));
set(handles.editTheta3,'String',num2str(theta3));
set(handles.editTheta4,'String',num2str(theta4));
set(handles.sliderTheta1,'value',theta1);
set(handles.sliderTheta2,'value',theta2);
set(handles.sliderTheta3,'value',theta3);
set(handles.sliderTheta4,'value',theta4);
guidata(hObject,handles)


% --- Executes on slider movement.
function sliderInverseX_Callback(hObject, eventdata, handles)
% hObject    handle to sliderInverseX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
EEffectorX = get(hObject, 'Value');
% Save the new density value
handles.inverseAngles.EEffectorX = EEffectorX;
set(handles.editInverseX,'String',num2str(EEffectorX));
guidata(hObject,handles)
calculateInverseKinematics(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function sliderInverseX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderInverseX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderInverseY_Callback(hObject, eventdata, handles)
% hObject    handle to sliderInverseY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
EEffectorY = get(hObject, 'Value');
% Save the new density value
handles.inverseAngles.EEffectorY = EEffectorY;
set(handles.editInverseY,'String',num2str(EEffectorY));
updateEndEffector(hObject, eventdata, handles)
guidata(hObject,handles)
calculateInverseKinematics(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function sliderInverseY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderInverseY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderInverseZ_Callback(hObject, eventdata, handles)
% hObject    handle to sliderInverseZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
EEffectorZ = get(hObject, 'Value');
% Save the new density value
handles.inverseAngles.EEffectorZ = EEffectorZ;
set(handles.editInverseZ,'String',num2str(EEffectorZ));
updateEndEffector(hObject, eventdata, handles)
guidata(hObject,handles)
calculateInverseKinematics(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function sliderInverseZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderInverseZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderInversePitch_Callback(hObject, eventdata, handles)
% hObject    handle to sliderInversePitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
EEffectorPitch = get(hObject, 'Value');
% Save the new density value
handles.inverseAngles.EEffectorPitch = EEffectorPitch;
set(handles.editInversePitch,'String',num2str(EEffectorPitch));
updateEndEffector(hObject, eventdata, handles)
guidata(hObject,handles)
calculateInverseKinematics(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function sliderInversePitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderInversePitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
state = get(hObject,'Value');
global drawCoordsAllow;
drawCoordsAllow = state;


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
state = get(hObject,'Value');
global drawPathAllow;
drawPathAllow = state;



function editInterpolateX_Callback(hObject, eventdata, handles)
% hObject    handle to editInterpolateX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInterpolateX as text
%        str2double(get(hObject,'String')) returns contents of editInterpolateX as a double
EEffectorX = str2double(get(hObject, 'String'));
if isnan(EEffectorX)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.interpolateVars.EEffectorX = EEffectorX;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editInterpolateX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInterpolateX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInterpolateY_Callback(hObject, eventdata, handles)
% hObject    handle to editInterpolateY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInterpolateY as text
%        str2double(get(hObject,'String')) returns contents of editInterpolateY as a double
EEffectorY = str2double(get(hObject, 'String'));
if isnan(EEffectorY)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.interpolateVars.EEffectorY = EEffectorY;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editInterpolateY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInterpolateY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInterpolateZ_Callback(hObject, eventdata, handles)
% hObject    handle to editInterpolateZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInterpolateZ as text
%        str2double(get(hObject,'String')) returns contents of editInterpolateZ as a double
EEffectorZ = str2double(get(hObject, 'String'));
if isnan(EEffectorZ)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.interpolateVars.EEffectorZ = EEffectorZ;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editInterpolateZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInterpolateZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInterpolatePitch_Callback(hObject, eventdata, handles)
% hObject    handle to editInterpolatePitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInterpolatePitch as text
%        str2double(get(hObject,'String')) returns contents of editInterpolatePitch as a double
EEffectorPitch = str2double(get(hObject, 'String'));
if isnan(EEffectorPitch)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.interpolateVars.EEffectorPitch = EEffectorPitch;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editInterpolatePitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInterpolatePitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnInterPolate.
function btnInterPolate_Callback(hObject, eventdata, handles)
% hObject    handle to btnInterPolate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1)
cla(handles.axes2)
cla(handles.axes3)
cla(handles.axesTheta1)
cla(handles.axesTheta2)
cla(handles.axesTheta3)
cla(handles.axesTheta4)
cla(handles.axesTheta1Dot)
cla(handles.axesTheta2Dot)
cla(handles.axesTheta3Dot)
cla(handles.axesTheta4Dot)
EEffectorX1 = handles.inverseAngles.EEffectorX;
EEffectorY1 = handles.inverseAngles.EEffectorY;
EEffectorZ1 = handles.inverseAngles.EEffectorZ;
pitch1 = handles.inverseAngles.EEffectorPitch;
EEffectorX2 = handles.interpolateVars.EEffectorX;
EEffectorY2 = handles.interpolateVars.EEffectorY;
EEffectorZ2 = handles.interpolateVars.EEffectorZ;
pitch2 = handles.interpolateVars.EEffectorPitch;
pmax = sqrt((EEffectorX2 - EEffectorX1)^2 + (EEffectorY2 - EEffectorY1)^2 + (EEffectorZ2 - EEffectorZ1)^2);
amax = handles.interpolateVars.Amax;
vmax = handles.interpolateVars.Vmax;
[x, y1, y2, y3] = createProfile(pmax, vmax, amax);
list = [];
for i = 1:floor(length(y3) / 1200)
    list = [list, y3(1200*i)];
end
% Taking the percentage of the path
list = list / pmax;
hold(handles.axes1,'on');
plot(handles.axes1, x, y1);
hold(handles.axes2,'on');
plot(handles.axes2, x, y2);
hold(handles.axes3,'on');
plot(handles.axes3, x, y3);
EEffectorXPoints = [];
EEffectorYPoints = [];
EEffectorZPoints = [];
pitchPoints = [];
theta1Points = [];
theta2Points = [];
theta3Points = [];
theta4Points = [];
iPoints = [];
for i = 1:floor(length(y3) / 1200)
    EEffectorXPoints = [EEffectorXPoints, EEffectorX1 + (EEffectorX2 - EEffectorX1) * list(i)];
    EEffectorYPoints = [EEffectorYPoints, EEffectorY1 + (EEffectorY2 - EEffectorY1) * list(i)];
    EEffectorZPoints = [EEffectorZPoints, EEffectorZ1 + (EEffectorZ2 - EEffectorZ1) * list(i)];
    pitchPoints = [pitchPoints, pitch1 + (pitch2 - pitch1) * list(i)];
end
% EEffectorXPoints = linspace(EEffectorX1, EEffectorX2, 100);
% EEffectorYPoints = linspace(EEffectorY1, EEffectorY2, 100);
% EEffectorZPoints = linspace(EEffectorZ1, EEffectorZ2, 100);
% pitchPoints = linspace(pitch1, pitch2, 100)
for i = 1:floor(length(y3) / 1200)
    [theta1, theta2, theta3, theta4] = calculateInverseKinematicsPath(hObject, eventdata, handles, EEffectorXPoints(i), EEffectorYPoints(i), EEffectorZPoints(i), pitchPoints(i));
    theta1Points = [theta1Points, theta1]
    theta2Points = [theta2Points, theta2];
    theta3Points = [theta3Points, theta3];
    theta4Points = [theta4Points, theta4];
    iPoints = [iPoints, i];
    hold(handles.axesTheta1,'on');
    plot(handles.axesTheta1, iPoints, theta1Points, 'b');
    hold(handles.axesTheta2,'on');
    plot(handles.axesTheta2, iPoints, theta2Points, 'b');
    hold(handles.axesTheta3,'on');
    plot(handles.axesTheta3, iPoints, theta3Points, 'b');
    hold(handles.axesTheta4,'on');
    plot(handles.axesTheta4, iPoints, theta4Points, 'b');
    
    if i > 2
        hold(handles.axesTheta1Dot,'on');    
        dy=diff(theta1Points)./diff(iPoints)
        plot(handles.axesTheta1Dot, iPoints(2:end),dy, 'b');
        hold(handles.axesTheta2Dot,'on');    
        dy=diff(theta2Points)./diff(iPoints);
        plot(handles.axesTheta2Dot, iPoints(2:end),dy, 'b');
        hold(handles.axesTheta3Dot,'on');    
        dy=diff(theta3Points)./diff(iPoints);
        plot(handles.axesTheta3Dot, iPoints(2:end),dy, 'b');
        hold(handles.axesTheta4Dot,'on');    
        dy=diff(theta4Points)./diff(iPoints);
        plot(handles.axesTheta4Dot, iPoints(2:end),dy, 'b');
    end
    pause(0.0001);

end
handles.inverseAngles.EEffectorX = EEffectorX2;
handles.inverseAngles.EEffectorY = EEffectorY2;
handles.inverseAngles.EEffectorZ = EEffectorZ2;
handles.inverseAngles.EEffectorPitch = pitch2;
set(handles.editInverseX,'String',num2str(EEffectorX2));
set(handles.editInverseY,'String',num2str(EEffectorY2));
set(handles.editInverseZ,'String',num2str(EEffectorZ2));
set(handles.editInversePitch,'String',num2str(pitch2));
set(handles.sliderInverseX, 'Value', EEffectorX2);
set(handles.sliderInverseX, 'Value', EEffectorY2);
set(handles.sliderInverseX, 'Value', EEffectorZ2);
set(handles.sliderInverseX, 'Value', pitch2);
guidata(hObject,handles)



function editVMax_Callback(hObject, eventdata, handles)
% hObject    handle to editVMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVMax as text
%        str2double(get(hObject,'String')) returns contents of editVMax as a double
Vmax = str2double(get(hObject, 'String'));
if isnan(Vmax)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.interpolateVars.Vmax = Vmax;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editVMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editAMax_Callback(hObject, eventdata, handles)
% hObject    handle to editAMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAMax as text
%        str2double(get(hObject,'String')) returns contents of editAMax as a double
Amax = str2double(get(hObject, 'String'));
if isnan(Amax)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.interpolateVars.Amax = Amax;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editAMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3



function editWorkspaceTheta2Min_Callback(hObject, eventdata, handles)
% hObject    handle to editWorkspaceTheta2Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editWorkspaceTheta2Min as text
%        str2double(get(hObject,'String')) returns contents of editWorkspaceTheta2Min as a double
WspTheta2Min = str2double(get(hObject, 'String'));
if isnan(WspTheta2Min)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.Workspace.WspTheta2Min = WspTheta2Min;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editWorkspaceTheta2Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWorkspaceTheta2Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editWorkspaceTheta3Min_Callback(hObject, eventdata, handles)
% hObject    handle to editWorkspaceTheta3Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editWorkspaceTheta3Min as text
%        str2double(get(hObject,'String')) returns contents of editWorkspaceTheta3Min as a double
WspTheta3Min = str2double(get(hObject, 'String'));
if isnan(WspTheta3Min)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.Workspace.WspTheta3Min = WspTheta3Min;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editWorkspaceTheta3Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWorkspaceTheta3Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editWorkspaceTheta4Min_Callback(hObject, eventdata, handles)
% hObject    handle to editWorkspaceTheta4Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editWorkspaceTheta4Min as text
%        str2double(get(hObject,'String')) returns contents of editWorkspaceTheta4Min as a double
WspTheta4Min = str2double(get(hObject, 'String'));
if isnan(WspTheta4Min)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.Workspace.WspTheta4Min = WspTheta4Min;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editWorkspaceTheta4Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWorkspaceTheta4Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hold(handles.axesWorkspace,'off');
theta2Min = handles.Workspace.WspTheta2Min;
theta3Min = handles.Workspace.WspTheta3Min;
theta4Min = handles.Workspace.WspTheta4Min;
theta2Max = handles.Workspace.WspTheta2Max;
theta3Max = handles.Workspace.WspTheta3Max;
theta4Max = handles.Workspace.WspTheta4Max;
[x, y] = plotWorkspace2D(theta2Min, theta3Min, theta4Min, theta2Max, theta3Max, theta4Max);
plot(handles.axesWorkspace, x, y, 'g','LineWidth',2);
hold(handles.axesWorkspace,'on');



% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state = get(hObject,'Value')
global drawWorkspaceAllow;
drawWorkspaceAllow = state;

% Hint: get(hObject,'Value') returns toggle state of checkbox4



function editWorkspaceTheta2Max_Callback(hObject, eventdata, handles)
% hObject    handle to editWorkspaceTheta2Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editWorkspaceTheta2Max as text
%        str2double(get(hObject,'String')) returns contents of editWorkspaceTheta2Max as a double
WspTheta2Max = str2double(get(hObject, 'String'));
if isnan(WspTheta2Max)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.Workspace.WspTheta2Max = WspTheta2Max;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editWorkspaceTheta2Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWorkspaceTheta2Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editWorkspaceTheta3Max_Callback(hObject, eventdata, handles)
% hObject    handle to editWorkspaceTheta3Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editWorkspaceTheta3Max as text
%        str2double(get(hObject,'String')) returns contents of editWorkspaceTheta3Max as a double
WspTheta3Max = str2double(get(hObject, 'String'));
if isnan(WspTheta3Max)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.Workspace.WspTheta3Max = WspTheta3Max;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editWorkspaceTheta3Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWorkspaceTheta3Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editWorkspaceTheta4Max_Callback(hObject, eventdata, handles)
% hObject    handle to editWorkspaceTheta4Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editWorkspaceTheta4Max as text
%        str2double(get(hObject,'String')) returns contents of editWorkspaceTheta4Max as a double
WspTheta4Max = str2double(get(hObject, 'String'));
if isnan(WspTheta4Max)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.Workspace.WspTheta4Max = WspTheta4Max;
guidata(hObject,handles)



% --- Executes during object creation, after setting all properties.
function editWorkspaceTheta4Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWorkspaceTheta4Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnPseudoInverse.
function btnPseudoInverse_Callback(hObject, eventdata, handles)
% hObject    handle to btnPseudoInverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1)
cla(handles.axes2)
cla(handles.axes3)
cla(handles.axesTheta1)
cla(handles.axesTheta2)
cla(handles.axesTheta3)
cla(handles.axesTheta4)
cla(handles.axesTheta1Dot)
cla(handles.axesTheta2Dot)
cla(handles.axesTheta3Dot)
cla(handles.axesTheta4Dot)
EEffectorX1 = handles.inverseAngles.EEffectorX;
EEffectorY1 = handles.inverseAngles.EEffectorY;
EEffectorZ1 = handles.inverseAngles.EEffectorZ;
pitch1 = handles.inverseAngles.EEffectorPitch;
EEffectorX2 = handles.interpolateVars.EEffectorX;
EEffectorY2 = handles.interpolateVars.EEffectorY;
EEffectorZ2 = handles.interpolateVars.EEffectorZ;
pitch2 = handles.interpolateVars.EEffectorPitch;
pmax = sqrt((EEffectorX2 - EEffectorX1)^2 + (EEffectorY2 - EEffectorY1)^2 + (EEffectorZ2 - EEffectorZ1)^2);
amax = handles.interpolateVars.Amax;
vmax = handles.interpolateVars.Vmax;
[x, y1, y2, y3] = createProfile(pmax, vmax, amax);
list = [];
listVel = [];
for i = 1:floor(length(y3) / 600)
    list = [list, y3(600*i)];
    listVel = [listVel, y2(600*i)];
end
% Taking the percentage of the path
list = list / pmax;
listVel = listVel / pmax;
hold(handles.axes1,'on');
plot(handles.axes1, x, y1);
hold(handles.axes2,'on');
plot(handles.axes2, x, y2);
hold(handles.axes3,'on');
plot(handles.axes3, x, y3);
EEffectorXPoints = [];
EEffectorYPoints = [];
EEffectorZPoints = [];
pitchPoints = [];
XVPoints = [];
YVPoints = [];
ZVPoints = [];
pitchVPoints = [];
theta1Points = [];
theta2Points = [];
theta3Points = [];
theta4Points = [];
theta1DotPoints = [];
theta2DotPoints = [];
theta3DotPoints = [];
theta4DotPoints = [];
iPoints = [];
for i = 1:floor(length(y3) / 600)
    EEffectorXPoints = [EEffectorXPoints, EEffectorX1 + (EEffectorX2 - EEffectorX1) * list(i)];
    EEffectorYPoints = [EEffectorYPoints, EEffectorY1 + (EEffectorY2 - EEffectorY1) * list(i)];
    EEffectorZPoints = [EEffectorZPoints, EEffectorZ1 + (EEffectorZ2 - EEffectorZ1) * list(i)];
    pitchPoints = [pitchPoints, pitch1 + (pitch2 - pitch1) * list(i)];
    XVPoints = [XVPoints, (EEffectorX2 - EEffectorX1) * listVel(i)];
    YVPoints = [YVPoints, (EEffectorY2 - EEffectorY1) * listVel(i)];
    ZVPoints = [ZVPoints, (EEffectorZ2 - EEffectorZ1) * listVel(i)];
    pitchVPoints = [pitchVPoints, (pitch2 - pitch1) * listVel(i)];
end
% EEffectorXPoints = linspace(EEffectorX1, EEffectorX2, 100);
% EEffectorYPoints = linspace(EEffectorY1, EEffectorY2, 100);
% EEffectorZPoints = linspace(EEffectorZ1, EEffectorZ2, 100);
% pitchPoints = linspace(pitch1, pitch2, 100)
dRoll = 0;
for i = 1:floor(length(y3) / 600)
    [theta1, theta2, theta3, theta4] = calculateInverseKinematicsPath(hObject, eventdata, handles, EEffectorXPoints(i), EEffectorYPoints(i), EEffectorZPoints(i), pitchPoints(i))
    theta1Points = [theta1Points, theta1];
    theta2Points = [theta2Points, theta2];
    theta3Points = [theta3Points, theta3];
    theta4Points = [theta4Points, theta4];
    iPoints = [iPoints, i];
    hold(handles.axesTheta1,'on');
    plot(handles.axesTheta1, iPoints, theta1Points, 'b');
    hold(handles.axesTheta2,'on');
    plot(handles.axesTheta2, iPoints, theta2Points, 'b');
    hold(handles.axesTheta3,'on');
    plot(handles.axesTheta3, iPoints, theta3Points, 'b');
    hold(handles.axesTheta4,'on');
    plot(handles.axesTheta4, iPoints, theta4Points, 'b');
    

    vX = XVPoints(i);
    vY = YVPoints(i);
    vZ = ZVPoints(i);

    global T40
    ExtractedRotationMatrix = T40(1:3,1:3)
    if i == 1
        prevmatPos1Point = ExtractedRotationMatrix(1,1);
        prevmatPos2Point = ExtractedRotationMatrix(1,2);
        prevmatPos3Point = ExtractedRotationMatrix(1,3);
        prevmatPos4Point = ExtractedRotationMatrix(2,1);
        prevmatPos5Point = ExtractedRotationMatrix(2,2);
        prevmatPos6Point = ExtractedRotationMatrix(2,3);
        prevmatPos7Point = ExtractedRotationMatrix(3,1);
        prevmatPos8Point = ExtractedRotationMatrix(3,2);
        prevmatPos9Point = ExtractedRotationMatrix(3,3);
    else
        matPos1Point = ExtractedRotationMatrix(1,1);
        matPos2Point = ExtractedRotationMatrix(1,2);
        matPos3Point = ExtractedRotationMatrix(1,3);
        matPos4Point = ExtractedRotationMatrix(2,1);
        matPos5Point = ExtractedRotationMatrix(2,2);
        matPos6Point = ExtractedRotationMatrix(2,3);
        matPos7Point = ExtractedRotationMatrix(3,1);
        matPos8Point = ExtractedRotationMatrix(3,2);
        matPos9Point = ExtractedRotationMatrix(3,3);
        
        diffmatPos1Point = matPos1Point - prevmatPos1Point;
        diffmatPos2Point = matPos2Point - prevmatPos2Point;
        diffmatPos3Point = matPos3Point - prevmatPos3Point;
        diffmatPos4Point = matPos4Point - prevmatPos4Point;
        diffmatPos5Point = matPos5Point - prevmatPos5Point;
        diffmatPos6Point = matPos6Point - prevmatPos6Point;
        diffmatPos7Point = matPos7Point - prevmatPos7Point;
        diffmatPos8Point = matPos8Point - prevmatPos8Point;
        diffmatPos9Point = matPos9Point - prevmatPos9Point;
        
        diffMatrix = [diffmatPos1Point, diffmatPos2Point, diffmatPos3Point;
                      diffmatPos4Point, diffmatPos5Point, diffmatPos6Point;
                      diffmatPos7Point, diffmatPos8Point, diffmatPos9Point]
        SkewMatrix = diffMatrix * transpose(ExtractedRotationMatrix)
        wX = SkewMatrix(3,2)
        wY = SkewMatrix(1,3)
        wZ = SkewMatrix(2,1)
        
        workspaceVector = [vX; vY; vZ; wX; wY; wZ]
        
        % This is calculated using pseudo inverse
        jointspaceVector = jacobian(theta1*pi/180,theta2*pi/180,theta3*pi/180,theta4*pi/180) * workspaceVector;

        
        theta1DotPoint = jointspaceVector(1,1);
        theta2DotPoint = jointspaceVector(2,1);
        theta3DotPoint = jointspaceVector(3,1);
        theta4DotPoint = jointspaceVector(4,1);
        
        theta1DotPoints = [theta1DotPoints, theta1DotPoint];
        theta2DotPoints = [theta2DotPoints, theta2DotPoint];
        theta3DotPoints = [theta3DotPoints, theta3DotPoint];
        theta4DotPoints = [theta4DotPoints, theta4DotPoint];
        
        prevmatPos1Point = matPos1Point;
        prevmatPos2Point = matPos2Point;
        prevmatPos3Point = matPos3Point;
        prevmatPos4Point = matPos4Point;
        prevmatPos5Point = matPos5Point;
        prevmatPos6Point = matPos6Point;
        prevmatPos7Point = matPos7Point;
        prevmatPos8Point = matPos8Point;
        prevmatPos9Point = matPos9Point;

        hold(handles.axesTheta1Dot,'on');    
        plot(handles.axesTheta1Dot, iPoints(2:end),theta1DotPoints, 'b');
        hold(handles.axesTheta2Dot,'on');    
        plot(handles.axesTheta2Dot, iPoints(2:end),theta2DotPoints, 'b');
        hold(handles.axesTheta3Dot,'on');    
        plot(handles.axesTheta3Dot, iPoints(2:end),theta3DotPoints, 'b');
        hold(handles.axesTheta4Dot,'on');    
        plot(handles.axesTheta4Dot, iPoints(2:end),theta4DotPoints, 'b');
    end
    
    pause(0.0001);

end


handles.inverseAngles.EEffectorX = EEffectorX2;
handles.inverseAngles.EEffectorY = EEffectorY2;
handles.inverseAngles.EEffectorZ = EEffectorZ2;
handles.inverseAngles.EEffectorPitch = pitch2;
set(handles.editInverseX,'String',num2str(EEffectorX2));
set(handles.editInverseY,'String',num2str(EEffectorY2));
set(handles.editInverseZ,'String',num2str(EEffectorZ2));
set(handles.editInversePitch,'String',num2str(pitch2));
set(handles.sliderInverseX, 'Value', EEffectorX2);
set(handles.sliderInverseX, 'Value', EEffectorY2);
set(handles.sliderInverseX, 'Value', EEffectorZ2);
set(handles.sliderInverseX, 'Value', pitch2);
guidata(hObject,handles)


% --- Executes on button press in btnInterpolateAbs.
function btnInterpolateAbs_Callback(hObject, eventdata, handles)
% hObject    handle to btnInterpolateAbs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1)
cla(handles.axes2)
cla(handles.axes3)
cla(handles.axesTheta1)
cla(handles.axesTheta2)
cla(handles.axesTheta3)
cla(handles.axesTheta4)
cla(handles.axesTheta1Dot)
cla(handles.axesTheta2Dot)
cla(handles.axesTheta3Dot)
cla(handles.axesTheta4Dot)
EEffectorX1 = handles.inverseAngles.EEffectorX;
EEffectorY1 = handles.inverseAngles.EEffectorY;
EEffectorZ1 = handles.inverseAngles.EEffectorZ;
pitch1 = handles.inverseAngles.EEffectorPitch;
EEffectorX2 = handles.interpolateVars.EEffectorX;
EEffectorY2 = handles.interpolateVars.EEffectorY;
EEffectorZ2 = handles.interpolateVars.EEffectorZ;
pitch2 = handles.interpolateVars.EEffectorPitch;
pmax = sqrt((EEffectorX2 - EEffectorX1)^2 + (EEffectorY2 - EEffectorY1)^2 + (EEffectorZ2 - EEffectorZ1)^2);
amax = handles.interpolateVars.Amax;
vmax = handles.interpolateVars.Vmax;
[x, y1, y2, y3] = createProfile(pmax, vmax, amax);
list = [];
listVel = [];
for i = 1:floor(length(y3) / 600)
    list = [list, y3(600*i)];
    listVel = [listVel, y2(600*i)];
end
% Taking the percentage of the path
list = list / pmax;
listVel = listVel / pmax;
hold(handles.axes1,'on');
plot(handles.axes1, x, y1);
hold(handles.axes2,'on');
plot(handles.axes2, x, y2);
hold(handles.axes3,'on');
plot(handles.axes3, x, y3);
EEffectorXPoints = [];
EEffectorYPoints = [];
EEffectorZPoints = [];
pitchPoints = [];
XVPoints = [];
YVPoints = [];
ZVPoints = [];
pitchVPoints = [];
theta1Points = [];
theta2Points = [];
theta3Points = [];
theta4Points = [];
theta1DotPoints = [];
theta2DotPoints = [];
theta3DotPoints = [];
theta4DotPoints = [];
iPoints = [];
for i = 1:floor(length(y3) / 600)
    EEffectorXPoints = [EEffectorXPoints, EEffectorX1 + (EEffectorX2 - EEffectorX1) * list(i)];
    EEffectorYPoints = [EEffectorYPoints, EEffectorY1 + (EEffectorY2 - EEffectorY1) * list(i)];
    EEffectorZPoints = [EEffectorZPoints, EEffectorZ1 + (EEffectorZ2 - EEffectorZ1) * list(i)];
    pitchPoints = [pitchPoints, pitch1 + (pitch2 - pitch1) * list(i)];
    XVPoints = [XVPoints, (EEffectorX2 - EEffectorX1) * listVel(i)];
    YVPoints = [YVPoints, (EEffectorY2 - EEffectorY1) * listVel(i)];
    ZVPoints = [ZVPoints, (EEffectorZ2 - EEffectorZ1) * listVel(i)];
    pitchVPoints = [pitchVPoints, (pitch2 - pitch1) * listVel(i)];
end
% EEffectorXPoints = linspace(EEffectorX1, EEffectorX2, 100);
% EEffectorYPoints = linspace(EEffectorY1, EEffectorY2, 100);
% EEffectorZPoints = linspace(EEffectorZ1, EEffectorZ2, 100);
% pitchPoints = linspace(pitch1, pitch2, 100)
dRoll = 0;
for i = 1:floor(length(y3) / 600)
    [theta1, theta2, theta3, theta4] = calculateInverseKinematicsPath(hObject, eventdata, handles, EEffectorXPoints(i), EEffectorYPoints(i), EEffectorZPoints(i), pitchPoints(i));
    theta1Points = [theta1Points, theta1];
    theta2Points = [theta2Points, theta2];
    theta3Points = [theta3Points, theta3];
    theta4Points = [theta4Points, theta4];
    iPoints = [iPoints, i];
    hold(handles.axesTheta1,'on');
    plot(handles.axesTheta1, iPoints, theta1Points, 'b');
    hold(handles.axesTheta2,'on');
    plot(handles.axesTheta2, iPoints, theta2Points, 'b');
    hold(handles.axesTheta3,'on');
    plot(handles.axesTheta3, iPoints, theta3Points, 'b');
    hold(handles.axesTheta4,'on');
    plot(handles.axesTheta4, iPoints, theta4Points, 'b');
    

    dX = XVPoints(i);
    dY = YVPoints(i);
    dZ = ZVPoints(i);
    dPitch = pitchVPoints(i);
    workspaceVector = [dX; dY; dZ; dPitch];
    jointspaceVector = jacobianAnalytical(theta1*pi/180,theta2*pi/180,theta3*pi/180,theta4*pi/180) * workspaceVector;
    
    theta1DotPoint = jointspaceVector(1,1);
    theta2DotPoint = jointspaceVector(2,1);
    theta3DotPoint = jointspaceVector(3,1);
    theta4DotPoint = jointspaceVector(4,1);
    theta1DotPoints = [theta1DotPoints, theta1DotPoint];
    theta2DotPoints = [theta2DotPoints, theta2DotPoint];
    theta3DotPoints = [theta3DotPoints, theta3DotPoint];
    theta4DotPoints = [theta4DotPoints, theta4DotPoint];

    hold(handles.axesTheta1Dot,'on');    
    plot(handles.axesTheta1Dot, iPoints,theta1DotPoints, 'b');
    hold(handles.axesTheta2Dot,'on');    
    plot(handles.axesTheta2Dot, iPoints,theta2DotPoints, 'b');
    hold(handles.axesTheta3Dot,'on');   
    plot(handles.axesTheta3Dot, iPoints,theta3DotPoints, 'b');
    hold(handles.axesTheta4Dot,'on');    
    plot(handles.axesTheta4Dot, iPoints,theta4DotPoints, 'b');
    pause(0.0001);

end


handles.inverseAngles.EEffectorX = EEffectorX2;
handles.inverseAngles.EEffectorY = EEffectorY2;
handles.inverseAngles.EEffectorZ = EEffectorZ2;
handles.inverseAngles.EEffectorPitch = pitch2;
set(handles.editInverseX,'String',num2str(EEffectorX2));
set(handles.editInverseY,'String',num2str(EEffectorY2));
set(handles.editInverseZ,'String',num2str(EEffectorZ2));
set(handles.editInversePitch,'String',num2str(pitch2));
set(handles.sliderInverseX, 'Value', EEffectorX2);
set(handles.sliderInverseX, 'Value', EEffectorY2);
set(handles.sliderInverseX, 'Value', EEffectorZ2);
set(handles.sliderInverseX, 'Value', pitch2);
guidata(hObject,handles)



% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
state = get(hObject,'Value');
global geometricSolve;
geometricSolve = state;
