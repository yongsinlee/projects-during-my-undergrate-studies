function varargout = time_table(varargin)
%TIME_TABLE MATLAB code file for time_table.fig
%      TIME_TABLE, by itself, creates a new TIME_TABLE or raises the existing
%      singleton*.
%
%      H = TIME_TABLE returns the handle to a new TIME_TABLE or the handle to
%      the existing singleton*.
%
%      TIME_TABLE('Property','Value',...) creates a new TIME_TABLE using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to time_table_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      TIME_TABLE('CALLBACK') and TIME_TABLE('CALLBACK',hObject,...) call the
%      local function named CALLBACK in TIME_TABLE.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help time_table
% Last Modified by GUIDE v2.5 04-Dec-2024 05:04:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @time_table_OpeningFcn, ...
                   'gui_OutputFcn',  @time_table_OutputFcn, ...
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
end

% --- Executes just before time_table is made visible.
function time_table_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)
for i=1:5
    for j=1:7
        Cell_data{j,i}='';
    end
    switch i
        case 1
            Table.Properties.VariableNames{1,i}='월';
        case 2
            Table.Properties.VariableNames{1,i}='화';
        case 3
            Table.Properties.VariableNames{1,i}='수';
        case 4
            Table.Properties.VariableNames{1,i}='목';
        case 5
            Table.Properties.VariableNames{1,i}='금';
    end

    
end
set(handles.uitable1,'Data',Cell_data);
set(handles.uitable1,'ColumnName',Table.Properties.VariableNames);


%텍스트수정
filename='user_data.txt';
fid=fopen(filename,'rt');
line = fgetl(fid);
linedata = strsplit(line,'\t');
handles.text5.String{1,1}='Profile';
handles.text5.String{2,1}=sprintf('Id    : %s',linedata{1});
handles.text5.String{3,1}=sprintf('Major : %s',linedata{3});
handles.text5.String{4,1}=sprintf('Sex   : %s',linedata{4});
handles.text5.String{5,1}=sprintf('Grade : %s',linedata{5});
handles.text5.String{6,1}=sprintf('Kakao : %s',linedata{6});
handles.text5.String{7,1}=sprintf('hobby : matlab');
handles.text5.String{8,1}=sprintf('favorite class : Hanggong_software');
handles.text5.String{9,1}=sprintf('appearance score : ,,,');
handles.text5.String{10,1}=sprintf('whether : heavy snow\nstatus : sleepy\nClass Score : A+');
fclose(fid);
% Choose default command line output for time_table
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes time_table wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = time_table_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure


varargout{1} = handles.output;
end

% --- Executes on button press in tt_update.
function tt_update_Callback(hObject, eventdata, handles)
    url = 'https://drive.google.com/drive/folders/1-RkRmTVojiyYxKWEizthRnvnTj9ZomYH?usp=sharing'; % 시간표 업로드 URL
    web(url, '-browser'); % 기본 브라우저에서 열기
end


% --- Executes on button press in showtt.
function showtt_Callback(hObject, eventdata, handles)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  user_timetable.m  
%
%  Users가 특정 폴더에 업로드 한 GPS tracking data(.csv)를 시간표로 변환                                                                        
%   1. 새 csv 파일 데이터 txt 파일에 저장
%   2. 중복되는 데이터 (학번+요일 동일)의 경우 최신 데이터로 업데이트
%   3. 저장한 csv 파일 유저 별 폴더로 분류
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=waitbar(0,'Updating....(잠시만 기다려주세요)');

%   1. 새 csv 파일 데이터 txt 파일에 저장


% 현재 디렉토리에서 파일 생성
filename = fullfile(pwd, 'user_timetable.txt');

% CSV 파일 목록 가져오기
usertracks = pwd; % 현재 디렉토리
files = dir(fullfile(usertracks, '*.csv'));

disp('찾은 CSV 파일 목록:');
disp({files.name}); % CSV 파일 목록 출력

% 파일 열기 (append 모드)
fid = fopen(filename, 'at');
if fid == -1
    error('user_timetable.txt 파일을 열 수 없습니다. 경로와 권한을 확인하세요.');
end

% 각 CSV 파일 처리
for i = 1:length(files)
    % 파일명 가져오기
    filenames = files(i).name;

    % 파일명의 '_' 위치 찾기
    underindex = find(filenames == '_', 1);

    % 잘못된 파일 형식 무시
    if isempty(underindex)
        disp(['잘못된 파일 형식: ', filenames]);
        continue;
    end

    % 학번과 요일 추출
    id = filenames(1:underindex-1);
    day = filenames(underindex+1:underindex+3);

    disp(['처리 중인 파일: ', filenames]);
    disp(['추출된 학번: ', id, ', 추출된 요일: ', day]);

    % 학번별 폴더 생성
    folder_path = fullfile(pwd, id); % 학번 폴더 경로
    if ~exist(folder_path, 'dir')
        mkdir(folder_path); % 폴더가 없으면 생성
        disp(['폴더 생성: ', folder_path]);
    end

    % CSV 파일을 해당 학번 폴더로 이동
    new_file_path = fullfile(folder_path, filenames); % 새 경로
    movefile(fullfile(usertracks, filenames), new_file_path);
    disp(['파일 이동: ', filenames, ' -> ', folder_path]);

    % 시간표 데이터 생성
    try
        % 새 경로에서 파일 처리
        course = creatcourse(new_file_path); % 코스 데이터 생성
        timetable = coursetotimetable(course); % 시간표 데이터 변환
        timetext = timetabletotext(timetable); % 텍스트 시간표 변환

        % 데이터가 올바른지 확인
        if length(timetext) < 7
            warning('timetext 데이터가 충분하지 않습니다: %s', filenames);
            continue;
        end

        % user_timetable.txt에 데이터 저장
        fprintf(fid, '%s\t%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n', id, day, timetext(1:7));
        disp(['저장된 데이터: ', sprintf('%s\t%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d', id, day, timetext(1:7))]);
    catch ME
        warning('파일 %s 처리 중 오류 발생: %s', new_file_path, ME.message);
    end
end

% 파일 닫기
fclose(fid);
disp('user_timetable.txt 파일 생성 완료.');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%   2. 중복되는 데이터 (학번+요일 동일)의 경우 최신 데이터로 업데이트


% 중복 삭제 
fid = fopen(filename,'rt');
i = 1;
idlist = {};
usertable={};
while ~feof(fid)
    line = fgetl(fid);
    if line == -1
        break
    end
    
    linedata = strsplit(line,'\t');
    usertable(i).id = linedata{1};
    usertable(i).day = linedata{2};
    usertable(i).table = linedata(3:9);
    % 학번, 요일이 같은 경우 비교를 위해 문자열로 저장
    usertable(i).iday = sprintf('%s%s',usertable(i).id,usertable(i).day);
    % 학번, 요일이 같은 데이터인 경우 해당하는 index 추가
    if ~ismember(usertable(i).iday,idlist)
        idlist{end+1} =  usertable(i).iday;
    end
    i = i +1;
end

for j = 1:length(idlist)
    index = find(strcmp({usertable.iday},idlist(j)));
    index = index(1:end-1);
    usertable(index) = []; % 중복되는 index 중 마지막(최신 데이터) 를 제외하고 삭제
end

fid = fopen(filename,'wt');
% 새 시간표 파일 작성
for k = 1:length(usertable)
    fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n',usertable(k).id,usertable(k).day,...
        usertable(k).table{1},usertable(k).table{2}, usertable(k).table{3}, ...
        usertable(k).table{4}, usertable(k).table{5}, usertable(k).table{6},usertable(k).table{7});
end

fclose(fid);





%=========================================================================================================
%=========================================================================================================
%=========================================================================================================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  timedatatotable.m (function)
%   
%  아이디 받아서 해당 아이디 시간표 table 만들기
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 시간표 데이터를 읽어와 UITable에 표시하는 코드

   % 현재 디렉토리의 시간표 파일
    filename = 'user_timetable.txt';

    % 파일 존재 여부 확인
    if ~exist(filename, 'file')
        errordlg('user_timetable.txt 파일이 존재하지 않습니다.', '파일 오류');
        return;
    end

    % 파일 열기
    fid = fopen(filename, 'rt');
    if fid == -1
        error('파일 %s을(를) 열 수 없습니다. 경로와 권한을 확인하세요.', filename);
    end

    % 데이터를 저장할 구조체 배열 초기화
    user_timetable = {};
    i = 1;

    % 행별로 파일 읽기
    while true
    line = fgetl(fid);

    % 파일 끝에 도달했거나 비어 있는 경우 루프 종료
    if line == -1
        break;
    end

    % 빈 줄 무시
    if isempty(line)
        continue;
    end

    % 나머지 처리 로직
    linedata = strsplit(line, '\t');

    % 구조체에 데이터 저장
    user_timetable(i).id = linedata{1};
    user_timetable(i).day = linedata{2};
    for j = 1:7
        user_timetable(i).(['class', num2str(j)]) = str2double(linedata{2 + j});
    end

    i = i + 1;
    end

    % 파일 닫기
    fclose(fid);

    % 로그인한 학번 가져오기
    userdata_filename = 'user_data.txt';
    if exist(userdata_filename, 'file')
        fid = fopen(userdata_filename, 'rt');
        user_lines = textscan(fid, '%s', 'Delimiter', '\n');
        fclose(fid);
        
        id_line = user_lines{1}{end}; % 마지막 학번 (로그인 학번)
        id_split= strsplit(id_line,'\t');
        id=id_split{1,1};
    else
        errordlg('user_data.txt 파일이 없습니다. 먼저 로그인하세요.', '오류');
        return;
    end

    % 학번 필터링
    
    c=0;
    ididx=[];
    for i=1:length(user_timetable)
        if strcmp(user_timetable(i).id,id)
            ididx=[ididx; i];
            c=c+1;
        end
    end
    if c==0;
        close(h);
        errordlg('해당 학번의 시간표 데이터가 없습니다.', '오류');
        
        return;
    end

    user_timetable = user_timetable(ididx);

    % 강의실 이름
    classname = ["충무관", "다산관", "학술정보원", "영실관", "우정당", "박물관", "새날관", "용덕관", ...
                 "진관홀", "광개토관", "세종관", "군자관", "학생회관", "집현관", "대양홀", "이당관", "애지헌"];

    % 요일 및 시간표 초기화
    class = {'1교시', '2교시', '3교시', '4교시', '5교시', '6교시', '7교시'}';
    mon = strings(7, 1);
    tue = strings(7, 1);
    wen = strings(7, 1);
    thu = strings(7, 1);
    fri = strings(7, 1);

    % 각 요일에 대한 시간표 설정
    for i = 1:length(user_timetable)
        switch user_timetable(i).day
            case 'mon'
                dayArray = mon;
            case 'tue'
                dayArray = tue;
            case 'wen'
                dayArray = wen;
            case 'thu'
                dayArray = thu;
            case 'fri'
                dayArray = fri;
        end

        for j = 1:7
            classNum = user_timetable(i).(['class', num2str(j)]);
            if classNum == 0
                dayArray(j) = "";
            else
                dayArray(j) = classname(classNum);
            end
        end

        switch user_timetable(i).day
            case 'mon'
                mon = dayArray;
            case 'tue'
                tue = dayArray;
            case 'wen'
                wen = dayArray;
            case 'thu'
                thu = dayArray;
            case 'fri'
                fri = dayArray;
        end
    end
close(h);
% 테이블 생성 (Class 열 제거)
Table = table(mon, tue, wen, thu, fri, ...
    'VariableNames', {'월', '화', '수', '목', '금'});

% 데이터를 셀 배열로 변환
cell_data = table2cell(Table);

% 셀 데이터에서 문자열을 'char'로 변환
for i = 1:numel(cell_data)
    if isstring(cell_data{i}) || iscategorical(cell_data{i})
        cell_data{i} = char(cell_data{i}); % string 또는 categorical -> char 변환
    elseif isnumeric(cell_data{i}) || islogical(cell_data{i})
        continue; % 숫자나 논리형 데이터는 변환 필요 없음
    else
        cell_data{i} = ''; % 지원하지 않는 데이터 유형은 빈 값으로 설정
    end
end

% 데이터를 UITable에 설정
if isfield(handles, 'uitable1') && isvalid(handles.uitable1)
    set(handles.uitable1, 'Data', cell_data); % 변환된 데이터를 설정
    set(handles.uitable1, 'ColumnName', Table.Properties.VariableNames); % 열 이름 설정
else
    errordlg('uitable1 태그가 유효하지 않습니다. GUIDE에서 확인하세요.', '객체 오류');
end
end


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
        run mainhome.m;
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(time_table);
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
modify
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dataplot
end
