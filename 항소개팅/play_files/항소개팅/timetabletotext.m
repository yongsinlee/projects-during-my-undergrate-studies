%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  timetabletotext.m (function)
%
%  시간표 데이터를 바탕으로 전체 교시에 수업 정보 저장
%  1 ~ 6교시, n교시에 수업이 없으면 0, 수업이 있으면 수업한 건물 번호 저장
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function timetext = timetabletotext(timetable)

% 시작 시간 (각 교시 별 시작 시간)
standardtime = [09 10.5 12 13.5 15 16.5 18];

% 시간표를 간단하게 고려하기 위해 시간, 건물번호 초기 배열 생성
timetext = [];
j = 1;

% 시작 시간과 timetable의 강의 시간 매칭, 수업이 있으면 건물번호, 없으면 0 입력
for i = 1:length(standardtime)
    if j > length(timetable)  % timetable의 수업들 카운트가 끝난 경우 0 입력
            text = 0;  % 수업 없음

    % timetable의 카운트가 진행중이며, 시작 시간과 timetable의 시작 시간이 같은 경우 1, 건물 번호 입력
    elseif j <= length(timetable) && standardtime(i) == timetable(j).start 
        text = timetable(j).place; % 수업 있음, 건물번호 입력
        j = j+1;
    else
        text = 0;
    end
    timetext = [timetext; text];
end
end

