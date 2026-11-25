%% Bluetooth start
b = Bluetooth('YUK',1);
fopen(b);

%% Set initial condition
raw_sig=zeros(100,12,10);
raw_zero=zeros(100,12);
raw_zero_A2=zeros(1,12);
tic
for nn=1:100

raw_zero(nn,:)=str2num(fgetl(b));

end
toc
raw_zero_A2=mean(raw_zero);


%% Collect raw data
raw_sig=zeros(100,12,10);
j=0

while 1
c=str2num(fscanf(b));
d=c(:,1:6);
e=raw_zero_A2(:,1:6);
f=c(:,7:12);
g=raw_zero_A2(:,7:12);
if max(d-e)>15 || max(f-g)>100

for i=1:100

raw_sig(i,:,j+1)=str2num(fscanf(b));

end

j=j+1
pause(0.1)
end

if j>9
    
    break
    
end

end


%close and clear
fclose(b);
clear('b'); 

clear;clc

