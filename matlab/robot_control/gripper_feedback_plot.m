jc = JacoComm
connect(jc);
jc

fCmd = 0*ones(3,1);

sendFingerPositionCommand(jc,fCmd);

rawdata = fCmd ;

interv =800;
init_time = 1;
x1=0;
x2=0;
x3=0;
x4=0;
x5=0;
x6=0;
x7=0;
x8=0;
x9=0;
x10=0;
x11=0;
x12=0;


pause(1)

while 1


%     fCmd = 6000*ones(3,1);
%     sendFingerPositionCommand(jc,fCmd);
    

    
%     pos = jc.FingerPos;
    vel = jc.FingerVel;
    
    speed(1:3,init_time) = vel;
%     tol = jc.FingerTorque;
%     
%     x1=[x1,fCmd(1,:)];
%     x2=[x2,pos(1,:)];
%     x3=[x3,fCmd(2,:)];
%     x4=[x4,pos(2,:)];
%     x5=[x5,fCmd(3,:)];
%     x6=[x6,pos(3,:)];
%     
%     x7=[x7,vel(1,:)];
%     x8=[x8,vel(2,:)];
%     x9=[x9,vel(3,:)];
    
%     x10=[x10,tol(1,:)];
%     x11=[x11,tol(2,:)];
%     x12=[x12,tol(3,:)];
    
%     subplot(3,1,1)
%     plot(x1)
%     xlim([0 interv])
%     ylim([0 7000])
%     
%     xlabel(['Sample'])
%     ylabel(['Position [u]'])    
%     grid ON 
%     hold on
%     
%     plot(x2)
%     xlim([0 interv])
%     ylim([0 7000])
%     
% 
% 
%         plot(x3)
%     xlim([0 interv])
%     ylim([0 7000])
%     
%         plot(x4)
%     xlim([0 interv])
%     ylim([0 7000])
% 
%         plot(x5)
%     xlim([0 interv])
%     ylim([0 7000])
% 
%         plot(x6)
%     xlim([0 interv])
%     ylim([0 7000])

    
%     subplot(3,1,2)
    
%     plot(x7)
%     xlim([0 interv])
%     ylim([-0.3 0.3])
%     xlabel(['Sample'])
%     ylabel(['Velocity [u/s]']) 
% 
%     hold on
%     
%     plot(x8)
%     xlim([0 interv])
%     ylim([-0.3 0.3])
% 
%     plot(x9)
%     xlim([0 interv])
%     ylim([-0.3 0.3])

    
    
%     subplot(3,1,3)
%     
%     plot(x10)
%     xlim([0 interv])
%     ylim([-0.3 0.3])    
%     xlabel(['Sample'])
%     ylabel(['Torque [Nm]']) 
%     hold on
%     plot(x11)
%     xlim([0 interv])
%     ylim([-0.3 0.3])    
% 
%     plot(x12)
%     xlim([0 interv])
%     ylim([-0.3 0.3])    

%     drawnow
    
    pause(0.01)
    if init_time == 200
    fCmd = 5000*ones(3,1);
    sendFingerPositionCommand(jc,fCmd);
    end
    if init_time == 400
    fCmd = 0*ones(3,1);
    sendFingerPositionCommand(jc,fCmd);
    end
    if init_time == 600
    fCmd = 5000*ones(3,1);
    sendFingerPositionCommand(jc,fCmd);
    end
    
    init_time = init_time+1;
    
    if init_time>800
        fig = gcf;

        break
    end
end

fCmd = 0*ones(3,1);
sendFingerPositionCommand(jc,fCmd);
xaxis = 1:800
plot(xaxis,speed)