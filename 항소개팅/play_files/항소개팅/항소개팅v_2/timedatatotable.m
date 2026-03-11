%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  timedatatotable.m (function)
%   
%  아이디 받아서 해당 아이디 시간표 table 만들기
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ctable = timedatatotable(id)
%id = '21011324';
filename = '..\data\database\user_timetable.txt';
fid = fopen(filename, 'rt');
% Users의 정보를 담을 빈 struct 구조 생성

% 데이터를 저장할 구조체 배열 초기화
user_timetable = {};

% 행별로 파일 읽기
i = 1; % index 용 숫자

while ~feof(fid)   % 파일의 끝에 도달하지 않았으면 반복
    line = fgetl(fid);   % 해당 열 문자들 받기

    if line == -1   % 마지막 열일 경우 반복문 종료
        break
    end

    linedata = strsplit(line,'\t');   % User의 정보를 tap 을 기준으로 정보를 쪼개고 user struct에 저장
    
    user_timetable(i).id = linedata{1};
    user_timetable(i).day = linedata{2};
    user_timetable(i).class1 = str2num(linedata{3});
    user_timetable(i).class2 = str2num(linedata{4});
    user_timetable(i).class3 = str2num(linedata{5});
    user_timetable(i).class4 = str2num(linedata{6});
    user_timetable(i).class5 = str2num(linedata{7});
    user_timetable(i).class6 = str2num(linedata{8});
    user_timetable(i).class7 = str2num(linedata{9});
    
    i = i+1;  % 다음 user struct에 저장하기 위해 index 업데이트
end

ididx = find(strcmp({user_timetable.id},id));
user_timetable = user_timetable(ididx);

classname = ["충무관"; "다산관";"학술정보원";"영실관";"우정당";"박물관";"새날관";"용덕관";...
              "진관홀";"광개토관";"세종관";"군자관";"학생회관";"집현관";"대양홀";"이당관";"애지헌"];

class = ['1교시';'2교시';'3교시';'4교시';'5교시';'6교시';'7교시'];

mon = strings(7,1);
tue = strings(7,1);
wed = strings(7,1);
thu = strings(7,1);
fri = strings(7,1);

% 각 요일에 대한 시간표 설정
for i = 1:length(user_timetable)
    dayArray = eval(user_timetable(i).day);  % 요일에 해당하는 배열 참조
    for j = 1:7  % 각 교시에 대해
        classNum = eval(['user_timetable(i).class', num2str(j)]);
        if classNum == 0
            dayArray(j) = "No class";
        else
            dayArray(j) = classname(classNum);
        end
    end
    eval([user_timetable(i).day ' = dayArray;']);  % 결과 저장
end

% 테이블 생성
Table = table(class, mon, tue, wed, thu, fri, 'VariableNames', {'Class', '월', '화', '수', '목', '금'});

% 테이블을 셀 배열로 변환
ctable = table2cell(Table);
disp(ctable)

% 파일 닫기
fclose(fid);

end