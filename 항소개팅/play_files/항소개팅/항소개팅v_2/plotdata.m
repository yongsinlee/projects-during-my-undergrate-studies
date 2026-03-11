day='tues';
fid=fopen('user_data.txt','rt');
line_user_data=fgetl(fid);
user_data=strsplit(line_user_data,'\t');
id=user_data{1};
filename=[id '_' day];
data=converter([pwd '\' id '\' filename '.csv'])
fclose(fid);
lat=data(:,5);
long=data(:,6);
figure; geoplot(lat,long,'o');