%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  converter.m (function)
%
%  csv 데이터를 입력받아 년, 월, 일, 시, 분, 위도, 경도, 속도 배열 생성
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function data_array = converter(filename)

% csv 파일 읽기
data = readtable(filename);
data = data(:,2:6);  % csv 파일에서 필요한 데이터 추출

% 시간, 위치 정보 저장할 빈 배열 생성
data_array = [];

% 시간, 2차원 위치 데이터 정보 배열 저장
for i=1:numel(data.time)
    time = strsplit(data.time{i},'T');
    dayy = strsplit(time{1},'-');
    dayy = str2double(dayy);
    year = dayy(1); month = dayy(2); day = dayy(3);
    timee = strsplit(time{2},':');
    timee = str2double(timee);
    
    % 한국 표준시로 변환
    hour = timee(1)+9; 
    minute = timee(2);

    % 24시를 넘어가는 경우 다음날로 설정
    if hour > 24
        day = day + 1;
        hour = hour - 24;
    end

    lat = data.latitude(i);
    long = data.longitude(i);
    vel = data.speed(i);  
   
    data_set = [year month day hour minute lat long vel];
    data_array = [data_array ; data_set];
         
end

% 년도 데이터 삭제
data_array(:,1) = [];

end