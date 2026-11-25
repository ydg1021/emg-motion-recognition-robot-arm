%% Initializing
clear all

%fclose(instrfindall)
delete(instrfindall)

EMG_RAW=serial('COM5','baudrate',115200);
fopen(EMG_RAW);
raw_left_wave_in4ch=zeros(20,8,50);
raw_zero=zeros(20,8);

%% Zero Squence
tic
for nn=1:20
pause(0.025)
raw_zero(nn,:)=str2num(fgetl(EMG_RAW));
end
toc
raw_zero=mean(raw_zero);

%% Collect data

j=0




while 1
% diagnose data change
if max(str2num(fscanf(EMG_RAW))-raw_zero)>0.050 || min(str2num(fscanf(EMG_RAW))-raw_zero)<-0.050
    

for i=1:20
pause(0.025)
raw_left_wave_in4ch(i,:,j+1)=str2num(fscanf(EMG_RAW));
end


j=j+1
end




if j>49
    break
end
end