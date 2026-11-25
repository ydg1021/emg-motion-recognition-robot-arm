%% imu start
imu = serial('COM3', 'BaudRate', 921600); %channel 100 top
imu2 = serial('COM9', 'BaudRate', 921600); %channel 0 bottom
imu.BytesAvailableFcn = @(imu,event) mycallback(imu, event);
imu2.BytesAvailableFcn = @(imu2,event) mycallback2(imu2, event);
fopen([imu imu2]);
%% jaco start
jc = JacoComm
connect(jc);
jc
%% initial condition
% jaco initial
q_home = [4.7009 ; 4.5141; 3.0639 ; 4.6479 ; 0.1919 ; 1.0088];
q_hand = [4.7009 ; 4.5141; 3.0639 ; 4.6479 ; 0.1919 ; 1.0088];
jntCmd = q_home;
sendJointPositionCommand(jc,jntCmd);
q_finger = ones(3,1);
% imu initial
rawdata = zeros(1,2);
rawdata2 = zeros(1,2);
rawdata(:,1) = DATA(1,3)*3.14/180*(-1);
rawdata(:,2) = DATA(1,4)*3.14/180;
rawdata2(:,1) = DATA2(1,3)*3.14/180*(-1);
rawdata2(:,2) = DATA2(1,4)*3.14/180*(-1);
LA = zeros(1,6);
LB = zeros(1,6);
%% Neural Test
cell={'Hold Fist';' Stretch';'Hand Out';'Hand In'};
Y=[0;0;0;0];
move=[0 0 0 0 0 0 ; 0 0 0 0 0 0 ; 0 0 0 0 0 -1 ; 0 0 0 0 0 1];
finger = [ 6000 ; 1/6000 ; 1 ; 1];
tit=1;
gesture = nan(1200,1);
figure(1) % Do after cmd call to bring to foreground
set(gcf,'currentchar',']') % Used for exit on button press
%% create session & data collect
s = daq.createSession('ni');
ch1 = s.addAnalogInputChannel('Dev1','ai0','Voltage');
ch2 = s.addAnalogInputChannel('Dev1','ai1','Voltage');
ch3 = s.addAnalogInputChannel('Dev1','ai2','Voltage');
s.Rate = 2000;
s.DurationInSeconds = 1;
s.NotifyWhenDataAvailableExceeds = 2000;
Rdata = zeros(3,400); % for real data standard data
movrms = nan(3,2000);
movingdata=zeros(1,2);
movingdata2=zeros(1,2);
    while get(gcf,'currentchar')==']'
    movingdata(:,1) = DATA(1,3)*3.14/180*(-1);
    movingdata(:,2) = DATA(1,4)*3.14/180;
    movingdata2(:,1) = DATA2(1,3)*3.14/180*(-1);
    movingdata2(:,2) = DATA2(1,4)*3.14/180;
    
        
    if max(abs(movingdata - rawdata)) > 0.174 | max(abs( movingdata2 - rawdata2)) > 0.174
    movingdata(:,1) = DATA(1,3)*3.14/180*(-1);
    movingdata(:,2) = DATA(1,4)*3.14/180;
    movingdata2(:,1) = DATA2(1,3)*3.14/180*(-1);
    movingdata2(:,2) = DATA2(1,4)*3.14/180;
    MA = movingdata - rawdata;
    MB = movingdata2 - rawdata2;
%     rawdata = movingdata;
%     rawdata2 = movingdata2;
    
    LA(:,1) = MA(:,2);
    LA(:,2) = MA(:,1)*(-1);
    LB(:,3) = MB(:,1);
    q_move = q_home + LA' + LB';
    q_move(6,1) = q_hand(6,1);
    jntCmd = q_move;
    q_finger = q_finger;
    fCmd = q_finger
    sendJointAndFingerPositionCommand(jc,jntCmd,fCmd);
    pause(0.3)
    end
    
    inputSingleScan(s);
if max(abs(inputSingleScan(s))) > 0.4
Rdata = zeros(3,400);
movrms = nan(3,2000);
gesture = nan(1200,1);
lh = addlistener(s,'DataAvailable', @(src,event) plot(event.TimeStamps, event.Data));
startBackground(s);
disp('Classifying...')
s.wait();
delete(lh)
%% extract data from fig.
fig = gcf;
dataObjs = findobj(fig,'-property','YData');
y1 = (dataObjs(1).YData )*100;
y2 = (dataObjs(2).YData )*100;
y3 = (dataObjs(3).YData )*100;
movrms(1,:) = sqrt(movmean(y1 .^ 2, 200));
movrms(2,:) = sqrt(movmean(y2 .^ 2, 200));
movrms(3,:) = sqrt(movmean(y3 .^ 2, 200));
%% normalization
m=1;

while 1
   
if max(movrms(1:3,m)) > max(max(movrms(1:3,:)))*0.9
    Rdata(1,1:400) = movrms(1,m:m+399);
    Rdata(2,1:400) = movrms(2,m:m+399);
    Rdata(3,1:400) = movrms(3,m:m+399);

end
m=m+1;
if Rdata(1:3,1:400) > 0
    break
end
end

%% plot


plot(Rdata')


%% Neural part
data = Rdata';
gesture(1:400,:)=data(1:400,1);
gesture(401:800,:)=data(1:400,2);
gesture(801:1200,:)=data(1:400,3);
RVC = max(gesture);
gesture = gesture/RVC;
Y=dg_hsho(gesture); %% 인공신경망
tit=char(cell(find(max(Y)==Y),1)) %% 분류결과
title([tit],'fontsize',60)
q_move = q_move + move(find(max(Y)==Y),:)';
                jntCmd = q_move;
                q_hand(6,1) = q_move(6,1);
                q_finger = q_finger*finger(find(max(Y)==Y),:);
                fCmd = q_finger
                sendJointAndFingerPositionCommand(jc,jntCmd,fCmd);
                pause(0.5)
end

drawnow

    end

%     delete(instrfindall)