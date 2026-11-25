%% Pseudo-real-time EMG data extraction from Myo to MATLAB
% Extracts EMG data from a MYO to MATLAB via C++
% Requires MYO Connect to be running
% Runs a C++ executable in a command prompt

clear all; clc; close all % House keep

cell={'Hold fist','Stretch','Left','Right', 'Scissors'}' %출력할 클래스 이름
Y=[0;0;0;0;0]; % 출력할 클래스와 갯수 맞춰야함
tit=1;
%% Genmeral Setup
lineLength = 54;
numChannels = 8;
sampMax = 30000;
windowLength = 40;
curPosition = 0;


emgData = NaN([sampMax numChannels]); % Matrix for EMG data
mavData = NaN([(sampMax - windowLength) numChannels]); % Matrix for MAV feature
data=nan(50,8); %extract over baseline 특징 추출 때 쓰는 윈도우 행렬 크기만큼

gesture=nan(400,1); %전처리 이후 데이터 행렬 크기


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
           if max(mavData(row_address,:)) > 25 % base line value
               data(mini_cursor,:)=mavData(row_address,:);
               mini_cursor=mini_cursor+1;
            else
          tit='Idle'
          if  max(mavData(row_address,:)) < 25 && mod(row_address,10) == 0
          mini_cursor=1;
          data=nan(50,8); %윈도우 초기화
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
            Y=trainedNet(gesture); % Use Neural net pattern recognition Function
            tit=char(cell(find(max(Y)==Y),1));
   
            
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
    %title(['Current Gesture: ' tit],'fontsize',60)
    title([tit],'fontsize',60)
    %title(['Sample frequency: ' num2str(curSample/(curTime - startTime))])

    drawnow
   
    if curSample > sampMax % Clear arrays when large
        curSample = 1;
        lastSample = 1;
        mavData = NaN([(sampMax - windowLength) numChannels]);
        startTime = curTime;
    end
  
end


%% CLean up - target specific window made for this script
system(['taskkill /f /fi "WindowTitle eq  ' cmdWindowName '" /T & exit']) 
close(gcf)