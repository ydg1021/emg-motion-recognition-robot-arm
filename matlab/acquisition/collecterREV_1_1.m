%% Initializing
clear all

fclose(instrfindall)
delete(instrfindall)

EMG_RAW=serial('COM5','baudrate',115200);
fopen(EMG_RAW);
EMG_RAW=bt;
raw_k2=zeros(20,12,30);
raw_zero=zeros(20,12);


%% Zero Squence

for nn=1:20
    pause(0.025)
raw_zero(nn,:)=str2num(fgetl(EMG_RAW));
end

raw_zero=mean(raw_zero);

%% Collect data

j=0
C=raw_zero(:,1:8);   

while 1

A=str2num(fscanf(EMG_RAW));
B=A(:,1:8);

% diagnose data change
if max(max(B-raw_zero(:,1:8)))>0.110 || min(min(B-raw_zero(:,1:8)))<-0.110
    
tic
for i=1:20
raw_k2(i,:,j+1)=str2num(fscanf(EMG_RAW));
pause(0.20)
end
toc

j=j+1
end

if j>29
    break

end
end
