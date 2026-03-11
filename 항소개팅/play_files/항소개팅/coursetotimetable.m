%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  coursetotimetable.m (function)
%  
%  course 시간표 데이터를 입력받아 해당 수업이 이루어지는 교시 및 건물 저장
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function timetable = coursetotimetable(course)

% 시간표 정보를 담을 빈 struct 구조 생성 
timetable = {};
k = 1; % table index
i = 1; % count index

% 시간표 범위 지정 (1h30m 수업 only)
standardtime = [09 10.5 ;...
                10.5 12;...
                12 13.5;...
                13.5 15;...
                15 16.5;...
                16.5 18;
                18 19.5];

% 00시 기준 분 정보로 변환
standardtime = standardtime*60;

while i<=length(course(:,2))
    % 00시 기준 분 정보로 변환
    starttime = course(i,1)*60 + course(i,2);
    endtime = course(i,3)*60 + course(i,4);

    % 강의에서 보낸 시간이 10분 이내이면 수업이 아닌 것으로 인식, 다음 course 탐색 혹은 마지막 course인 경우 종료
    lapse = endtime - starttime;  % 해당 강의에서 보낸 시간 
    if lapse < 10 && i < length(course(:,2))
        continue
    elseif lapse < 10 && i==length(course(:,2))
        break
    end
   
    timer = standardtime;  % 모두 1시간 30분 수업 시간으로 인식
    for j = 1:length(timer)
        % 해당 시간표 시작으로 인식
        if starttime - timer(j,1) < 60 && starttime - timer(j,1) > -30
            starttime2 = timer(j,1);
            endtime2 = timer(j,2);
            if ~(course(i,9)==2 || course(i,9)==3)
            timetable(k).start = starttime2/60;
            timetable(k).end = endtime2/60;
            timetable(k).place = course(i,9);
            k = k + 1;
            end
            i = i + 1;
            break
        else
            continue
        end
    end
    
    % 수업 외의 시간이 기록된 경우 반복문 종료
    if starttime > standardtime(14)
        break
    end   
end

end