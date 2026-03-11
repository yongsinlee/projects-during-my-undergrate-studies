function varargout = login(varargin)
%LOGIN MATLAB code file for login.fig
%      LOGIN, by itself, creates a new LOGIN or raises the existing
%      singleton*.
%
%      H = LOGIN returns the handle to a new LOGIN or the handle to
%      the existing singleton*.
%
%      LOGIN('Property','Value',...) creates a new LOGIN using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to login_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      LOGIN('CALLBACK') and LOGIN('CALLBACK',hObject,...) call the
%      local function named CALLBACK in LOGIN.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help login

% Last Modified by GUIDE v2.5 28-Nov-2024 00:37:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @login_OpeningFcn, ...
                   'gui_OutputFcn',  @login_OutputFcn, ...
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
end
% End initialization code - DO NOT EDIT


% --- Executes just before login is made visible.
function login_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for login
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes login wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = login_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


function edit_stid_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stid as text
%        str2double(get(hObject,'String')) returns contents of edit_stid as a double
end

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
end

function edit_pw_Callback(hObject, eventdata, handles)
end


function edit_pw_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end

function pushbutton2_Callback(hObject, eventdata, handles)
    % 1. 입력값 가져오기
    stid = get(handles.edit_stid, 'String');
    pw = get(handles.edit_pw, 'String');
    

    % 2. 파일에서 데이터 읽기
    % Users의 정보를 저장할 txt파일 경로 설정
    filename = '회원정보.txt';
    fid=fopen(filename,'a');
    fclose(fid);

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

        index = find(strcmp({stid},stid));  % 기존 데이터에 입력한 학번의 user가 존재하는지 확인
        linedata = strsplit(line,'\t');   % User의 정보를 tap 을 기준으로 정보를 쪼개고 user struct에 저장

        user(i).stid = linedata{1};
        user(i).pw = linedata{2};
        user(i).major = linedata{3};
        user(i).gender = linedata{4};
        user(i).grade = linedata{5};
        user(i).kakao = linedata{6};

        i = i+1;  % 다음 user struct에 저장하기 위해 index 업데이트
    end
    

     % 3. 입력값 검증
    login_success = false; % 로그인 성공 여부 플래그

    for j = 1:length(user) % 모든 사용자 정보 확인
        if strcmp(stid, user(j).stid) && strcmp(pw, user(j).pw)
            login_success = true;
            break;
        end
    end

    % 4. 결과 메시지 출력
    if login_success
        
        
         % user_data.txt에 새로운 학번 저장
         
        userdata_filename = 'user_data.txt';
        % 기존 내용을 지우고 새로운 학번을 저장
        fid = fopen(userdata_filename, 'wt'); % 쓰기 모드로 열기 (기존 내용 삭제)
        if fid == -1
            errordlg('user_data.txt 파일을 열 수 없습니다. 파일 경로를 확인하세요.', '파일 오류');
            return;
        end
        fprintf(fid, '%s\t', stid); % 새로운 학번 추가
        fprintf(fid, '%s\t', pw);
        fprintf(fid, '%s\t', user(j).major);
        fprintf(fid, '%s\t', user(j).gender);
        fprintf(fid, '%s\t', user(j).grade);
        fprintf(fid, '%s', user(j).kakao);


        fclose(fid);
        disp('user_data.txt 파일이 업데이트되었습니다.');
        str=questdlg('개인정보 및 위치정보 제공에 동의하시나요','','No','Yes','Yes');
        if strcmp(str,'Yes')

        
        close(example);
        
        close(login);
        
        time_table;
        
        h=msgbox('로그인 성공!', '성공');
        else
            
        close(example);
        close(login);
        end
    else
        msgbox('학번 또는 비밀번호가 잘못되었습니다.', '오류', 'error');

    end
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(login);
end
