%% <Caution!> The name 'raw_Sample' must be changed to the sample's name
%% Initializing
clear all

%%fclose(instrfindall)
delete(instrfindall)

%%EMG_RAW1=Bluetooth('band2',1);
EMG_RAW2=Bluetooth('BAND1',1);
%%fopen(EMG_RAW1);
fopen(EMG_RAW2);
%%raw_test1=zeros(20,12,30);
raw_test2=zeros(20,12,30);
%%raw_zero1=zeros(20,12);
raw_zero2=zeros(20,12);



%% Zero Squence

for nn=1:20
    pause(0.025)
%%raw_zero1(nn,:)=str2num(fgetl(EMG_RAW1));
raw_zero2(nn,:)=str2num(fgetl(EMG_RAW2));
end

%%raw_zero1=mean(raw_zero1);
raw_zero2=mean(raw_zero2);

%% Collect data

j=0
%raw_zero1EMG=raw_zero1(:,5:12);   
%raw_zero2EMG=raw_zero2(:,5:12);
while 1

%%A=str2num(fscanf(EMG_RAW1));
B=str2num(fscanf(EMG_RAW2));
%%raw_zero1EMG=A(:,5:12);
raw_zero2EMG=B(:,5:12);

% diagnose data change7
if max(max(raw_zero2EMG-raw_zero2(:,5:12)))>0.110 || min(min(raw_zero2EMG-raw_zero2(:,5:12)))<-0.110
tic
for i=1:20
%%raw_test1(i,:,j+1)=str2num(fscanf(EMG_RAW1));
raw_test2(i,:,j+1)=str2num(fscanf(EMG_RAW2));
pause(0.20)
end
toc
j=j+1
end
if j>29
    break

end
end



%% Combine test1 & test2 (raw_Sample)
%for i=1:20
    
%raw_Sample(i,:,j+1)=raw_test1(i,:,j+1);
%raw_Sample(i+20,:,j+21)=raw_test2(i,:,j+1);
%pause(0.20)


%j=j+1

%j>29
%    break
%end

