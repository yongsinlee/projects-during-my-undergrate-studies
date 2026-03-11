function varargout = result(varargin)
% RESULT MATLAB code for result.fig
%      RESULT, by itself, creates a new RESULT or raises the existing
%      singleton*.
%
%      H = RESULT returns the handle to a new RESULT or the handle to
%      the existing singleton*.
%
%      RESULT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULT.M with the given input arguments.
%
%      RESULT('Property','Value',...) creates a new RESULT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before result_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to result_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help result

% Last Modified by GUIDE v2.5 03-Dec-2024 05:57:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @result_OpeningFcn, ...
    'gui_OutputFcn',  @result_OutputFcn, ...
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
end

% --- Executes just before result is made visible.
function result_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to result (see VARARGIN)
filename = 'matched_user.txt';
if ~exist(filename, 'file')
    errordlg('텍스트 파일이 존재하지 않습니다.', '파일 오류');
    return;
end

% 3. 파일 열기
fid = fopen(filename, 'rt');
if fid == -1
    errordlg('파일을 열 수 없습니다.', '파일 오류');
    return;
end
handles.lineCount = 0;  % 줄 수를 카운트할 변수

while ~feof(fid)  % 파일 끝에 도달할 때까지 반복
    fgetl(fid);  % 한 줄씩 읽기
    handles.lineCount = handles.lineCount + 1;  % 줄 수 증가
end
handles.lineCount=handles.lineCount-1;
fclose(fid);

filename = 'matched_user.txt';
fid = fopen(filename, 'rt');
handles.n=2;
for i=1:handles.n
    line=fgetl(fid);
end
%파일닫기
fclose(fid);
data = strsplit(char(line),'\t');
data_n=length(data);
handles.kt=data{6};
if length(data)>7
    str=sprintf('매칭된 인원 수: %d\n목적: %s\n요일: %s\nClass: ',handles.lineCount, data{1}, data{2});
    for i=7:data_n
        str=sprintf('%s%s',str,data{i});
    end
    formatted_str=sprintf('%s\n학과: %s\n성별: %s\n학년: %s\nKakaoID: %s\n',str,data{3},data{4}, data{5}, data{6});
else
    formatted_str = sprintf('매칭된 인원 수: %d\n목적: %s\n요일: %s\nClass: %s\n학과: %s\n성별: %s\n학년: %s\nKakaoID: %s\n', ...
        handles.lineCount, data{1}, data{2}, data{7}, data{3}, ...
        data{4}, data{5}, data{6});
end
set(handles.text_display, 'String', formatted_str);
disp('매칭되었습니다.')

% Choose default command line output for result
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes result wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = result_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure



varargout{1} = handles.output;
guidata(hObject,handles);
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
filename = 'matched_user.txt';
fid = fopen(filename, 'rt');
handles.n=handles.n+1;
if handles.n>handles.lineCount
    h=msgbox('모든 친구를 찾았습니다!');
    uiwait(h);
    handles.n=handles.lineCount;
end
for i=1:handles.n
    line=fgetl(fid);
end
fclose(fid);
data = strsplit(line, '\t');
data_n=length(data);
handles.kt=data{6};
if length(data)>7
    str=sprintf('매칭된 인원 수: %d\n목적: %s\n요일: %s\nClass: ',handles.lineCount, data{1}, data{2});
    for i=7:data_n
        str=sprintf('%s%s',str,data{i});
    end
    formatted_str=sprintf('%s\n학과: %s\n성별: %s\n학년: %s\nKakaoID: %s\n',str,data{3},data{4}, data{5}, data{6});
else
    formatted_str = sprintf('매칭된 인원 수: %d\n목적: %s\n요일: %s\nClass: %s\n학과: %s\n성별: %s\n학년: %s\nKakaoID: %s\n', ...
        handles.lineCount, data{1}, data{2}, data{7}, data{3}, ...
        data{4}, data{5}, data{6});
end

% 6. 텍스트 컴포넌트에 표시
set(handles.text_display, 'String', formatted_str);
guidata(hObject,handles);
end


% --- Executes on button press in pushbutton_back.
function pushbutton_back_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename = 'matched_user.txt';
fid = fopen(filename, 'rt');
handles.n=handles.n-1;
if handles.n<2
    handles.n=2;
end
for i=1:handles.n
    line=fgetl(fid);
end
fclose(fid);
data = strsplit(line, '\t');
data_n=length(data);
handles.kt=data{6};
if length(data)>7
    str=sprintf('매칭된 인원 수: %d\n목적: %s\n요일: %s\nClass: ',handles.lineCount, data{1}, data{2});
    for i=7:data_n
        str=sprintf('%s%s',str,data{i});
    end
    formatted_str=sprintf('%s\n학과: %s\n성별: %s\n학년: %s\nKakaoID: %s\n',str,data{3},data{4}, data{5}, data{6});
else
    formatted_str = sprintf('매칭된 인원 수: %d\n목적: %s\n요일: %s\nClass: %s\n학과: %s\n성별: %s\n학년: %s\nKakaoID: %s\n', ...
        handles.lineCount, data{1}, data{2}, data{7}, data{3}, ...
        data{4}, data{5}, data{6});
end

% 6. 텍스트 컴포넌트에 표시
set(handles.text_display, 'String', formatted_str);
guidata(hObject,handles);
end

% --- Executes on button press in pushbutton_copy.
function pushbutton_copy_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_copy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clipboard('copy', handles.kt);
h=msgbox(sprintf('클립보드에 복사되었습니다 Kakao : %s',handles.kt));
end


% --- Executes on button press in pushbutton_finish.
function pushbutton_finish_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_finish (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(result);
end
