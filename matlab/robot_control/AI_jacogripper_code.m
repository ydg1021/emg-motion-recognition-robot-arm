tit=1;
gesture = nan(3600,1);
s = daq.createSession('ni');
ch1 = s.addAnalogInputChannel('Dev1','ai0','Voltage');
ch2 = s.addAnalogInputChannel('Dev1','ai1','Voltage');
ch3 = s.addAnalogInputChannel('Dev1','ai2','Voltage');
s.Rate = 2000;
s.DurationInSeconds = 1;
s.NotifyWhenDataAvailableExceeds = 2000;
Rdata = zeros(3,1200); % for real data standard data
movrms = nan(3,2000);
figure(1) % Do after cmd call to bring to foreground
set(gcf,'currentchar',']') % Used for exit on button press
q_finger = ones(3,1);
cell={'Hold Fist';' Stretch';'Hand Out';'Hand In'};
Y=[0;0;0;0];
move=[0 0 0 0 0 0 ; 0 0 0 0 0 0 ; 0 0 0 0 0 0.5 ; 0 0 0 0 0 -0.5];
jc = JacoComm
connect(jc);
jc
finger = [ 6000 ; 1/6000 ; 1 ; 1];

while get(gcf,'currentchar')==']' % While no button has been pressed

inputSingleScan(s);
if max(abs(inputSingleScan(s))) > 0.3
Rdata = zeros(3,1200);
movrms = nan(3,2000);
gesture = nan(3600,1);
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
   
if max(movrms(1:3,m)) > max(max(movrms(1:3,:)))*0.3
    Rdata(1,1:1200) = movrms(1,m:m+1199);
    Rdata(2,1:1200) = movrms(2,m:m+1199);
    Rdata(3,1:1200) = movrms(3,m:m+1199);

end
m=m+1;
if Rdata(1:3,1:1200) > 0
    break
end
end
%% plot

plot(Rdata')


%% Neural part
data = Rdata';
gesture(1:1200,:)=data(1:1200,1);
gesture(1201:2400,:)=data(1:1200,2);
gesture(2401:3600,:)=data(1:1200,3);
RVC = max(gesture);
gesture = gesture/RVC;
Y=noraxon(gesture); %% 인공신경망
tit=char(cell(find(max(Y)==Y),1)) %% 분류결과

title([tit],'fontsize',60)


q_finger = q_finger*finger(find(max(Y)==Y),:);
fCmd = q_finger

sendFingerPositionCommand(jc,fCmd);
end

drawnow

end