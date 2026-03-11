clear all;
fid=fopen('user_timetable.txt','rt');
fid2=fopen('user_want.txt','rt');
fid3=fopen('user_prefer.txt','rt');
c=0;
a=0;
while ~feof(fid)
    line=fgetl(fid);
    want_line=fgetl(fid2);
    pre_line=fgetl(fid3);
    ttable_data=strsplit(line,'\t');
    purpose=strsplit(char(want_line),'\t');
    prefer=strsplit(char(pre_line),'\t');
    if strcmp(ttable_data{1},'21011324')
        continue;
    end
    if (strcmp(ttable_data{4},'1') || strcmp(ttable_data{5},'1') ||  ...
            strcmp(ttable_data{5},'7'))&& strcmp(purpose{2},['friend']) 
        c=c+1;
        a=a+1;
        match_id{a}=prefer{1};

    end
end
fclose(fid);
fclose(fid2);
fclose(fid3);