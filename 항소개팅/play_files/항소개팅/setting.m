function varargout = setting(varargin)
% SETTING MATLAB code for setting.fig
%      SETTING, by itself, creates a new SETTING or raises the existing
%      singleton*.
%
%      H = SETTING returns the handle to a new SETTING or the handle to
%      the existing singleton*.
%
%      SETTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETTING.M with the given input arguments.
%
%      SETTING('Property','Value',...) creates a new SETTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before setting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to setting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help setting

% Last Modified by GUIDE v2.5 26-Nov-2024 20:53:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @setting_OpeningFcn, ...
                   'gui_OutputFcn',  @setting_OutputFcn, ...
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


% --- Executes just before setting is made visible.
function setting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to setting (see VARARGIN)

% Choose default command line output for setting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes setting wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = setting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on selection change in popupmenu_grade.
function popupmenu_grade_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_grade (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_grade contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_grade


% --- Executes during object creation, after setting all properties.
function popupmenu_grade_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_grade (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_day.
function popupmenu_day_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_day (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_day contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_day


% --- Executes during object creation, after setting all properties.
function popupmenu_day_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_day (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_start.
function pushbutton_start_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 1. 입력값 가져오기
filename = 'user_data.txt';
fid = fopen(filename, 'rt');
u = 1;
while ~feof(fid)   % 파일의 끝에 도달하지 않았으면 반복
    line = fgetl(fid);   % 해당 열 문자들 받기

    if line == -1   % 마지막 열일 경우 반복문 종료
        break
    end
    linedata = strsplit(line,'\t');
    user(u).stid = linedata{1}; %user.stid에 각 학번 다 저장
    u = u+1;
end
stid = user(u-1).stid; %user_want.txt의 마지막 행에 있는 학번이 접속한 사람의 학번

gender = get(handles.popupmenu_gender, 'String');
gender = gender{get(handles.popupmenu_gender, 'Value')};
major = get(handles.popupmenu_major, 'String');
major = major{get(handles.popupmenu_major, 'Value')};
grade = get(handles.popupmenu_grade, 'String');
grade = grade{get(handles.popupmenu_grade, 'Value')};
day = get(handles.popupmenu_day, 'String');
day = day{get(handles.popupmenu_day, 'Value')};

% 2. 데이터 파일에 저장
% Users의 정보를 저장할 txt파일 경로 설정
filename = 'user_prefer.txt';
if ~isfile(filename) %파일이 존재하지 않을경우 빈파일 생성
    fid = fopen(filename, 'wt'); 
fclose(fid); % 파일 바로 닫기
end
fid = fopen(filename, 'rt'); 
user_pre = {}; % 데이터 저장할 빈 배열 생성
k = 1; 
while ~feof(fid)   % 파일의 끝에 도달하지 않았으면 반복
    line = fgetl(fid);   % 해당 열 문자들 받기

    if line == -1   % 마지막 열일 경우 반복문 종료
        break
    end

    linedata = strsplit(line,'\t');   % User의 정보를 tap 을 기준으로 정보를 쪼개고 user_perfer struct에 저장
    user_pre(k).stid = linedata{1};
    user_pre(k).gender = linedata{2};
    user_pre(k).major = linedata{3};
    user_pre(k).grade = linedata{4};
    user_pre(k).day = linedata{5};

    k = k+1;  % 다음 user struct에 저장하기 위해 index 업데이트
end



% 중복된 경우 제거
if length(user_pre)>0
    index = find(strcmp({user_pre.stid},stid));
    user_pre(index) = [];
end
% 다시 새로 작성
fid = fopen(filename,"wt");
for j = 1:length(user_pre)
    fprintf(fid,'%s\t%s\t%s\t%s\t%s\n',user_pre(j).stid,user_pre(j).gender,...
        user_pre(j).major,user_pre(j).grade,user_pre(j).day);
end

% 새 정보 추가 입력
fprintf(fid,'%s\t%s\t%s\t%s\t%s\n',stid,gender,major,grade,day);

fclose(fid);
close(setting);
run matching_gui.m;







% --- Executes on selection change in popupmenu_gender.
function popupmenu_gender_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_gender (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_gender contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_gender


% --- Executes during object creation, after setting all properties.
function popupmenu_gender_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_gender (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_major.
function popupmenu_major_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_major (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_major contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_major


% --- Executes during object creation, after setting all properties.
function popupmenu_major_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_major (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
