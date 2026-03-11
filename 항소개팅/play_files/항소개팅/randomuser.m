filename='user_timetable.txt';
for i=1:1500
    rand_user(i).id=num2str(randi([10000000 99999999]));
    rand_user(i).day = 'tue';
    rand_user(i).class1=randi([0 17]);
    rand_user(i).class2=randi([0 17]);
    rand_user(i).class3=randi([0 17]);
    rand_user(i).class4=randi([0 17]);
    rand_user(i).class5=randi([0 17]);
    rand_user(i).class6=randi([0 17]);
    rand_user(i).class7=randi([0 17]);
    rand_user(i).num=randi([1 6]);
    rand_user(i).want=randi([1 3]);
    rand_user(i).gender=randi([1 2]);
    rand_user(i).grade=randi([1 5]);
end
prefer(1).grade='1';
prefer(2).grade='2';
prefer(3).grade='3';
prefer(4).grade='4';
prefer(5).grade='5';
prefer(6).grade='all';
prefer(1).want='study';
prefer(2).want='meal';
prefer(3).want='friend';
gender(1).g='남자';
gender(2).g='여자';


fid1=fopen(filename,'at');
fid2=fopen('user_prefer.txt','at');
fid3=fopen('회원정보.txt','at');
fid4=fopen('user_want.txt','at');

al='all';
for i=1:1500
fprintf(fid1,'%s\t%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n',rand_user(i).id,rand_user(i).day,... 
    rand_user(i).class1,rand_user(i).class2,rand_user(i).class3,rand_user(i).class4, ... 
    rand_user(i).class5,rand_user(i).class6,rand_user(i).class7);
fprintf(fid2,'%s\t%s\t%s\t%s\ttue\n',rand_user(i).id,al,al,prefer(rand_user(i).num).grade);
fprintf(fid3,'%s\t0000\t물리천문학과\t%s\t%s\t%s\n',rand_user(i).id,gender(rand_user(i).gender).g,num2str(rand_user(i).grade),num2str(i));
fprintf(fid4,'%s\t%s\n',rand_user(i).id,prefer(rand_user(i).want).want);

end
fclose(fid1);
fclose(fid2);
fclose(fid3);
fclose(fid4);