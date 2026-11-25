% rawEMGdata = nan(2000,4);
windowdata = nan(12,4,20);

n=1;
l=1;

%% DAQ setting
s = daq.createSession('ni');
s.Rate = 4000; % Sampling Rate

% Channel setting
addAnalogInputChannel(s,'Dev1','ai0','Voltage');

addAnalogInputChannel(s,'Dev1','ai1','Voltage');

addAnalogInputChannel(s,'Dev1','ai2','Voltage');

addAnalogInputChannel(s,'Dev1','ai3','Voltage');


while 1



if max(abs(inputSingleScan(s))) > 0.4;
tic;
    for m=1:12
    windowdata(m,:,l) = abs(inputSingleScan(s));
    end
 
    rawtesthandin(:,:,l) = windowdata(:,:,l);
    
%     for o = 1:10
%         windowdata(o+1,:,l) = (windowdata(o,:,l)+windowdata(o+2,:,l))/2;
%     end

        
    l=l+1
    m=1;
    pause(1.5)
    toc;
end


if l==21
    break
end


end