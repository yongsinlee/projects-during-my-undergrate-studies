function varargout = mainhome(varargin)
%MAINHOME MATLAB code file for mainhome.fig
%      MAINHOME, by itself, creates a new MAINHOME or raises the existing
%      singleton*.
%
%      H = MAINHOME returns the handle to a new MAINHOME or the handle to
%      the existing singleton*.
%
%      MAINHOME('Property','Value',...) creates a new MAINHOME using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to mainhome_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      MAINHOME('CALLBACK') and MAINHOME('CALLBACK',hObject,...) call the
%      local function named CALLBACK in MAINHOME.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainhome

% Last Modified by GUIDE v2.5 03-Dec-2024 14:25:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @mainhome_OpeningFcn, ...
    'gui_OutputFcn',  @mainhome_OutputFcn, ...
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

% --- Executes just before mainhome is made visible.
function mainhome_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for mainhome
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mainhome wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = mainhome_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


% --- Executes on button press in meal.
function meal_Callback(hObject, eventdata, handles)
update_user_tag('meal');
end


% --- Executes on button press in friend.
function friend_Callback(hObject, eventdata, handles)
update_user_tag('friend');
end

% --- Executes on button press in study.
function study_Callback(hObject, eventdata, handles)
update_user_tag('study');
end

function update_user_tag(tag)
% 1. 입력값 가져오기
filename = 'user_data.txt';

% 로그인 학번 가져오기
if exist(filename, 'file') % user_data.txt 파일 존재 여부 확인
    fid = fopen(filename, 'rt'); % 읽기 모드로 열기
    line = strsplit((fgetl(fid)),'\t'); % 첫 줄에서 학번 읽기
    stid=line{1};
    fclose(fid);
else
    errordlg('user_data.txt 파일이 없습니다. 먼저 로그인하세요.', '오류');
    close(mainhome);
    close(time_table);
    example;
    return;
end

% user_want.txt 파일 처리
filename = 'user_want.txt';

% 파일이 존재하지 않을 경우 빈 파일 생성
if ~isfile(filename)
    fid = fopen(filename, 'wt');
    % 새 정보 추가 입력
fprintf(fid, '%s\t%s\n', stid, tag);

fclose(fid);

run setting.m;
close(mainhome);
else
    % 파일 읽기
    fid = fopen(filename, 'rt');
    user_want = {}; % 데이터 저장할 빈 배열 생성
    k = 1;

    while ~feof(fid)   % 파일의 끝에 도달하지 않았으면 반복
        line = strtrim(fgetl(fid)); % 해당 줄을 읽고 공백 제거

        % 빈 줄이나 잘못된 줄 무시
        if isempty(line)
            continue;
        end

        % 줄을 탭으로 나눔
        linedata = strsplit(line, '\t');

        % 데이터가 학번과 태그 두 개의 요소로 나뉘지 않은 경우 무시
        if numel(linedata) < 2
            continue;
        end

        % user_want 구조체에 데이터 저장
        user_want(k).stid = linedata{1};
        user_want(k).want = linedata{2};
        k = k + 1;  % 다음 user_want 구조체에 저장하기 위해 index 업데이트
    end

    fclose(fid);

    % 중복된 경우 제거
    if ~isempty(user_want)
        index = find(strcmp({user_want.stid}, stid));
        user_want(index) = []; % 기존 학번의 데이터 삭제
    end
    % 파일 다시 쓰기
fid = fopen(filename, "wt");
for j = 1:length(user_want)
    fprintf(fid, '%s\t%s\n', user_want(j).stid, user_want(j).want);
end
% 새 정보 추가 입력
fprintf(fid, '%s\t%s\n', stid, tag);

fclose(fid);

run setting.m;
close(mainhome);
end
end



% --- Executes on button press in modify.
function modify_Callback(hObject, eventdata, handles)
run modify.m;
close(mainhome);
% hObject    handle to modify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end
