%% Pseudo-real-time EMG data extraction from Myo to MATLAB
% Extracts EMG data from a MYO to MATLAB via C++yfit=KNNC.predictFcn(A);
% Requires MYO Connect to be running
% Runs a C++ executable in a command prompt

%clear all; clc; close all % House keep

cell={'Hold Fist','Hold Stretch','Hand Out','Hand In','Fist Out','Fist In'}'
cell={'Hold Fist','Hold Stretch','Hand Out','Hand In','Fist Out','Fist In'}'
Y=[0;0;0;0;0;0];
tit=1;
%% Genmeral Setup
lineLength = 54;
numChannels = 8;
sampMax = 45000;
windowLength = 40;
curPosition = 0;


emgData = NaN([sampMax numChannels]); % Matrix for EMG data
mavData = NaN([(sampMax - windowLength) numChannels]); % Matrix for MAV feature
data=nan(200,8); %extract over baseline

gesture=nan(1,1600);


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
           if max(mavData(row_address,:)) > 25
               data(mini_cursor,:)=mavData(row_address,:);
               mini_cursor=mini_cursor+1;
            else
          tit='Idle';
          if  max(mavData(row_address,:)) < 25 && mod(row_address,10) == 0
          mini_cursor=1;
          data=nan(200,8);
           end
        end
        end
        
%         if mini_cursor==101
%             gesture(1:100,:)=data(1:100,1);
%             gesture(101:200,:)=data(1:100,2);
%             gesture(201:300,:)=data(1:100,3);
%             gesture(301:400,:)=data(1:100,4);
%             gesture(401:500,:)=data(1:100,5);
%             gesture(501:600,:)=data(1:100,6);
%             gesture(601:700,:)=data(1:100,7);
%             gesture(701:800,:)=data(1:100,8);
%             Y=Neural(gesture);
%             tit=char(cell(find(max(Y)==Y),1));
%             %pause(2)
%             mini_cursor=1;
%             data=nan(100,8);
%         end
        
            if mini_cursor==201%% 들어오는 데이터의 형식 바꿔주는 것
                Tdata=data';
            gesture(:,1:200)=Tdata(1,1:200);
            gesture(:,201:400)=Tdata(2,1:200);
            gesture(:,401:600)=Tdata(3,1:200);
            gesture(:,601:800)=Tdata(4,1:200);
            
            gesture(:,801:1000)=Tdata(5,1:200);
            gesture(:,1001:1200)=Tdata(6,1:200);
            gesture(:,1201:1400)=Tdata(7,1:200);
            gesture(:,1401:1600)=Tdata(8,1:200);
            EMGSignal = gesture;
            EMGData = array2table(EMGSignal);
            yfit=KNNC.predictFcn(EMGData)
           % tit=char(cell(find(max(yfit)==yfit),1));
            %pause(2)

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
    title("yfit",'fontsize',60)
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
%j_stretchright_2=mavData;