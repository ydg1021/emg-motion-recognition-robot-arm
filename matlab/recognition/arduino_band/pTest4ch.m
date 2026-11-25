%% Initializing
clear all

%fclose(instrfindall)
delete(instrfindall)

EMG_RAW=serial('COM5','baudrate',115200);
fopen(EMG_RAW);
raw_sig=zeros(20,8,50);
raw_zero=zeros(20,8);

%% Zero Squence
tic
for nn=1:20
pause(0.025)
raw_zero(nn,:)=str2num(fgetl(EMG_RAW));
end
toc
raw_zero=mean(raw_zero);
incoming=zeros(20,8);

%% Collect data

j=0




while 1
% diagnose data change
if max(str2num(fscanf(EMG_RAW))-raw_zero)>0.050 || min(str2num(fscanf(EMG_RAW))-raw_zero)<-0.050
    incoming=zeros(20,8);

for i=1:20
pause(0.025)
incoming(i,:)=str2num(fscanf(EMG_RAW));
end

incoming_column=zeros(40,1);
for i=0:7
incoming_column(20*i+1:20*i+20)=incoming(:,i+1);
end
for k=0:39
   inputcol(k+1,:)=mean(incoming_column(4*k+1:4*k+4,:));
end
pattern4ch_1(inputcol);
gis=ans;
if find(gis==max(gis))==1
    sprintf('WAVE OUT')
elseif find(gis==max(gis))==2
    sprintf('WAVE IN')
elseif find(gis==max(gis))==3
    sprintf('FIST')
end

j=j+1;
end




if j>49
    break
end
end

