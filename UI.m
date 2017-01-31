function varargout = UI(varargin)
% UI MATLAB code for UI.fig
%      UI, by itself, creates a new UI or raises the existing
%      singleton*.
%
%      H = UI returns the handle to a new UI or the handle to
%      the existing singleton*.
%
%      UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UI.M with the given input arguments.
%
%      UI('Property','Value',...) creates a new UI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UI

% Last Modified by GUIDE v2.5 08-Dec-2015 14:39:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UI_OpeningFcn, ...
                   'gui_OutputFcn',  @UI_OutputFcn, ...
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


% --- Executes just before UI is made visible.
function UI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UI (see VARARGIN)

% Choose default command line output for UI
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes UI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
No_dept_S=get(handles.edit1,'String');
No_dept=str2num(No_dept_S);
if isempty(No_dept)
    errordlg('Please put in numbers starting from 3');
elseif No_dept<3
    errordlg('Please put in numbers starting from 3')
else
    d=zeros(No_dept+1,No_dept);
    d1=ones(1,No_dept);
    d(No_dept+1,:)=d1;
    set(handles.uitable1,'Data',d,'ColumnEditable',true,'Columnwidth',{25});
    guidata(hObject,handles);
end;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Single_Multi=get(handles.radiobutton1,'Value');
Ord_Card=get(handles.radiobutton2,'Value');
PWE_switch=get(handles.radiobutton3,'Value');
Flow_Length=get(handles.uitable1,'Data');
Size=str2num(get(handles.edit1,'String'));
Flow=Flow_Length(1:Size,:);
Length=Flow_Length(Size+1,:);
Rows=str2num(get(handles.edit2,'String'));
Flow1=zeros(Size);
for j=1:Size-1
    for i=j+1:Size
        Flow1(j,i)=Flow(i,j)+Flow(j,i);
    end
end
if isempty(Rows)
    errordlg(strcat('Please put in numbers of rows ranging from 2~',num2str(Size-1)));
elseif Rows<2&&Single_Multi==1
    errordlg(strcat('Please put in numbers of rows ranging from 2~',num2str(Size-1)));
elseif Rows>Size-1&&Single_Multi==1
    errordlg(strcat('Please put in numbers of rows ranging from 2~',num2str(Size-1)));
else if mod(Size,Rows)~=0&&Single_Multi==1
        warn=strcat('[',num2str(Size),'] departments cannot be divided by [',num2str(Rows),...
            '] rows,please try a different number of rows.');
        msgbox(warn,'Infeasible Rows');
    elseif Rows>Size/Rows&&Single_Multi==1
        warn=strcat('[',num2str(Rows),'x',num2str(Size/Rows),'] is equal to [',num2str(Size/Rows),...
            'x',num2str(Rows),'], for better compution, we automatically set row=',num2str(Size/Rows));
        msgbox(warn,'Row-Column Exchange');
        set(handles.edit2,'String',num2str(Size/Rows));
    else if size(union(Flow(:),0),1)~=1
            if Single_Multi==0
                if Ord_Card==0
                    if PWE_switch==0
                        Layout=RBLOrdinal(Flow1,Size);
                    else Layout=RBLOrdinal(Flow1,Size);
                        [Layout,iterations]=pairwise(Flow1,Length,Size,Layout);
                    end
                else if PWE_switch==0
                        Layout=RBLCardinal(Flow1,Length,Size);
                    else Layout=RBLCardinal(Flow1,Length,Size);
                        [Layout,iterations]=pairwise(Flow1,Length,Size,Layout);
                    end
                end
                TotalFlow=totalflow(Flow1,Length,Size,Layout);
                layout=[];
                for k=1:Size
                    layout=strcat(layout,strcat(num2str(Layout(k)),','));
                end
                layout0=strcat('Layout=',layout);
                totalflow0=strcat('TotalFlow=',num2str(TotalFlow));
                if PWE_switch==0
                    str=[layout0,char(13,10)',totalflow0];
                    msgbox(str,'Results');
                else iterations0=strcat('Iterations=',num2str(iterations));
                    str=[layout0,char(13,10)',totalflow0,char(13,10)',iterations0];
                    msgbox(str,'Results');
                end
            else if size(union(Length(1,:),1),2)~=1
                    msgbox('This tool only provide all-one length solutions for Multi-Row Problem','Limited');
                else
                    [Layout0,row,column]=RBLMultiRow(Flow1,Size);
                    Layout=RBLMultiRowFurther(Layout0,Size,Rows,row,column);
                    if PWE_switch==1
                        [Layout,iterations]=pairwise(Flow1,Length,Size,Layout);
                    end
                    TotalFlow=totalflow(Flow1,Length,Size,Layout);
                    button=questdlg('Layout before folding & cutting:','Results','Next','Cancel','Next');
                    if strcmp(button,'Next')==1
                        button=questdlg(num2str(Layout0),'Results','Next','Cancel','Next');
                        if strcmp(button,'Next')==1
                            button=questdlg('Layout after folding & cutting:','Results','Next','Cancel','Next');
                            if strcmp(button,'Next')==1
                                button=questdlg(num2str(Layout),'Results','Next','Cancel','Next');
                                if strcmp(button,'Next')==1
                                    if PWE_switch==0
                                        questdlg(strcat('TotalFlow=',num2str(TotalFlow)),'Results','Cancel','Cancel');
                                    else str=[strcat('TotalFlow=',num2str(TotalFlow)),char(13,10)',strcat('Iterations=',num2str(iterations))];
                                        questdlg(str,'Results','Cancel','Cancel');
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else msgbox('Please put in Flows');
        end
    end
end


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
