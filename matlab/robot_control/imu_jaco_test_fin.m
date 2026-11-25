imu = serial('COM3', 'BaudRate', 921600); %channel 100 top
imu2 = serial('COM4', 'BaudRate', 921600); %channel 0 bottom
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
rawdata = DATA(1,3:4)*3.14/180*(-1);
rawdata2 = DATA2(1,3:4)*3.14/180*(-1);
LA = zeros(1,6);
LB = zeros(1,6);
rawdata = DATA(1,3:4)*3.14/180*(-1);
rawdata2 = DATA2(1,3:4)*3.14/180*(-1);
LA = zeros(1,6);
LB = zeros(1,6);
i=1;
before = zeros(10,3);
after = zeros(10,3);

while 1
    movingdata = DATA(1,3:4)*3.14/180;
    movingdata2 = DATA2(1,3:4)*3.14/180;
    disp('Ready')
    if max(abs(movingdata + rawdata)) > 0.087 | max(abs( movingdata2 + rawdata2)) > 0.087
        pause(1)

        
        movingdata = DATA(1,3:4)*3.14/180;
        movingdata2 = DATA2(1,3:4)*3.14/180;
        MA = movingdata + rawdata;
        MB = movingdata2 + rawdata2;
        LA(:,1) = MA(:,2);
        LA(:,2) = MA(:,1);
        LB(:,3) = -MB(:,1);
        q_move = q_home + LA' + LB';
        jntCmd = q_move;
        sendJointPositionCommand(jc,jntCmd);
        pause(2)
        pos = jc.JointPos;
        rawdata = DATA(1,3:4)*3.14/180*(-1);
        rawdata2 = DATA2(1,3:4)*3.14/180*(-1);
        q_home = q_move;
before(i,1) = jntCmd(1,:);
after(i,1) = pos(1,:);
before(i,2) = jntCmd(2,:);
after(i,2) = pos(2,:);
before(i,3) = jntCmd(3,:);
after(i,3) = pos(3,:);
i = i+1
    end
    if i == 11;
        break
    end
end
subplot(3,1,1)
plot(before(:,1))
hold on
plot(after(:,1))
subplot(3,1,2)
plot(before(:,2))
hold on
plot(after(:,2))
subplot(3,1,3)
plot(before(:,3))
hold on
plot(after(:,3))
configureCallback(imu,"off")