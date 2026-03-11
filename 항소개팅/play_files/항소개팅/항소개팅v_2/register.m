function varargout = register(varargin)
% REGISTER MATLAB code for register.fig
%      REGISTER, by itself, creates a new REGISTER or raises the existing
%      singleton*.
%
%      H = REGISTER returns the handle to a new REGISTER or the handle to
%      the existing singleton*.
%
%      REGISTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REGISTER.M with the given input arguments.
%
%      REGISTER('Property','Value',...) creates a new REGISTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before register_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to register_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help register

% Last Modified by GUIDE v2.5 28-Nov-2024 00:32:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @register_OpeningFcn, ...
                   'gui_OutputFcn',  @register_OutputFcn, ...
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


% --- Executes just before register is made visible.
function register_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to register (see VARARGIN)

% Choose default command line output for register
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes register wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = register_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
    % 1. 입력값 가져오기
    stid = get(handles.edit_stid, 'String');
    pw = get(handles.edit_pw, 'String');
    major = get(handles.popupmenu_major, 'String');
    major = major{get(handles.popupmenu_major, 'Value')}; % 선택된 값
    gender = get(handles.popupmenu_gender, 'String');
    gender = gender{get(handles.popupmenu_gender, 'Value')};
    grade = get(handles.popupmenu_grade, 'String');
    grade = grade{get(handles.popupmenu_grade, 'Value')};
    kakao = get(handles.edit_kkid, 'String');
    if isempty(stid) || isempty(kakao) || isempty(pw)
        msgbox('모든 정보를 입력해야 합니다!');
    else
        % 2. 데이터 파일에 저장
        filename = '회원정보.txt'; % 저장할 파일 이름
        if ~isfile(filename) %파일이 존재하지 않을경우 파일 생성
            fid = fopen(filename, 'wt');
            fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\n', ...
                stid, pw, major, gender, grade, kakao);
            fclose(fid);
            msgbox('회원 정보가 저장되었습니다!', '완료');
            run login.m;
            close(register);
            close(example);
            
        else
            % Users 정보 파일 read 모드로 열기
            fid = fopen(filename, 'rt');

            % Users의 정보를 담을 빈 struct 구조 생성
            user = {};
            i = 1; % index 용 숫자

            while ~feof(fid)   % 파일의 끝에 도달하지 않았으면 반복
                line = fgetl(fid);   % 해당 열 문자들 받기

                if line == -1   % 마지막 열일 경우 반복문 종료
                    break
                end

                linedata = strsplit(line,'\t');   % User의 정보를 tap 을 기준으로 정보를 쪼개고 user struct에 저장

                user(i).stid = linedata{1};
                user(i).pw = linedata{2};
                user(i).major = linedata{3};
                user(i).gender = linedata{4};
                user(i).grade = linedata{5};
                user(i).kakao = linedata{6};

                i = i+1;  % 다음 user struct에 저장하기 위해 index 업데이트
            end

            % user.txt에 이어서 작성하기 위해 append 모드로 열기
            fid = fopen(filename, 'at');

            if numel(user) == 0   % user struct가 빈 struct면 저장된 정보가 아무것도 없으므로 정보 추가
                fprintf(fid,'\n%s\t%s\t%s\t%s\t%s\t%s\n',stid,pw,major,gender,grade,kakao);
                msgbox('회원 정보가 저장되었습니다!', '완료');
                     run login.m;
                     close(register);
                     close(example);
            else
                index = find(strcmp({user.stid},stid));  % 기존 데이터에 입력한 학번의 user가 존재하는지 확인
                if numel(index) == 0   % 입력한 학번의 user 정보가  없는 경우 추가
                    fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\n',stid,pw,major,gender,grade,kakao);
                     h=msgbox('회원 정보가 저장되었습니다!', '완료');

                     close(h);
                     close(register);
                     close(example);
                     run login.m;
                else    % 입력한 학번의 user 정보가 있는 경우 이미 가입되었다는 안내메세지 출력
                    msgbox('이미 등록되어 있는 아이디입니다.');
                    
                end
            end
            fclose(fid);
        end
    end

   
   

% hObject    handle to pushbutton6 (see GCBO)
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
close(register);
