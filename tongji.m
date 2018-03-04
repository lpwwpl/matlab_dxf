function varargout = tongji(varargin)
% TONGJI M-file for tongji.fig
%      TONGJI, by itself, creates a new TONGJI or raises the existing
%      singleton*.
%
%      H = TONGJI returns the handle to a new TONGJI or the handle to
%      the existing singleton*.
%
%      TONGJI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TONGJI.M with the given input arguments.
%
%      TONGJI('Property','Value',...) creates a new TONGJI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tongji_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tongji_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tongji

% Last Modified by GUIDE v2.5 17-Jun-2012 17:21:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tongji_OpeningFcn, ...
                   'gui_OutputFcn',  @tongji_OutputFcn, ...
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


% --- Executes just before tongji is made visible.
function tongji_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tongji (see VARARGIN)

% Choose default command line output for tongji
handles.output = hObject;
if isempty(varargin)
    msgbox('该界面需要由主界面的数据作为输入执行','系统消息');
    return;
end
handles.in1=varargin{1}

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tongji wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tongji_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function total_bar_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in bar_btn.
function bar_btn_Callback(hObject, eventdata, handles)
try
data=handles.in1
catch
    msgbox('无数据，或着需要由主界面的数据作为输入执行','系统消息');
    return;
end


total_y=[0 0 0 0 0];
chinese_y=[0 0 0 0 0];
math_y=[0 0 0 0 0];
english_y=[0 0 0 0 0];
%为直方图的绘制进行数据累加
matrix=size(data)
rows=matrix(1)
for i=1:rows
    temp=data(i,:)
    total=temp(6)
    chinese=temp(3)
    math=temp(4)
    english=temp(5)
    if total{1}<180
        total_y(1)=total_y(1)+1;
    elseif total{1}<210
        total_y(2)=total_y(2)+1; 
    elseif total{1}<240
        total_y(3)=total_y(3)+1; 
    elseif total{1}<270
       total_y(4)=total_y(4)+1; 
    else
       total_y(5)=total_y(5)+1; 
    end
    
    if chinese{1}<60
        chinese_y(1)=chinese_y(1)+1;
    elseif chinese{1}<70
        chinese_y(2)=chinese_y(2)+1; 
    elseif chinese{1}<80
        chinese_y(3)=chinese_y(3)+1; 
    elseif chinese{1}<90
        chinese_y(4)=chinese_y(4)+1; 
    else
        chinese_y(5)=chinese_y(5)+1; 
    end
    
    if math{1}<60
        math_y(1)=math_y(1)+1;
    elseif math{1}<70
        math_y(2)=math_y(2)+1; 
    elseif math{1}<80
        math_y(3)=math_y(3)+1; 
    elseif math{1}<90
        math_y(4)=math_y(4)+1; 
    else
        math_y(5)=math_y(5)+1; 
    end
    
    if english{1}<60
        english_y(1)=english_y(1)+1;
    elseif english{1}<70
        english_y(2)=english_y(2)+1; 
    elseif english{1}<80
        english_y(3)=english_y(3)+1; 
    elseif english{1}<90
        english_y(4)=english_y(4)+1; 
    else
        english_y(5)=english_y(5)+1; 
    end
end
axes(handles.total_bar);
total_x=[180 210 240 270 300];
bar(total_x,total_y);

axes(handles.chinese_bar);
chinese_x=[60 70 80 90 100];
bar(chinese_x,chinese_y);

axes(handles.math_bar);
math_x=[60 70 80 90 100];
bar(math_x,math_y);

axes(handles.english_bar);
english_x=[60 70 80 90 100];
bar(english_x,english_y);


% hObject    handle to bar_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
