
function varargout = cjgl(varargin)
%cjgl M-file for cjgl.fig
%      cjgl, by itself, creates a new cjgl or raises the existing
%      singleton*.
%
%      H = cjgl returns the handle to a new cjgl or the handle to
%      the existing singleton*.
%
%      cjgl('Property','Value',...) creates a new cjgl using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to cjgl_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      cjgl('CALLBACK') and cjgl('CALLBACK',hObject,...) call the
%      local function named CALLBACK in cjgl.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cjgl

% Last Modified by GUIDE v2.5 17-Jun-2012 11:24:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cjgl_OpeningFcn, ...
                   'gui_OutputFcn',  @cjgl_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before cjgl is made visible.
function cjgl_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)
% Choose default command line output for cjgl
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cjgl wait for user response (see UIRESUME)
% uiwait(handles.import_btn);


% --- Outputs from this function are returned to the command line.
function varargout = cjgl_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in search_btn.
function search_btn_Callback(hObject, eventdata, handles)
% hObject    handle to search_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file=get(handles.file_text,'String');
if isempty(file)
    msgbox('请先导入成绩表,格式为txt,否则不知道保存到哪个文件中','系统消息'); 
    return;
end
num=get(handles.add_num_edit,'String')
oraData=get(handles.output_table,'data');
if isempty(num)
    msgbox('必须填写学号','系统消息');
    return;
end
matrix=size(oraData)
rows=matrix(1)
flag=0
for i=1:rows
   flag=flag+1;
   oraData{i}
   if str2num(num)==str2num(oraData{i})
       temp=oraData(i,:)
       chinese=temp(3);
       math=temp(4);
       english=temp(5);
       total=temp(6)
       set(handles.add_name_edit,'String',temp(2))
       set(handles.add_chinese_edit,'String',num2str(chinese{1}))
       set(handles.add_math_edit,'String',num2str(math{1}))
       set(handles.add_english_edit,'String',num2str(english{1}))
       set(handles.total_edit,'String',num2str(total{1}))       
       return;
   end
end
if flag==rows
      msgbox('要查询的学号不存在','系统消息');
      set(handles.add_name_edit,'String','')
      set(handles.add_chinese_edit,'String','')
      set(handles.add_math_edit,'String','')
      set(handles.add_english_edit,'String','')
      set(handles.total_edit,'String','')   
      return;
end


% --- Executes on button press in add_btn.
function add_btn_Callback(hObject, eventdata, handles)
% hObject    handle to add_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file=get(handles.file_text,'String');
if isempty(file)
    msgbox('请先导入成绩表,格式为txt,否则不知道保存到哪个文件中','系统消息'); 
    return;
end
oraData=get(handles.output_table,'data');
num=get(handles.add_num_edit,'string');
name=get(handles.add_name_edit,'string');
chinese=get(handles.add_chinese_edit,'string');
math=get(handles.add_math_edit,'string');
english=get(handles.add_english_edit,'string');
total=str2num(chinese) + str2num(math)+str2num(english);
total=num2str(total)
if isempty(num)
    msgbox('必须填写学号','系统消息');
    return;
end
theOradata=oraData
matrix=size(theOradata)
rows=matrix(1)

for i=1:rows
    thenum=theOradata{i}
   if str2num(num)==str2num(theOradata{i})
       msgbox('学号已经存在!','系统消息');
       return;
   end
end
if isempty(name)
    msgbox('必须填写姓名','系统消息');
    return;
end
if isempty(str2num(chinese)) | str2num(chinese)<0 | str2num(chinese) >100
    msgbox('成绩必须是0-100的数值','系统消息');
    return;
end
if isempty(str2num(math)) | math<0 | math>100
    msgbox('成绩必须是0-100的数值','系统消息');
    return;
end
if isempty(str2num(english)) | english<0 | english >100
    msgbox('成绩必须是0-100的数值','系统消息');
    return;
end

        
%以上为获取添加界面上的各输入文本框中的值
newData={num,char(name),str2num(chinese),str2num(math),str2num(english),str2num(total)}
%matrixNewData=[num,name,chinese,math,english,total]
fid = fopen(file,'a');
%C = textscan(fid, '%s %s %f %f %f %f');
fprintf(fid,'%s %s %s %s %s %s\n',num,char(name),chinese,math,english,total);
fclose(fid);
msgbox('添加成功','系统消息');
newData=[newData;oraData]  
set(handles.output_table,'data',newData);





% --- Executes on button press in import_btn.
function import_btn_Callback(hObject, eventdata, handles)
% hObject    handle to import_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName PathName]=uigetfile(('*.txt'),'choose');
file=[PathName FileName];
filename=file
try
%handles.file=file;
fid = fopen(file);
C = textscan(fid, '%s %s %f %f %f %f');
fclose(fid);
if isempty(C{1}(1)) 
    msgbox('成绩表格式正确','系统消息'); 
else
    num=C{1}(1)
    num=num(1)
    name=C{2}(1)
    name=name(1)
    chinese=C{3}(1)
    math=C{4}(1)
    english=C{5}(1)
    total=C{6}(1)
    data1 = [num,name,(chinese),(math),(english),(total)];
    for i=2:length(C{1})
        num=C{1}(i)
        name=C{2}(i)
        data1=[data1;[num(1),name(1),(C{3}(i)),(C{4}(i)),(C{5}(i)),(C{6}(i))]]
    end
    set(handles.output_table,'data',data1);
end
set(handles.file_text,'String',filename);
catch
    msgbox('成绩表格式不正确','系统消息'); 
end






% --- Executes on button press in close_btn.
function close_btn_Callback(hObject, eventdata, handles)
% hObject    handle to close_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();


% --- Executes during object creation, after setting all properties.
function add_btn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to add_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in paixu_btn.
function paixu_btn_Callback(hObject, eventdata, handles)
paixu();
delete(cjgl);
% hObject    handle to paixu_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in tongji_btn.
function tongji_btn_Callback(hObject, eventdata, handles)
tongji(get(handles.output_table,'data'));

% hObject    handle to tongji_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in output_table.
function output_table_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to output_table (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function output_table_CreateFcn(hObject, eventdata, handles)
%data={'num','name','chinese','math','english','total'};
%set(hObject,'data',data);
% hObject    handle to output_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function output_table_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to output_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function add_num_edit_Callback(hObject, eventdata, handles)
% hObject    handle to add_num_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of add_num_edit as text
%        str2double(get(hObject,'String')) returns contents of add_num_edit as a double


% --- Executes during object creation, after setting all properties.
function add_num_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to add_num_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function add_name_edit_Callback(hObject, eventdata, handles)
% hObject    handle to add_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of add_name_edit as text
%        str2double(get(hObject,'String')) returns contents of add_name_edit as a double


% --- Executes during object creation, after setting all properties.
function add_name_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to add_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function add_math_edit_Callback(hObject, eventdata, handles)
% hObject    handle to add_math_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of add_math_edit as text
%        str2double(get(hObject,'String')) returns contents of add_math_edit as a double


% --- Executes during object creation, after setting all properties.
function add_math_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to add_math_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function add_english_edit_Callback(hObject, eventdata, handles)
% hObject    handle to add_english_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of add_english_edit as text
%        str2double(get(hObject,'String')) returns contents of add_english_edit as a double


% --- Executes during object creation, after setting all properties.
function add_english_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to add_english_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function add_chinese_edit_Callback(hObject, eventdata, handles)
% hObject    handle to add_chinese_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of add_chinese_edit as text
%        str2double(get(hObject,'String')) returns contents of add_chinese_edit as a double


% --- Executes during object creation, after setting all properties.
function add_chinese_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to add_chinese_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in modify_btn.
function modify_btn_Callback(hObject, eventdata, handles)
file=get(handles.file_text,'String');
if isempty(file)
    msgbox('请先导入成绩表,格式为txt,否则不知道保存到哪个文件中','系统消息'); 
    return;
end

oraData=get(handles.output_table,'data');
num=get(handles.add_num_edit,'String');
name=get(handles.add_name_edit,'String');
chinese=get(handles.add_chinese_edit,'String')
math=get(handles.add_math_edit,'String')
english=get(handles.add_english_edit,'String')
if isempty(name) 
    msgbox('必须填写姓名','系统消息');
    return;
end
if isempty(chinese) | str2num(chinese)<0 | str2num(chinese) >100
    msgbox('成绩必须是0-100的数值','系统消息');
    return;
end
if isempty(math) | math<0 | math>100
    msgbox('成绩必须是0-100的数值','系统消息');
    return;
end
if isempty(english) | english<0 | english >100
    msgbox('成绩必须是0-100的数值','系统消息');
    return;
end    
if isempty(num)
    msgbox('必须填写学号','系统消息');
    return;
end
total=str2num(chinese) + str2num(math)+str2num(english)
total=num2str(total)
newOradata=oraData
matrix=size(newOradata)
rows=matrix(1)

flag=0;
for i=1:rows
    %thenum=theOradata{i}
    flag=flag+1
    temp=newOradata(i,:)
   if str2num(num)==str2num(newOradata{i})
        newOradata(i,:)=[]
        break;
   end
   if flag==rows
        msgbox('要修改的学号不存在','系统消息');
        return;
    end
end 
%以上为获取添加界面上的各输入文本框中的值
newData={num,char(name),str2num(chinese),str2num(math),str2num(english),str2num(total)}
%matrixNewData=[num,name,chinese,math,english,total]
%C = textscan(fid, '%s %s %f %f %f %f');
msgbox('修改成功','系统消息');
newData=[newData;newOradata]  
fid = fopen(file,'w');
matrix=size(newData)
rows=matrix(1)
for i=1:rows
    temp=newData(i,:)
    num=temp(1)
    name=temp(2)
    chinese=temp(3)
    math=temp(4)
    english=temp(5)
    total=temp(6)
    fprintf(fid,'%s %s %s %s %s %s\r\n',char(num),char(name),num2str(chinese{1}),num2str(math{1}),num2str(english{1}),num2str(total{1}))
end
fclose(fid);
set(handles.output_table,'data',newData);
% hObject    handle to modify_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in delete_btn.
function delete_btn_Callback(hObject, eventdata, handles)
file=get(handles.file_text,'String');
if isempty(file)
    msgbox('请先导入成绩表,格式为txt,否则不知道保存到哪个文件中','系统消息'); 
    return;
end
oraData=get(handles.output_table,'data');
num=get(handles.add_num_edit,'string');
if isempty(num)
    msgbox('必须填写学号','系统消息');
    return;
end
newOradata=oraData
matrix=size(newOradata)
rows=matrix(1)

flag=0;
for i=1:rows
    %thenum=theOradata{i}
    flag=flag+1
    temp=newOradata(i,:)
   if str2num(num)==str2num(newOradata{i})
        newOradata(i,:)=[]
        break;
   end
   if flag==rows
        msgbox('要修改的学号不存在','系统消息');
        return;
    end
end

msgbox('删除成功','系统消息');
set(handles.add_num_edit,'String','')
set(handles.add_name_edit,'String','')
set(handles.add_chinese_edit,'String','')
set(handles.add_math_edit,'String','')
set(handles.add_english_edit,'String','')
set(handles.total_edit,'String','') 
fid = fopen(file,'w');
matrix=size(newOradata)
rows=matrix(1)
for i=1:rows
    temp=newOradata(i,:)
    num=temp(1)
    name=temp(2)
    chinese=temp(3)
    math=temp(4)
    english=temp(5)
    total=temp(6)
    fprintf(fid,'%s %s %s %s %s %s\r\n',char(num),char(name),num2str(chinese{1}),num2str(math{1}),num2str(english{1}),num2str(total{1}))
end
fclose(fid);
set(handles.output_table,'data',newOradata);
% hObject    handle to delete_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function total_edit_Callback(hObject, eventdata, handles)
% hObject    handle to total_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_edit as text
%        str2double(get(hObject,'String')) returns contents of total_edit as a double


% --- Executes during object creation, after setting all properties.
function total_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in paixu_popup.
function paixu_popup_Callback(hObject, eventdata, handles)
% hObject    handle to paixu_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
oraData=get(handles.output_table,'data');
matrix=size(oraData)
rows=matrix(1)
row1=oraData(1,:)
data1=[row1(1),row1(2),(row1(3)),(row1(4)),(row1(5)),(row1(6))]
for i=2:rows
    temp=oraData(i,:)
    num=temp(1)
    name=temp(2)
    chinese=temp(3)
    math=temp(4)
    english=temp(5)
    total=temp(6)
    data1=[data1;[num,name,(chinese),(math),(english),(total)]]
end
total_paixu = sortrows(data1,-6);
chinese_paixu  = sortrows(data1,-3);
math_paixu  = sortrows(data1,-4);
english_paixu  = sortrows(data1,-5);
popup_sel_index = get(handles.paixu_popup, 'Value');
switch  popup_sel_index
    case 1
       set(handles.output_table,'data',total_paixu); 
    case 2
        set(handles.output_table,'data',chinese_paixu); 
    case 3
        set(handles.output_table,'data',math_paixu); 
    case 4
        set(handles.output_table,'data',english_paixu); 
end


% Hints: contents = cellstr(get(hObject,'String')) returns paixu_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from paixu_popup


% --- Executes during object creation, after setting all properties.
function paixu_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to paixu_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
