function varargout = matching_gui(varargin)
% MATCHING_GUI MATLAB code for matching_gui.fig
%      MATCHING_GUI, by itself, creates a new MATCHING_GUI or raises the existing
%      singleton*.
%
%      H = MATCHING_GUI returns the handle to a new MATCHING_GUI or the handle to
%      the existing singleton*.
%
%      MATCHING_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MATCHING_GUI.M with the given input arguments.
%
%      MATCHING_GUI('Property','Value',...) creates a new MATCHING_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before matching_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to matching_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help matching_gui

% Last Modified by GUIDE v2.5 04-Dec-2024 04:03:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @matching_gui_OpeningFcn, ...
    'gui_OutputFcn',  @matching_gui_OutputFcn, ...
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


% --- Executes just before matching_gui is made visible.
function matching_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to matching_gui (see VARARGIN)

% Choose default command line output for matching_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes matching_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = matching_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_result.
function pushbutton_result_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  matching.m (function)
%  output) matched = struct (여러 유저들과 매칭될 수 있기 때문)
%           matched.day    선호 요일
%           matched.kakao  매칭된 사람의 카카오톡 id
%           matched.time   몇 교시 끝나고 만나면 되는지 명시
%
%  로그인 유저의 선호와 타 유저의 정보 비교, 매칭
%    1. 로그인 유저의 선호 정보 및 전체 유저 정보 구조화
%    2. 전체 유저 정보와 로그인 유저의 선호 정보 비교
%    3. 선호 유저 정보와 동일한 유저들과 시간표 비교
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   1. 로그인 유저의 선호 정보 및 전체 유저 정보 구조화

% 로그인 유저 아이디 불러오기
filename = 'user_data.txt';
if exist(filename, 'file') % user_data.txt 파일 존재 여부 확인
    fid = fopen(filename, 'rt'); % 읽기 모드로 열기
    line=strsplit(fgetl(fid),'\t'); % 첫 줄에서 학번 읽기
    id=line{1};
    fclose(fid);

    a=1;
else
    errordlg('user_data.txt 파일이 없습니다. 먼저 로그인하세요.', '오류');
    close(matching_gui);
    close(time_table);
    example;
    return;
end


% 유저들 정보 파일들 불러오기
filename1 = 'user_want.txt';
filename2 = 'user_prefer.txt';
filename3 = '회원정보.txt';
filename4 = 'user_timetable.txt';
filename5 = 'matched_user.txt';

% 유저들 정보 파일 read 모드로 열기
fid1 = fopen(filename1, 'rt');
fid2 = fopen(filename2, 'rt');
fid3 = fopen(filename3, 'rt');
fid4 = fopen(filename4, 'rt');
fid5 = fopen(filename5, 'wt');

% 선호 정보의 총 데이터 수가 같으므로 한번에 구조에 저장 (want, prefer 한번에 저장)
% 유저들의 선호 정보를 담을 빈 struct 구조 생성
i = 1; % 인덱스 용 숫자
while ~feof(fid1)   % 파일의 끝에 도달하지 않았으면 반복
    line1 = fgetl(fid1);   % 해당 열 문자들 받기
    line2 = fgetl(fid2);
    if line1 == -1   % 마지막 열일 경우 반복문 종료
        break
    end
    linedata1 = strsplit(line1,'\t');
    line2=char(line2);
    linedata2 = strsplit(line2,'\t');   % 유저들의 정보를 tap 을 기준으로 정보를 쪼개고 user struct에 저장

    user_pre(i).id = linedata1{1};
    user_pre(i).want = linedata1{2};
    user_pre(i).gender = linedata2{2};
    user_pre(i).major = linedata2{3};
    user_pre(i).grade = linedata2{4};
    user_pre(i).day = linedata2{5};


    i = i+1;  % 다음 user struct에 저장하기 위해 index 업데이트
end

fclose(fid1);
fclose(fid2);

% 로그인 유저의 정보 인덱스 저장 (유저 선호 정보 중)
preidx = find(strcmp({user_pre.id},id));
user_mypre = user_pre(preidx);
user_pre(preidx) = [];

% 전체 유저들의 정보 저장
% 유저들의 정보를 담을 빈 struct 구조 생성
user = {};
i = 1; % 인덱스용 숫자
while ~feof(fid3)   % 파일의 끝에 도달하지 않았으면 반복
    line = fgetl(fid3);   % 해당 열 문자들 받기

    if line == -1   % 마지막 열일 경우 반복문 종료
        break
    end

    linedata = strsplit(line,'\t');   % 유저의 정보를 tap 을 기준으로 정보를 쪼개고 user struct에 저장

    user(i).id = linedata{1};
    user(i).major = linedata{3};
    user(i).gender = linedata{4};
    user(i).grade = linedata{5};
    user(i).kakao = linedata{6};

    i = i+1;  % 다음 user struct에 저장하기 위해 index 업데이트
end

% 나와 매칭 방지
% 로그인 유저의 정보 인덱스 저장, 전체 유저 정보 중 해당 정보 삭제 (전체 유저 정보 중)
useridx = find(strcmp({user.id},id));
mine = user(useridx);
user(useridx) = [];

fclose(fid3);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%    2. 전체 유저 정보와 로그인 유저의 선호 정보 비교

% 선호 정보가 있는 유저의 id 정보 cell로 저장
if length(user)>0 && length(user_pre)>0
    c=1;
    for i=1:length(user_pre)
        for j=1:length(user)
            if strcmp(user_pre(j).id,user(i).id)
                usernew(c)= user(j);
                c=c+1;
            end
        end
    end

    % 매칭된 유저 저장할 빈 배열 생성
    matcheduser = {};

    c = 1; % 매칭된 유저 인덱스

    % 로그인 유저의 선호와 성별, 전공, 학년이 같으면 해당 유저 정보 저장
    for i = 1:length(usernew)


        matchinguser = usernew(i) ;
        idindex = find(strcmp({user_pre.id},matchinguser.id));

        %mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
        % 내 만남 선호와 상대의 만남 선호가 같은 경우
        if strcmp(user_mypre.want, user_pre(idindex).want)

            % 내 선호가 성별 무관 + 전공 무관 + 학년 무관인 경우
            % 상대의 선호가 무관이거나 내 정보와 동일한 경우
            if strcmp(user_mypre.gender,'all') && ...
                    strcmp(user_mypre.major, 'all') && ...
                    strcmp(user_mypre.grade, 'all') 
                matcheduser(c).id = matchinguser.id;
                matcheduser(c).gender = matchinguser.gender;
                matcheduser(c).major = matchinguser.major;
                matcheduser(c).grade = matchinguser.grade;
                matcheduser(c).kakao = matchinguser.kakao;
                c=c+1;

                % 내 선호가 성별 무관인 경우
                % 상대의 성별 선호가 성별 무관이거나 내 정보와 동일한 경우
            elseif strcmp(user_mypre.gender, 'all') 

                % 내 선호가 성별 무관 + 전공 무관 + 학년 동일인 경우
                if strcmp(user_mypre.major,'all') 
                    if strcmp(user_mypre.grade, matchinguser.grade)
                        matcheduser(c).id = matchinguser.id;
                        matcheduser(c).gender = matchinguser.gender;
                        matcheduser(c).major = matchinguser.major;
                        matcheduser(c).grade = matchinguser.grade;
                        matcheduser(c).kakao = matchinguser.kakao;
                        c=c+1;
                    end

                    % 내 선호가 성별 무관 + 학년 무관 + 전공 동일인 경우
                elseif  strcmp(user_mypre.grade,'all') 
                    if strcmp(user_mypre.major, matchinguser.major)
                        matcheduser(c).id = matchinguser.id;
                        matcheduser(c).gender = matchinguser.gender;
                        matcheduser(c).major = matchinguser.major;
                        matcheduser(c).grade = matchinguser.grade;
                        matcheduser(c).kakao = matchinguser.kakao;
                        c=c+1;
                    end

                    % 내 선호가 성별 무관 + 학년 동일 + 전공 동일인 경우
                else
                    if  strcmp(user_mypre.grade, matchinguser.grade) && ...
                            strcmp(user_mypre.major,matchinguser.major)
                        matcheduser(c).id = matchinguser.id;
                        matcheduser(c).gender = matchinguser.gender;
                        matcheduser(c).major = matchinguser.major;
                        matcheduser(c).grade = matchinguser.grade;
                        matcheduser(c).kakao = matchinguser.kakao;
                        c=c+1;
                    end
                end

                % 내 선호가 전공 무관인 경우
                % 상대의 전공 선호가 전공 무관이거나 내 전공과 동일한 경우
            elseif strcmp(user_mypre.major, 'all') 
                % 내 선호가 전공 무관 + 성별 무관인 경우 + 학년 동일인 경우 위에서 카운트 완료
                % 내 선호가 전공 무관 + 학년 무관 + 성별 동일인 경우
                if  strcmp(user_mypre.grade,'all') 
                    % 내 성별 선호와 상대 성별이 같은 경우
                    if strcmp(user_mypre.gender, matchinguser.gender)
                        matcheduser(c).id = matchinguser.id;
                        matcheduser(c).gender = matchinguser.gender;
                        matcheduser(c).major = matchinguser.major;
                        matcheduser(c).grade = matchinguser.grade;
                        matcheduser(c).kakao = matchinguser.kakao;
                        c=c+1;
                    end

                    % 내 선호가 전공 무관 + 성별 동일 + 학년 동일인 경우
                else
                    if  strcmp(user_mypre.gender, matchinguser.gender) && ...
                            strcmp(user_mypre.grade, matchinguser.grade)
                        matcheduser(c).id = matchinguser.id;
                        matcheduser(c).gender = matchinguser.gender;
                        matcheduser(c).major = matchinguser.major;
                        matcheduser(c).grade = matchinguser.grade;
                        matcheduser(c).kakao = matchinguser.kakao;
                        c=c+1;
                    end
                end

                % 내 선호가 학년 무관인 경우
                % 상대의 학년 선호가 학년 무관이거나 내 학년과 동일한 경우
            elseif strcmp(user_mypre.grade, 'all')

                % 내 선호가 학년 무관 + 전공 무관 + 성별 동일인 경우 위에서 카운트 완료
                % 내 선호가 학년 무관 + 성별 무관 + 전공 동일인 경우 위에서 카운트 완료
                % 내 선호가 학년 무관 + 성별 동일 + 전공 동일인 경우
                if  strcmp(user_mypre.gender, matchinguser.gender) && ...
                        strcmp(user_mypre.major, matchinguser.major)
                    matcheduser(c).id = matchinguser.id;
                    matcheduser(c).gender = matchinguser.gender;
                    matcheduser(c).major = matchinguser.major;
                    matcheduser(c).grade = matchinguser.grade;
                    matcheduser(c).kakao = matchinguser.kakao;
                    c=c+1;
                end
                % 내 선호가 성별 동일 + 전공 동일 + 학년 동일인 경우
            else
                if strcmp(user_mypre.gender, matchinguser.gender) && ...
                        strcmp(user_mypre.major, matchinguser.major) && ...
                        strcmp(user_mypre.grade,matchinguser.grade)
                    matcheduser(c).id = matchinguser.id;
                    matcheduser(c).gender = matchinguser.gender;
                    matcheduser(c).major = matchinguser.major;
                    matcheduser(c).grade = matchinguser.grade;
                    matcheduser(c).kakao = matchinguser.kakao;

                    c = c+1;
                end
            end

        end
    end
else
    h = msgbox('조건에 맞는 사람이 없습니다.');
    uiwait(h);
    run mainhome.m;
    close(matching_gui);
    return;
end


if length(matcheduser) == 0
    h = msgbox('조건에 맞는 사람이 없습니다.');
    uiwait(h);
    run mainhome.m;
    close(matching_gui);
else

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %    3. 선호 유저 정보와 동일한 유저들과 시간표 비교
    classname = ["충무관", "다산관", "학술정보원", "영실관", "우정당", "박물관", "새날관", "용덕관", ...
        "진관홀", "광개토관", "세종관", "군자관", "학생회관", "집현관", "대양홀", "이당관", "애지헌"];

    % 유저들의 시간표 데이터 구조화
    % 시간표 데이터 저장할 빈 struct 구조 생성
    user_timetable = {} ;
    % 시간표 데이터 그대로 저장할 배열 생성
    i = 1; % 인덱스 용 숫자
    while ~feof(fid4)   % 파일의 끝에 도달하지 않았으면 반복
        line4 = fgetl(fid4);   % 해당 열 문자들 받기

        if line4 == -1   % 마지막 열일 경우 반복문 종료
            break
        end

        linedata4 = strsplit(line4,'\t') ;  % 유저들의 정보를 tap 을 기준으로 정보를 쪼개고 user struct에 저장
        user_timetable(i).id = linedata4{1};
        user_timetable(i).day = linedata4{2};
        user_timetable(i).class1 = linedata4{3};
        user_timetable(i).class2 = linedata4{4};
        user_timetable(i).class3 = linedata4{5};
        user_timetable(i).class4 = linedata4{6};
        user_timetable(i).class5 = linedata4{7};
        user_timetable(i).class6 = linedata4{8};
        user_timetable(i).class7 = linedata4{9};

        i = i+1;  % 다음 user struct에 저장하기 위해 index 업데이트
    end

    fclose(fid4);

    % 1 충무관, 2 다산관, 3 학술정보원, 4 영실관, 5 우정당, 6 박물관, 7 새날관, 8 용덕관, 9 진관홀
    % 10 광개토관, 11 세종관, 12 군자관, 13 학생회관, 14 집현관, 15 대양홀, 16 이당관, 17 애지헌

    % timetable에 따른 매칭
    % pre_day 는 선호 유저들의 시간표가 선호 요일과 같은 경우 시간표 정보 받기
    pre_day = {} ;
    c = 1;
    for i = 1:length(user_timetable)
        for j = 1:length(matcheduser)
            if strcmp(matcheduser(j).id , user_timetable(i).id) && ...
                    strcmp(user_mypre.day , user_timetable(i).day)
                pre_day{c,1} = user_timetable(i).class1;
                pre_day{c,2} = user_timetable(i).class2;
                pre_day{c,3} = user_timetable(i).class3;
                pre_day{c,4} = user_timetable(i).class4;
                pre_day{c,5} = user_timetable(i).class5;
                pre_day{c,6} = user_timetable(i).class6;
                pre_day{c,7} = user_timetable(i).class7;

                kakaoidx = find(strcmp({user.id},matcheduser(j).id));
                pre_day{c,8} = user(kakaoidx).kakao;
                pre_day{c,9} = user(kakaoidx).major;
                pre_day{c,10} = user(kakaoidx).gender;
                pre_day{c,11} = user(kakaoidx).grade;

                c = c+1;
            end
        end
    end

    % user_day 는 로그인 유저의 요일에 맞는 시간표 받기
    user_day = {} ;
    for i = 1:length(user_timetable)
        if strcmp(id, user_timetable(i).id) && ...
                strcmp(user_mypre.day , user_timetable(i).day)
            user_day{1,1} = user_timetable(i).class1;
            user_day{1,2} = user_timetable(i).class2;
            user_day{1,3} = user_timetable(i).class3;
            user_day{1,4} = user_timetable(i).class4;
            user_day{1,5} = user_timetable(i).class5;
            user_day{1,6} = user_timetable(i).class6;
            user_day{1,7} = user_timetable(i).class7;
        end
    end
    if length(pre_day)>0 && length(user_day)>0

        for p = 1:length(pre_day(:,1))
            for t = 1:7
                pre_day{p,t} = str2double(pre_day{p,t});
                if p == 1
                    user_day{1,t} = str2double(user_day{1,t});
                end
            end
        end


        % 선호하는 만남에 따라 매칭
        % 매칭되는 사람 정보 저장할 배열
        matched = {};
        a = 1; % 중복되어 매칭되는 경우를 위한 인덱스
        class_count=[];
        matched_places={};
        t = 1;
                c=0;
        if strcmp(user_mypre.want,'meal')
            % 2교시 끝나는 건물이 같고 3교시 수업이 없는 경우 (12시 식사)
            for p = 1:length(pre_day(:,1))
                
                if pre_day{p,2} == user_day{2} && pre_day{p,3} == 0 && user_day{3} == 0 && user_day{2} ~= 0
                    matched(a).day = user_mypre.day;
                    matched(a).kakao = pre_day{p,8};
                    matched(a).time = 2; % class 2 이후 점심
                    matched(a).major = pre_day{p,9};
                    matched(a).gender = pre_day{p,10};
                    matched(a).grade = pre_day{p,11};
                    matched_places{a,1} = char(classname(user_day{2}));

                    a = a + 1;
                    % 3교시 끝나는 건물이 같고 4교시 수업이 없는 경우 (13시 30분 식사)
                elseif pre_day{p,3} == user_day{3} && pre_day{p,4} == 0 && user_day{4} == 0 && user_day{3} ~= 0
                    matched(a).day = user_mypre.day;
                    matched(a).kakao = pre_day{p,8};
                    matched(a).time = 3; % class 3 이후 점심
                    matched(a).major = pre_day{p,9};
                    matched(a).gender = pre_day{p,10};
                    matched(a).grade = pre_day{p,11};
                    matched_places{a,1} = char(classname(user_day{3}));

                    a = a + 1;
                end
            end
        elseif strcmp(user_mypre.want,'study') %끝나는 수업과 건물이 같은경우
            a=1;
            for p=1:length(pre_day(:,1))
                user_last_class=[];
                pre_last_class=[];
                for i=7:-1:1
                    if user_day{i}~=0
                        user_last_class=[i user_day{i}];
                        break;
                    end
                end
                for i=7:-1:1
                    if pre_day{p,i}~=0
                        pre_last_class=[i pre_day{p,i}];
                        break;
                    end
                end
                if user_last_class(1)==pre_last_class(1) && user_last_class(2)==pre_last_class(2)
                    matched(a).day = user_mypre.day;
                    matched(a).kakao = pre_day{p,8};
                    matched(a).time = user_last_class(1);
                    matched(a).major = pre_day{p,9};
                    matched(a).gender = pre_day{p,10};
                    matched(a).grade = pre_day{p,11};
                    matched_places{a,1} = char(classname(user_last_class(2)));

                    a = a + 1;
                end


            end
        elseif strcmp(user_mypre.want,'friend')
            for p=1:length(pre_day(:,1))
                c=0;
                times = [];
                places = [];
                for t = 1:7
                    if pre_day{p,t} == user_day{t} && ...
                            (pre_day{p,t} ~= 0 && user_day{t} ~= 0) && ...
                            (pre_day{p,t} ~= 3 && user_day{t} ~= 3)
                        c=c+1;
                        times=[times t];
                    end

                end
                time(p).time=times;
                if c>0
                    class_count=[class_count; p, c;];
                end
            end

            for i=1:length(class_count(:,1))
                for j= 1:length(class_count(:,1))
                    if class_count(i,2)>class_count(j,2)
                        temp=class_count(i,:);
                        class_count(i,:)=class_count(j,:);
                        class_count(j,:)=temp;
                    end
                end
            end
            matched_places={};
            for i=1:length(class_count(:,1))
                p=class_count(i,1);
                times=time(p).time;
                for j=1:length(times)
                    matched_places{i,j}=char(classname(user_day{times(j)}));
                end
                matched(i).day = user_mypre.day;
                matched(i).kakao = pre_day{p,8};
                matched(i).time = time(p).time; % class t 이후 공부
                matched(i).major = pre_day{p,9};
                matched(i).gender = pre_day{p,10};
                matched(i).grade = pre_day{p,11};

            end
        end



        if ~isempty(matched) % matched 구조체가 비어 있지 않은 경우
            fprintf(fid5, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n','Want','Day','Major','Gender','Grade','KAKAO ID','When','Where');
            for i = 1:length(matched)
                fprintf(fid5, '%s\t%s\t%s\t%s\t%s\t%s\t', user_mypre.want,matched(i).day,matched(i).major,matched(i).gender,...
                    matched(i).grade,matched(i).kakao);
                for j = 1:length(matched(i).time)
                    if j == length(matched(i).time)
                        fprintf(fid5,'%d교시(%s)\n',matched(i).time(j),matched_places{i,j});
                    else
                        fprintf(fid5,'%d교시(%s)\t',matched(i).time(j),matched_places{i,j});
                    end
                end
            end
            fclose(fid5);
            run result.m;
        else
            fclose(fid5);
            h = msgbox('조건에 맞는 사람을 찾을 수 없습니다.');
            uiwait(h);
            run mainhome.m;
        end
    else
        h = msgbox('조건에 맞는 사람을 찾을 수 없습니다.');
        uiwait(h);
        run mainhome.m;
    end



    % 파일 닫기



    close(matching_gui);
end


% --- Executes on mouse press over figure background.
function figure1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
