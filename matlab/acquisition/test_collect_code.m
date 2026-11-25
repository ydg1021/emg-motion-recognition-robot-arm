

rawEMGdata = nan(5000,4); % EMG raw data Mat
windowdata = nan(50,1,2);

n=1;
l=1;

%% DAQ setting
s = daq.createSession('ni');
s.Rate = 2000; % Sampling Rate
s.NumberOfScans = 3000

% Channel setting
addAnalogInputChannel(s,'Dev1','ai0','Voltage');

addAnalogInputChannel(s,'Dev1','ai1','Voltage');

addAnalogInputChannel(s,'Dev1','ai2','Voltage');

addAnalogInputChannel(s,'Dev1','ai3','Voltage');


while 1

inputSingleScan(s);

if max(abs(inputSingleScan(s))) > 0.4;
    
tic;

startForeground(s);

toc;

end


if l==3
    break
end

% plot(rawEMGdata);
% xlim([0 5000])
% ylim([-10 10])
% drawnow 

end
% % 
% 
%  subplot(2,1,1)
% plot(windowdata(:,:,1))
% subplot(2,1,2)
% plot(fist(:,:,1))

plot(test(:,:,1))
hold on;
plot(test(:,:,2))