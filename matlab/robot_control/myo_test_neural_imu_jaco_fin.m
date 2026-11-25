% Pseudo-real-time EMG data extraction from Myo to MATLAB
% Extracts EMG data from a MYO to MATLAB via C++
% Requires MYO Connect to be running
% Runs a C++ executable in a command prompt

% clear all; clc; close all % House keep
imu = serial('COM6', 'BaudRate', 921600); %channel 100 top
imu2 = serial('COM3', 'BaudRate', 921600); %channel 0 bottom
imu.BytesAvailableFcn = @(imu,event) mycallback(imu, event);
imu2.BytesAvailableFcn = @(imu2,event) mycallback2(imu2, event);
fopen([imu imu2]);
jc = JacoComm
connect(jc);
jc
q_home = [4.7009 ; 4.5141; 3.0639 ; 4.6479 ; 0.1919 ; 1.0088];
q_hand = [4.7009 ; 4.5141; 3.0639 ; 4.6479 ; 0.1919 ; 1.0088];
jntCmd = q_home;
sendJointPositionCommand(jc,jntCmd);

q_finger = ones(3,1);

rawdata = zeros(1,2);
rawdata2 = zeros(1,2);
rawdata(:,1) = DATA(1,3)*3.14/180*(-1);
rawdata(:,2) = DATA(1,4)*3.14/180;
rawdata2(:,1) = DATA2(1,3)*3.14/180*(-1);
rawdata2(:,2) = DATA2(1,4)*3.14/180*(-1);
LA = zeros(1,6);
LB = zeros(1,6);



cell={'Hold Fist';' Stretch';'Hand In';'Hand Out'};
move=[0 0 0 0 0 0 ; 0 0 0 0 0 0 ; 0 0 0 0 0 0.5 ; 0 0 0 0 0 -0.5];
finger = [ 6000 ; 1/6000 ; 1 ; 1];
Y=[0;0;0;0];
tit=1;
movingdata=zeros(1,2);
movingdata2=zeros(1,2);
%% Genmeral Setup
lineLength = 54;
numChannels = 8;
sampMax = 30000;
windowLength = 40;
curPosition = 0;


emgData = NaN([sampMax numChannels]); % Matrix for EMG data
mavData = NaN([(sampMax - windowLength) numChannels]); % Matrix for MAV feature


data=nan(50,8); %extract over baseline

gesture=nan(400,1);


fileNameEMG = 'emg.txt'; % File for data transmission; again stop judging ^^
cmdWindowName = 'EMG Gather';

FileEMG = fopen(fileNameEMG,'w'); % Reset file
fclose(FileEMG); 

system(['start /realtime "' cmdWindowName '" getMyoEmg.exe & exit &']) % Start (non-blocking) C thread
figure(1) % Do after cmd call to bring to foreground
set(gcf,'currentchar',']') % Used for exit on button press

%% Pause for handshake with myo connect and for data collection to begin
pause(1);

%% Pseudo-realtime extraction
% Get first timestamp from file (and check data gathering is working)
FileEMG = fopen(fileNameEMG,'r'); 
fseek(FileEMG,curPosition,-1); 
fileDataRaw = fgetl(FileEMG);
if fileDataRaw == -1 
    system(['taskkill /f /fi "WindowTitle eq  ' cmdWindowName '" /T & exit']) 
    close(gcf)
    disp('Data acquisition not active')
    return;
end
fileDataStrArray = strsplit(fileDataRaw,',');
startTime = str2double(fileDataStrArray(end));
fclose(FileEMG);

curSample = 1;
lastSample = 1;
row_address=0;
mini_cursor=1;

while get(gcf,'currentchar')==']' % While no button has been pressed
    FileEMG = fopen(fileNameEMG,'r'); 
    fseek(FileEMG,curPosition,-1); 
    
    movingdata(:,1) = DATA(1,3)*3.14/180*(-1);
    movingdata(:,2) = DATA(1,4)*3.14/180;
    movingdata2(:,1) = DATA2(1,3)*3.14/180*(-1);
    movingdata2(:,2) = DATA2(1,4)*3.14/180*(-1);
    
        
    if max(abs(movingdata - rawdata)) > 0.174 | max(abs( movingdata2 - rawdata2)) > 0.174
    movingdata(:,1) = DATA(1,3)*3.14/180*(-1);
    movingdata(:,2) = DATA(1,4)*3.14/180;
    movingdata2(:,1) = DATA2(1,3)*3.14/180*(-1);
    movingdata2(:,2) = DATA2(1,4)*3.14/180*(-1);
    MA = movingdata - rawdata;
    MB = movingdata2 - rawdata2;

    
    LA(:,1) = MA(:,2);
    LA(:,2) = MA(:,1)*(-1);
    LB(:,3) = MB(:,1);
    q_move = q_home + LA' + LB';
    q_move(6,1) = q_hand(6,1);
    jntCmd = q_move;
    q_finger = q_finger;
    fCmd = q_finger
    sendJointAndFingerPositionCommand(jc,jntCmd,fCmd);

        pause(0.5)
               
    end       
    

    fileDataRaw = ' ';
    while ischar(fileDataRaw) % Extract new data from file
        fileDataRaw = fgetl(FileEMG);
        if numel(fileDataRaw) ~= lineLength % Break if last line incomplete (and seek back to start of that line
            fseek(FileEMG,-numel(fileDataRaw) ,0);
            break;
        end
        
        fileDataStrArray = strsplit(fileDataRaw,',');
        curTime = str2double(fileDataStrArray(end));
        emgData(curSample,:) = str2double(fileDataStrArray(1:numChannels));

        
        if curSample >= windowLength % MAV feature extraction
            mavData(curSample - windowLength + 1,:) = mean(abs(emgData(curSample - windowLength + 1:curSample,:)));
            row_address=row_address+1;
           if max(mavData(row_address,:)) > 30
               data(mini_cursor,:)=mavData(row_address,:);
               mini_cursor=mini_cursor+1;
               
           else
               tit='Idle';

          
          if  max(mavData(row_address,:)) < 10 && mod(row_address,10) == 0
            mini_cursor=1;
            data=nan(50,8);
            
            end
        end 
        end
        
            if mini_cursor==51
            gesture(1:50,:)=data(1:50,1);
            gesture(51:100,:)=data(1:50,2);
            gesture(101:150,:)=data(1:50,3);
            gesture(151:200,:)=data(1:50,4);
            gesture(201:250,:)=data(1:50,5);
            gesture(251:300,:)=data(1:50,6);
            gesture(301:350,:)=data(1:50,7);
            gesture(351:400,:)=data(1:50,8);
            %Y=Neural_100(gesture);
            Y=trainedNet(gesture); %% 인공신경망
            tit=char(cell(find(max(Y)==Y),1)); %% 분류결과
            q_move = q_move + move(find(max(Y)==Y),:)';
                jntCmd = q_move;
                q_hand(6,1) = q_move(6,1);
                q_finger = q_finger*finger(find(max(Y)==Y),:);
                fCmd = q_finger
                sendJointAndFingerPositionCommand(jc,jntCmd,fCmd);
                pause(0.5)
            
            end

        curSample = curSample + 1;
            
    end
    curPosition = ftell(FileEMG);
    fclose(FileEMG); 
    
    if curSample - lastSample == 0 % Don't waste time drawing if no new data
        continue;
    else
        lastSample = curSample;  
    end
    
    % Plots    

    plot(mavData)
    ylim([0 100])
    xlim([1 sampMax])
    set(gcf, 'Position', [0, 500, 1000, 300])
    title([tit],'fontsize',60)

    
    drawnow
    
    
    
    if curSample > sampMax % Clear arrays when large
        curSample = 1;
        lastSample = 1;
        mavData = NaN([(sampMax - windowLength) numChannels]);
        startTime = curTime;
    end
end


%% CLean up - target specific window made for this script
system(['taskkill /f /fi "WindowTitle eq ' cmdWindowName '" /T & exit']) 
close(gcf)
delete(instrfindall)