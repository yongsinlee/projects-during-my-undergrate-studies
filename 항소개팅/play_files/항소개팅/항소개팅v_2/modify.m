function varargout = modify(varargin)
% MODIFY MATLAB code for modify.fig
%      MODIFY, by itself, creates a new MODIFY or raises the existing
%      singleton*.
%
%      H = MODIFY returns the handle to a new MODIFY or the handle to
%      the existing singleton*.
%
%      MODIFY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODIFY.M with the given input arguments.
%
%      MODIFY('Property','Value',...) creates a new MODIFY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before modify_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to modify_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help modify

% Last Modified by GUIDE v2.5 03-Dec-2024 19:02:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @modify_OpeningFcn, ...
                   'gui_OutputFcn',  @modify_OutputFcn, ...
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


% --- Executes just before modify is made visible.
function modify_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to modify (see VARARGIN)

% Choose default command line output for modify
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes modify wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = modify_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_stid_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stid as text
%        str2double(get(hObject,'String')) returns contents of edit_stid as a double


% --- Executes during object creation, after setting all properties.
function edit_stid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pw as text
%        str2double(get(hObject,'String')) returns contents of edit_pw as a double


% --- Executes during object creation, after setting all properties.
function edit_pw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_kkid_Callback(hObject, eventdata, handles)
% hObject    handle to edit_kkid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_kkid as text
%        str2double(get(hObject,'String')) returns contents of edit_kkid as a double


% --- Executes during object creation, after setting all properties.
function edit_kkid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_kkid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_finish.
function pushbutton_finish_Callback(hObject, eventdata, handles)
% 1. 입력값 가져오기
pw = get(handles.edit_pw, 'String');
major = get(handles.popupmenu_major, 'String');
major = major{get(handles.popupmenu_major, 'Value')}; % 선택된 값
gender = get(handles.popupmenu_gender, 'String');
gender = gender{get(handles.popupmenu_gender, 'Value')};
grade = get(handles.popupmenu_grade, 'String');
grade = grade{get(handles.popupmenu_grade, 'Value')};
kakao = get(handles.edit_kkid, 'String');
if isempty(kakao) || isempty(pw)
    msgbox('모든 정보를 입력해야 합니다!');
else
    % 2. 데이터 파일에 저장
    % User data base path
    filename = '..\data\database\user.txt';
    fid = fopen(filename,'rt');
    i = 1;
    usernew = {}; % 기존 데이터 담을 빈 struct

    while ~feof(fid)
        line = fgetl(fid);

        if line == -1
            break
        end

        linedata = strsplit(line,'\t');   % User의 정보를 tap 을 기준으로 정보를 쪼개고 user struct에 저장
        usernew(i).stid = linedata{1};
        usernew(i).pw = linedata{2};
        usernew(i).major = linedata{3};
        usernew(i).gender = linedata{4};
        usernew(i).grade = linedata{5};
        usernew(i).kakao = linedata{6};

        i = i +1;
    end
    fclose(fid);

    userdata_filename = '..\data\database\user_data.txt';
    fid = fopen(userdata_filename,'rt');
    %로그인 학번 가져오기
    if exist(userdata_filename, 'file') % user_data.txt 파일 존재 여부 확인
        fid = fopen(userdata_filename, 'rt'); % 읽기 모드로 열기
        stid = strtrim(fgetl(fid)); % 첫 줄에서 학번 읽기
        fclose(fid);
    else
        errordlg('user_data.txt 파일이 없습니다. 먼저 로그인하세요.', '오류');
        return;
    end 

    % 학번이 같은 로그인한 학번과 같은 경우 해당하는 index 저장 (1건만 존재)
    index = find(strcmp({usernew.stid},stid));;
    usernew(index) = []; % 중복되는 index 삭제

    %   정보 DB에 새로 입력
    fid = fopen(filename,'wt');
    % 새 유저 DB 파일 작성
    for k = 1:length(usernew)
        fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\n',usernew(k).stid,usernew(k).pw,...
            usernew(k).major,usernew(k).gender, usernew(k).grade, ...
            usernew(k).kakao);
        disp('회원 정보가 수정되었습니다.')
    end

    % 수정된 유저 정보 추가 작성
    fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\n',stid,pw,major,gender,grade,kakao);
    fclose(fid);
    run mainhome.m;
    close(modify);
end

   
   

% hObject    handle to pushbutton_finish (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(modify);
