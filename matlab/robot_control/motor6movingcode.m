jc = JacoComm
connect(jc);
jc

q_home = [4.7009 ; 4.0141; 3.0639 ; 4.6479 ; 0.1919 ; 0];

jntCmd = q_home;
sendJointPositionCommand(jc,jntCmd);

rawdata = jntCmd ;
interv =1000;
init_time = 1;
x1=0;
x2=0;
q_move = q_home;
tic;
while 1


    jntCmd = q_move;
    sendJointPositionCommand(jc,jntCmd);
    

    pos = jc.JointPos;
    controlinput(1,init_time) = jntCmd(6,:);
    feedback(1,init_time) = pos(6,:);
%     x1=[x1,jntCmd(6,:)];
%     x2=[x2,pos(6,:)];
%     plot(x1)
%     xlim([0 interv])
%     ylim([0 3])
%     grid ON 
%     hold on
%     plot(x2)
%     xlim([0 interv])
%     ylim([0 3])
%     grid ON 
%     
%     xlabel(['Sample'])
%     ylabel(['rad'])
%     
%     drawnow
%     
    
    pause(0.01)
    if init_time == 200
    q_move = q_move+[0;0;0;0;0;1];
    end
    if init_time == 400
        q_move = q_move+[0;0;0;0;0;-1];
    end
    if init_time == 600
        q_move= q_move+[0;0;0;0;0;-1];
    end
    
        if init_time == 800
        q_move= q_move+[0;0;0;0;0;1];
    end
    
    if init_time>1000
        fig = gcf;

        break
    end
    
    init_time = init_time+1;
    
end

q_home = [4.7009 ; 4.0141; 3.0639 ; 4.6479 ; 0.1919 ; 0];

jntCmd = q_home;
sendJointPositionCommand(jc,jntCmd);
xaxis = [1:1001];
plot(xaxis,controlinput)
xlabel(['Sample'])
ylabel(['Position [u]'])
title(['Wrist Motor Position'])
xlim([0 1000])
ylim([-1.5 1.5])
hold on
plot(xaxis,feedback)