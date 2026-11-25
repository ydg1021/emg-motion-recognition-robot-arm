%% Neural Test
cell={'Hold Fist';' Stretch';'Hand Out';'Hand In'};
Y=[0;0;0;0];
tit=1;
gesture = nan(1200,1);

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
figure(1) % Do after cmd call to bring to foreground
set(gcf,'currentchar',']') % Used for exit on button press

while get(gcf,'currentchar')==']' % While no button has been pressed

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
tic
fig = gcf;
dataObjs = findobj(fig,'-property','YData');
y1 = (dataObjs(1).YData )*100;
y2 = (dataObjs(2).YData )*100;
y3 = (dataObjs(3).YData )*100;
movrms(1,:) = sqrt(movmean(y1 .^ 2, 200));
movrms(2,:) = sqrt(movmean(y2 .^ 2, 200));
movrms(3,:) = sqrt(movmean(y3 .^ 2, 200));
%% ready for normalization
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
tic
data = Rdata';
gesture(1:400,:)=data(1:400,1);
gesture(401:800,:)=data(1:400,2);
gesture(801:1200,:)=data(1:400,3);
RVC = max(gesture);
gesture = gesture/RVC; % normalization
% gesture = gesture;
Y=after(gesture); %% 인공신경망
tit=char(cell(find(max(Y)==Y),1)) % 분류결과
toc
title([tit],'fontsize',60)
end

drawnow

end