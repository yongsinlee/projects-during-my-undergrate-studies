%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  creatcourse.m (function)
%
%  csv 파일을 받아 GPS 위치 정보를 바탕으로 시간표 데이터 생성
%    1. GPS 기준 시간표 시작, 끝, 위치, 데이터 인덱스 저장
%    2. GPS 오차 고려한 데이터 수정
%    3. 시간표 바탕으로 건물 위치 저장
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function course = creatcourse(filename)


%    1. GPS 기준 시간표 시작, 끝, 위치, 데이터 인덱스 저장


% GPS 데이터 불러오기
data = [];
data = converter(filename);

% 현재 위치 초기값 설정
currentplace = [data(1,5) data(1,6)];

% t 현재 위치 유지 시간 수, 초기값 설정(-1)
t = -1;

% c 위치 벗어남 카운트 수
c = 0;

% 시간표를 저장할 빈 배열 생성
course = [];

% course에 기록되는 시작 데이터 인덱스 
st = [data(1,3) data(1,4)];

% 파라미터 place_error 위치 벗어남 정도
place_error = 0.00015;

% 시간표 저장
for i = 1:length(data)
    t = t+1;

    % 위치 벗어남, 카운트 늘림 (c = c + 1)
    if abs(data(i,5)-currentplace(1,1))>place_error || abs(data(i,6)-currentplace(1,2)) > place_error
        c = c+1;
    end

    % 위치 유지 시간 600 (약 10분)이상이고 위치벗어났을때
    % lat,long = 유지 시간동안 위도 경도값 행렬
    % 1차 곡선으로 fitting 하여 오차를 줄인 다음 평균값을 course에 저장
    if t > 600  % 유지 시간 약 10분 초과
        if c > 10 % 위치 벗어남
            et = [data(i,3) data(i,4)];
            x = i-t:i;
            lat = data(x,5)';
            long = data(x,6)';
            p1 = polyfit(x,lat,1);
            p2 = polyfit(x,long,1);
            fit_lat = polyval(p1,x);
            fit_long = polyval(p2,x);

            % course에 시작시간 끝시간 위도 경도 평균값 데이터 인덱스 시작,끝 넘버 입력
            course = [course; st et mean(fit_lat) mean(fit_long) i-t i];
            currentplace = [data(i,5) data(i,6)];

            % 시작 시간 및 카운트 수 초기화
            st = [data(i,3) data(i,4)];
            t = 0;
            c = 0;
        end

    % 유지시간 600보다 작고 위치 벗어났을때 현재위치 초기화 및 시간 초기화
    elseif c > 10  % 위치 벗어남
        currentplace = [data(i,5) data(i,6)];
        st = [data(i,3) data(i,4)];
        t = 0;
        c = 0;
    end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%    2. GPS 오차 고려한 데이터 수정


% GPS 오차에 의해 같은 클래스가 여러번 반환되었을때 이를 합쳐주는 코드
% course 위도 경도값 error < 0.0002 보다 작고, 시간 차이 30분보다 작을 때 둘을 합침

over_course = [];
if length(course) > 0
for i = 2:length(course(:,1))
    if (abs(course(i,5)-course(i-1,5)) < 0.0002 && abs(course(i,6)-course(i-1,6)) < 0.0002 && ...
            abs((course(i,1)*60+course(i,2))-(course(i-1,3)*60+course(i-1,4))) < 30)
        over_course = [over_course,i-1];  % 합쳐진 인덱스 저장

        % i번째와 i-1번째가 같으므로 i번째에 i-1번째 데이터 저장
        course(i,1) = course(i-1,1);  
        course(i,2) = course(i-1,2);
        course(i,7) = course(i-1,7);
        course(i,5) = (course(i,5)+course(i-1,5))/2;
        course(i,6) = (course(i,6)+course(i-1,6))/2;
    end
end

end

% 중복 데이터 삭제
course(over_course,:)=[];

% GPS 데이터 플로팅 및 course 별 위도 경도 플로팅
if length(course)>0
    %figure; geoplot(course(:,5),course(:,6),'o');
end
%figure; geoplot(data(:,5),data(:,6),'o');.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\


%    3. 시간표 바탕으로 건물 위치 저장


% course 별 GPS 데이터를 통해  코스별 위치한 건물 번호를 반환
% 중요 파라미터
% vel_min:  실제로 움직인다고 가정하는 최소 속도
vel_min = 0.8;

% 속도가 최소 속도 이상일때 카운트 늘림 (c = c + 1), c > count_min 일때 GPS 데이터 재지정
count_min = 5;

% 건물 경계 위치 배열 (위도, 경도)
% 1 충무관, 2 다산관, 3 학술정보원, 4 영실관, 5 우정당, 6 박물관, 7 새날관, 8 용덕관, 9 진관홀
% 10 광개토관, 11 세종관, 12 군자관, 13 학생회관, 14 집현관, 15 대양홀, 16 이당관, 17 애지헌
chungmu = [37.55166, 127.0740;37.55208, 127.0745; 37.55257, 127.0738; 37.55217, 127.0733];
dasan = [37.55208, 127.0745;37.55257, 127.0738; 37.55288 127.0738; 37.55231, 127.0746];
hakjung = [37.55137, 127.0743; 37.55167, 127.0747; 37.55192, 127.0744; 37.55161, 127.0740];
young = [37.55208, 127.0731; 37.55259, 127.0737; 37.55268, 127.0736; 37.55217, 127.0730];
ujung = [37.55168, 127.0747; 37.55188, 127.0749; 37.55204, 127.0747; 37.55185, 127.0745];
museum = [37.55127, 127.0753; 37.55145, 127.0755; 37.55172, 127.0751; 37.55158, 127.0749];
saenal = [37.55090, 127.0758; 37.55108, 127.0760; 37.55130, 127.0757; 37.55114, 127.0755];
yongduk = [37.55108, 127.0733; 37.55132, 127.0736; 37.55154, 127.0734; 37.55127, 127.0730];
jingwan = [37.55072, 127.0733; 37.55088, 127.0735; 37.55108, 127.0733; 37.55091, 127.0731];
gwang = [37.54982, 127.0735; 37.54995, 127.0736; 37.55048, 127.0735; 37.55062, 127.0734;37.55028, 127.0729 ];
sejong = [37.54976, 127.0747; 37.54985, 127.0749; 37.55022, 127.0743; 37.55012, 127.0742];
gunja = [37.54935, 127.0735; 37.54937, 127.0740; 37.54984, 127.0740; 37.54976, 127.0735];
hakgwan = [37.54924, 127.0751; 37.54989, 127.0755; 37.54995, 127.0753; 37.54932, 127.0749];
jiphyun = [37.54880, 127.0734; 37.54880, 127.0738; 37.54926, 127.0738; 37.54926, 127.0734];
daeyang = [37.54844, 127.0741; 37.54844, 127.0748; 37.54887, 127.0748; 37.54888, 127.0742];
edang = [37.55030, 127.0728; 37.55066, 127.0732; 37.55071, 127.0731; 37.55035, 127.0727];
aeji = [37.55063, 127.0739; 37.55086, 127.0742; 37.55108, 127.0739; 37.55085, 127.0736];

% 건물 탐색
for i = 1:length(course(:,1))
    % contact하는 건물 배열 생성
    build_contact = zeros(17,1);

    % 건물 번호 체크를 위한 초기값 설정
    max = 0;
    build_num = 0;

    % course 위도,경도 데이터 표준편차 0.00005 이하일 경우 
    % GPS 좌표가 건물별 경계에 포함되는 빈도수 측정
    if std(data(course(i,7):course(i,8),5)) < 0.00005 && std(data(course(i,7):course(i,8),6)) < 0.00005
    
        % 건물별 contact 빈도수 체크
        for j=course(i,7):course(i,8)
            if inpolygon(data(j,5),data(j,6),chungmu(:,1),chungmu(:,2))
                build_contact(1,1) = build_contact(1,1)+1;
            elseif inpolygon(data(j,5),data(j,6),dasan(:,1),dasan(:,2))
                build_contact(2,1) = build_contact(2,1)+1;
            elseif inpolygon(data(j,5),data(j,6),hakjung(:,1),hakjung(:,2))
                build_contact(3,1) = build_contact(3,1)+1;
            elseif inpolygon(data(j,5),data(j,6),young(:,1),young(:,2))
                build_contact(4,1) = build_contact(4,1)+1;
            elseif inpolygon(data(j,5),data(j,6),ujung(:,1),ujung(:,2))
                build_contact(5,1) = build_contact(5,1)+1;
            elseif inpolygon(data(j,5),data(j,6),museum(:,1),museum(:,2))
                build_contact(6,1) = build_contact(6,1)+1;
            elseif inpolygon(data(j,5),data(j,6),saenal(:,1),saenal(:,2))
                build_contact(7,1) = build_contact(7,1)+1;
            elseif inpolygon(data(j,5),data(j,6),yongduk(:,1),yongduk(:,2))
                build_contact(8,1) = build_contact(8,1)+1;
            elseif inpolygon(data(j,5),data(j,6),jingwan(:,1),jingwan(:,2))
                build_contact(9,1) = build_contact(9,1)+1;
            elseif inpolygon(data(j,5),data(j,6),gwang(:,1),gwang(:,2))
                build_contact(10,1) = build_contact(10,1)+1;
            elseif inpolygon(data(j,5),data(j,6),sejong(:,1),sejong(:,2))
                build_contact(11,1) = build_contact(11,1)+1;
            elseif inpolygon(data(j,5),data(j,6),gunja(:,1),gunja(:,2))
                build_contact(12,1) = build_contact(12,1)+1;
            elseif inpolygon(data(j,5),data(j,6),hakgwan(:,1),hakgwan(:,2))
                build_contact(13,1) = build_contact(13,1)+1;
            elseif inpolygon(data(j,5),data(j,6),jiphyun(:,1),jiphyun(:,2))
                build_contact(14,1) = build_contact(14,1)+1;
            elseif inpolygon(data(j,5),data(j,6),daeyang(:,1),daeyang(:,2))
                build_contact(15,1) = build_contact(15,1)+1;            
            elseif inpolygon(data(j,5),data(j,6),edang(:,1),edang(:,2))
                build_contact(16,1) = build_contact(16,1)+1;
            elseif inpolygon(data(j,5),data(j,6),aeji(:,1),aeji(:,2))
                build_contact(17,1) = build_contact(17,1)+1;
            end
        end
        
        % 표준편차 0.00005 이상일 경우
        % course 별 끝 인덱스 번호 -60 부터 속도가 vel_min 이상일 때 카운트 늘림
        % 카운트 5 이상일 때의 인덱스 넘버(end_num)부터 end_num-30 (start_num) 범위 지정
        % start_num 부터 end_num 범위의 GPS 좌표 재지정 re_lat, re_long
        % re_lat, re_long의 GPS 데이터가 건물별 바운더리에 포함되는 빈도수 측정
    
    else
        % 초기값 설정
        c = 0;
        re_lat = [];
        re_long = [];
        j = course(i,8)-60:length(data);
    
        if course(i,8) < 102
            j = 2:length(data);
        end

        for j = j
            if data(j,7) > vel_min
                c = c+1;
            end
            if c > count_min
                end_num = j;
                start_num = j-30;
                if start_num < 1
                    start_num = 1;
                end
                re_lat = data(start_num:end_num,5);
                re_long = data(start_num:end_num,6);
                break
            end
        end

        for j = 1:length(re_lat)
            if inpolygon(re_lat(j,1),re_long(j,1),chungmu(:,1),chungmu(:,2))
                    build_contact(1,1) = build_contact(1,1)+1;
                elseif inpolygon(re_lat(j,1),re_long(j,1),dasan(:,1),dasan(:,2))
                    build_contact(2,1) = build_contact(2,1)+1;
                elseif inpolygon(re_lat(j,1),re_long(j,1),hakjung(:,1),hakjung(:,2))
                    build_contact(3,1) = build_contact(3,1)+1;
                elseif inpolygon(re_lat(j,1),re_long(j,1),young(:,1),young(:,2))
                    build_contact(4,1) = build_contact(4,1)+1;
                elseif inpolygon(re_lat(j,1),re_long(j,1),ujung(:,1),ujung(:,2))
                    build_contact(5,1) = build_contact(5,1)+1;
                elseif inpolygon(re_lat(j,1),re_long(j,1),museum(:,1),museum(:,2))
                    build_contact(6,1) = build_contact(6,1)+1;
                elseif inpolygon(re_lat(j,1),re_long(j,1),saenal(:,1),saenal(:,2))
                    build_contact(7,1) = build_contact(7,1)+1;
                elseif inpolygon(re_lat(j,1),re_long(j,1),yongduk(:,1),yongduk(:,2))
                    build_contact(8,1) = build_contact(8,1)+1;
                elseif inpolygon(re_lat(j,1),re_long(j,1),jingwan(:,1),jingwan(:,2))
                    build_contact(9,1) = build_contact(9,1)+1;
                elseif inpolygon(re_lat(j,1),re_long(j,1),gwang(:,1),gwang(:,2))
                    build_contact(10,1) = build_contact(10,1)+1;
                elseif inpolygon(re_lat(j,1),re_long(j,1),sejong(:,1),sejong(:,2))
                    build_contact(11,1) = build_contact(11,1)+1;
                elseif inpolygon(re_lat(j,1),re_long(j,1),gunja(:,1),gunja(:,2))
                    build_contact(12,1) = build_contact(12,1)+1;
                elseif inpolygon(re_lat(j,1),re_long(j,1),hakgwan(:,1),hakgwan(:,2))
                    build_contact(13,1) = build_contact(13,1)+1;
                elseif inpolygon(re_lat(j,1),re_long(j,1),jiphyun(:,1),jiphyun(:,2))
                    build_contact(14,1) = build_contact(14,1)+1;
                elseif inpolygon(re_lat(j,1),re_long(j,1),daeyang(:,1),daeyang(:,2))
                    build_contact(15,1) = build_contact(15,1)+1;            
                elseif inpolygon(re_lat(j,1),re_long(j,1),edang(:,1),edang(:,2))
                    build_contact(16,1) = build_contact(16,1)+1;
                elseif inpolygon(re_lat(j,1),re_long(j,1),aeji(:,1),aeji(:,2))
                    build_contact(17,1) = build_contact(17,1)+1;
            end
        end
    %figure; geoplot(re_lat,re_long,'o');
    end

    % 건물별 최고 빈도수 비교 및 build_name, course(i,9)에 입력
    for j = 1:length(build_contact)
        if build_contact(j,1) > max
            max = build_contact(j,1);
            build_num = j;
        end
    end
    course(i,9) = build_num;
    % 건물안 gps와 건물밖 gps 좌표플로팅

    % if build_num==1
    %     data_course=data(course(i,7):course(i,8),:);
    %     in= inpolygon(data(course(i,7):course(i,8),5),data(course(i,7):course(i,8),6),chungmu(:,1),chungmu(:,2));
    %     figure; geoplot(data_course(in,5),data_course(in,6),'r+');
    %     hold on; geoplot(data_course(~in,5),data_course(~in,6),'bo');
    % elseif build_num==2
    %     data_course=data(course(i,7):course(i,8),:);
    %     in= inpolygon(data(course(i,7):course(i,8),5),data(course(i,7):course(i,8),6),dasan(:,1),dasan(:,2));
    %     figure; geoplot(data_course(in,5),data_course(in,6),'r+');
    %     hold on; geoplot(data_course(~in,5),data_course(~in,6),'bo');
    % elseif build_num==3
    %     data_course=data(course(i,7):course(i,8),:);
    %     in= inpolygon(data(course(i,7):course(i,8),5),data(course(i,7):course(i,8),6),hakjung(:,1),hakjung(:,2));
    %     figure; geoplot(data_course(in,5),data_course(in,6),'r+');
    %     hold on; geoplot(data_course(~in,5),data_course(~in,6),'bo');
    % else
    % end
end



end