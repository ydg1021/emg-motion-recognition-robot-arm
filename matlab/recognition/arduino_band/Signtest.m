%% Initializing
clear all
%%쿼터니안각도사용 w,x,y,z
%fclose(instrfindall)
delete(instrfindall)

EMG_RAW=serial('COM5','baudrate',115200);
fopen(EMG_RAW);
raw_sig=zeros(20,12,30);
raw_zero=zeros(20,12);

%% Zero Squence
tic
for nn=1:20
pause(0.025)
raw_zero(nn,:)=str2num(fgetl(EMG_RAW));
end
toc
raw_zero=mean(raw_zero);
incoming=zeros(20,12);

%% Collect data

j=0
C=raw_zero(:,1:8);   

while 1

A=str2num(fscanf(EMG_RAW));
B=A(:,1:8);

% diagnose data change
if max(max(B-raw_zero(:,1:8)))>0.110 || min(min(B-raw_zero(:,1:8)))<-0.110

    incoming=zeros(20,12);

for i=1:20
pause(0.15)
incoming(i,:)=str2num(fscanf(EMG_RAW));
end

incoming_column=zeros(40,1);
for i=0:11
incoming_column(20*i+1:20*i+20)=incoming(:,i+1);
end
for k=0:39
   inputcol(k+1,:)=mean(incoming_column(6*k+1:6*k+6,:));
end
Pattern9(inputcol);
gis=ans;
if find(gis==max(gis))==1
    sprintf('안녕하세요')
elseif find(gis==max(gis))==2
    sprintf('만나서')
elseif find(gis==max(gis))==3
    sprintf('반갑습니다')
elseif find(gis==max(gis))==4
    sprintf('저는')
elseif find(gis==max(gis))==5
    sprintf('K')
elseif find(gis==max(gis))==6
    sprintf('I')
elseif find(gis==max(gis))==7
    sprintf('T')
elseif find(gis==max(gis))==8
    sprintf('학생')
elseif find(gis==max(gis))==9
    sprintf('입니다')
end

j=j+1;
end




if j>29
    break
end
end
