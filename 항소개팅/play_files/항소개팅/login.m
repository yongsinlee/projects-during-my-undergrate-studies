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
    filename = 'user.txt';
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
% 
% 
%         %=========================================================================================================
%         %=========================================================================================================
% %   1. 새 csv 파일 데이터 txt 파일에 저장
% 
% 
% % 현재 디렉토리에서 파일 생성
% % fid=fopen('user_timetable.txt','a');
% % fclose(fid);
% filename = fullfile(pwd, 'user_timetable.txt');
% 
% % CSV 파일 목록 가져오기
% usertracks = pwd; % 현재 디렉토리
% files = dir(fullfile(usertracks, '*.csv'));
% 
% disp('찾은 CSV 파일 목록:');
% disp({files.name}); % CSV 파일 목록 출력
% 
% % 파일 열기 (append 모드)
% fid = fopen(filename, 'at');
% if fid == -1
%     error('user_timetable.txt 파일을 열 수 없습니다. 경로와 권한을 확인하세요.');
% end
% 
% % 각 CSV 파일 처리
% for i = 1:length(files)
%     % 파일명 가져오기
%     filenames = files(i).name;
% 
%     % 파일명의 '_' 위치 찾기
%     underindex = find(filenames == '_', 1);
% 
%     % 잘못된 파일 형식 무시
%     if isempty(underindex)
%         disp(['잘못된 파일 형식: ', filenames]);
%         continue;
%     end
% 
%     % 학번과 요일 추출
%     id = filenames(1:underindex-1);
%     day = filenames(underindex+1:underindex+3);
% 
%     disp(['처리 중인 파일: ', filenames]);
%     disp(['추출된 학번: ', id, ', 추출된 요일: ', day]);
% 
%     % 학번별 폴더 생성
%     folder_path = fullfile(pwd, id); % 학번 폴더 경로
%     if ~exist(folder_path, 'dir')
%         mkdir(folder_path); % 폴더가 없으면 생성
%         disp(['폴더 생성: ', folder_path]);
%     end
% 
%     % CSV 파일을 해당 학번 폴더로 이동
%     new_file_path = fullfile(folder_path, filenames); % 새 경로
%     movefile(fullfile(usertracks, filenames), new_file_path);
%     disp(['파일 이동: ', filenames, ' -> ', folder_path]);
% 
%     % 시간표 데이터 생성
%     try
%         % 새 경로에서 파일 처리
%         course = creatcourse(new_file_path); % 코스 데이터 생성
%         timetable = coursetotimetable(course); % 시간표 데이터 변환
%         timetext = timetabletotext(timetable); % 텍스트 시간표 변환
% 
%         % 데이터가 올바른지 확인
%         if length(timetext) < 7
%             warning('timetext 데이터가 충분하지 않습니다: %s', filenames);
%             continue;
%         end
% 
%         % user_timetable.txt에 데이터 저장
%         fprintf(fid, '%s\t%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n', id, day, timetext(1:7));
%         disp(['저장된 데이터: ', sprintf('%s\t%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d', id, day, timetext(1:7))]);
%     catch ME
%         warning('파일 %s 처리 중 오류 발생: %s', new_file_path, ME.message);
%     end
% end
% 
% % 파일 닫기
% fclose(fid);
% disp('user_timetable.txt 파일 생성 완료.');
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% %   2. 중복되는 데이터 (학번+요일 동일)의 경우 최신 데이터로 업데이트
% 
% 
% % 중복 삭제 
% fid = fopen(filename,'rt');
% i = 1;
% idlist = {};
% usertable = {};
% while ~feof(fid)
%     line = fgetl(fid);
%     if line == -1
%         break
%     end
% 
%     linedata = strsplit(line,'\t');
%     usertable(i).id = linedata{1};
%     usertable(i).day = linedata{2};
%     usertable(i).table = linedata(3:9);
%     % 학번, 요일이 같은 경우 비교를 위해 문자열로 저장
%     usertable(i).iday = sprintf('%s%s',usertable(i).id,usertable(i).day);
%     % 학번, 요일이 같은 데이터인 경우 해당하는 index 추가
%     if ~ismember(usertable(i).iday,idlist)
%         idlist{end+1} =  usertable(i).iday;
%     end
%     i = i +1;
% end
% 
% for j = 1:length(idlist)
%     index = find(strcmp({usertable.iday},idlist(j)));
%     index = index(1:end-1);
%     usertable(index) = []; % 중복되는 index 중 마지막(최신 데이터) 를 제외하고 삭제
% end
% 
% fid = fopen(filename,'wt');
% % 새 시간표 파일 작성
% for k = 1:length(usertable)
%     fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n',usertable(k).id,usertable(k).day,...
%         usertable(k).table{1},usertable(k).table{2}, usertable(k).table{3}, ...
%         usertable(k).table{4}, usertable(k).table{5}, usertable(k).table{6},usertable(k).table{7});
% end
% 
% fclose(fid);
%         %=========================================================================================================
%         %=========================================================================================================
%         userdata_filename = 'user_want.txt';
% 
% % 파일이 존재하는지 확인
% if exist(userdata_filename, 'file')
%     % 파일 읽기 모드로 열기
%     fid = fopen(userdata_filename, 'rt');
%     existing_data = textscan(fid, '%s', 'Delimiter', '\n'); % 기존 데이터 읽기
%     fclose(fid);
% 
%     % 기존 데이터에서 중복 확인
%     if ismember(stid, existing_data{1})
%         disp('값이 이미 존재합니다. 파일에 저장하지 않습니다.');
%          % 이미 존재하면 함수 종료
%          str=questdlg('개인정보 및 위치정보 제공에 동의하시나요','','No','Yes','Yes');
%         if strcmp(str,'Yes')
% 
%         run time_table.m;
%         close(login);
%         close(example);
%         msgbox('로그인 성공!', '성공');
%         else
%             close(login);
%         close(example);
%         end
%         return;
%     end
% else
%     % 파일이 없으면 빈 데이터로 초기화
%     existing_data = {{}};
% end
% 
% % 파일을 추가 모드로 열기
% fid = fopen(userdata_filename, 'at');
% fprintf(fid, '%s\n', stid); % stid를 파일에 새로운 줄로 추가
% fclose(fid);
% 
% disp('값이 파일에 저장되었습니다.');
%         %=========================================================================================================
%         %=========================================================================================================
        
        %str=questdlg('개인정보 및 위치정보 제공에 동의하십니까?','','No','Yes','Yes');
        %if strcmp(str,'Yes')

        
        %close(login);
        %close(example);
       
        
        h=msgbox('로그인 성공!', '성공');
        uiwait(h)
        close(login);
        close(example);
        time_table;
        
    else
        h = msgbox('학번 또는 비밀번호가 잘못되었습니다.', '오류', 'error');
        uiwait(h)
    end
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(login);
end
