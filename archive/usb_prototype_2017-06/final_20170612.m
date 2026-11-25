tic; close all;
%% Start
i=1;j=1;n=1;
Pro_Vector_FIST=nan(300,20);
while n<=length(time)
    
    if ch1(i,1)>1.94 || ch1(i,1)<1.84 ||...
            ch2(i,1)>1.94 || ch2(i,1)<1.80 || ch3(i,1)>1.94 || ch3(i,1)<1.80 ||...
            ch4(i,1)>1.94 || ch4(i,1)<1.80 || ch5(i,1)>1.94 || ch5(i,1)<1.80 ||...
            ch6(i,1)>1.94 || ch6(i,1)<1.80
        Pro_Vector_FIST(:,j)=[ch1(i:i+49);ch2(i:i+49);ch3(i:i+49);ch4(i:i+49);ch5(i:i+49);ch6(i:i+49)];
        i=i+90;
        j=j+1;
    end
    i=i+1;
    
    if j==30;
        break;
    end
end
     
i=1;j=1;n=1;
Pro_Vector_Stretch=nan(300,20);
while n<=length(time)
    
    if chS1(i,1)>1.94 || chS1(i,1)<1.84 ||...
            chS2(i,1)>1.94 || chS2(i,1)<1.80 || chS3(i,1)>1.94 || chS3(i,1)<1.80 ||...
            chS4(i,1)>1.94 || chS4(i,1)<1.80 || chS5(i,1)>1.94 || chS5(i,1)<1.80 ||...
            chS6(i,1)>1.94 || chS6(i,1)<1.80
        Pro_Vector_Stretch(:,j)=[chS1(i:i+49);chS2(i:i+49);chS3(i:i+49);chS4(i:i+49);chS5(i:i+49);chS6(i:i+49)];
        i=i+90;
        j=j+1;
    end
    i=i+1;
    
    if j==30;
        break;
    end
end
     
i=1;j=1;n=1;
Pro_Vector_WaveIn=nan(300,20);
while n<=length(time)
    
    if chWI1(i,1)>1.94 || chWI1(i,1)<1.84 ||...
            chWI2(i,1)>1.94 || chWI2(i,1)<1.80 || chWI3(i,1)>1.94 || chWI3(i,1)<1.80 ||...
            chWI4(i,1)>1.94 || chWI4(i,1)<1.80 || chWI5(i,1)>1.94 || chWI5(i,1)<1.80 ||...
            chWI6(i,1)>1.94 || chWI6(i,1)<1.80
        Pro_Vector_WaveIn(:,j)=[chWI1(i:i+49);chWI2(i:i+49);chWI3(i:i+49);chWI4(i:i+49);chWI5(i:i+49);chWI6(i:i+49)];
        i=i+90;
        j=j+1;
    end
    i=i+1;
    
    if j==30;
        break;
    end
end

     
i=1;j=1;n=1;
Pro_Vector_WaveOut=nan(300,20);
while n<=length(time)
    
    if chWO1(i,1)>1.94 || chWO1(i,1)<1.84 ||...
            chWO2(i,1)>1.94 || chWO2(i,1)<1.80 || chWO3(i,1)>1.94 || chWO3(i,1)<1.80 ||...
            chWO4(i,1)>1.94 || chWO4(i,1)<1.80 || chWO5(i,1)>1.94 || chWO5(i,1)<1.80 ||...
            chWO6(i,1)>1.94 || chWO6(i,1)<1.80
        Pro_Vector_WaveOut(:,j)=[chWO1(i:i+49);chWO2(i:i+49);chWO3(i:i+49);chWO4(i:i+49);chWO5(i:i+49);chWO6(i:i+49)];
        i=i+90;
        j=j+1;
    end
    i=i+1;
    
    if j==30;
        break;
    end
end

%% Smooth

Pro_Vector_FIST_Smooth=nan(300,29);
Pro_Vector_Stretch_Smooth=nan(300,29);
Pro_Vector_WaveIn_Smooth=nan(300,29);
Pro_Vector_WaveOut_Smooth=nan(300,29);

for i=1:28
Pro_Vector_FIST_Smooth(:,i)=smooth(Pro_Vector_FIST(:,i));
Pro_Vector_Stretch_Smooth(:,i)=smooth(Pro_Vector_Stretch(:,i));
Pro_Vector_WaveIn_Smooth(:,i)=smooth(Pro_Vector_WaveIn(:,i));
Pro_Vector_WaveOut_Smooth(:,i)=smooth(Pro_Vector_WaveOut(:,i));
end

%% Reduce Sample
samp=15;
    Pro_Vector_FIST_re=nan(100,29);
    Pro_Vector_Stretch_re=nan(100,29);
    Pro_Vector_WaveIn_re=nan(100,29);
    Pro_Vector_WaveOut_re=nan(100,29);

for ii=1:29
    j=1
for i=1:samp:300
    Pro_Vector_FIST_re(j,ii)=(Pro_Vector_FIST(i,ii)+Pro_Vector_FIST(i+1,ii)+Pro_Vector_FIST(i+2,ii))/samp;
    Pro_Vector_Stretch_re(j,ii)=(Pro_Vector_Stretch(i,ii)+Pro_Vector_Stretch(i+1,ii)+Pro_Vector_Stretch(i+2,ii))/samp;
    Pro_Vector_WaveIn_re(j,ii)=(Pro_Vector_WaveIn(i,ii)+Pro_Vector_WaveIn(i+1,ii)+Pro_Vector_WaveIn(i+2,ii))/samp;
    Pro_Vector_WaveOut_re(j,ii)=(Pro_Vector_WaveOut(i,ii)+Pro_Vector_WaveOut(i+1,ii)+Pro_Vector_WaveOut(i+2,ii))/samp;
    j=j+1;
end
end
Pro_Vector_FIST_Smooth=nan(100,29);
Pro_Vector_Stretch_Smooth=nan(100,29);
Pro_Vector_WaveIn_Smooth=nan(100,29);
Pro_Vector_WaveOut_Smooth=nan(100,29);
for i=1:28
Pro_Vector_FIST_Smooth(:,i)=smooth(Pro_Vector_FIST_re(:,i));
Pro_Vector_Stretch_Smooth(:,i)=smooth(Pro_Vector_Stretch_re(:,i));
Pro_Vector_WaveIn_Smooth(:,i)=smooth(Pro_Vector_WaveIn_re(:,i));
Pro_Vector_WaveOut_Smooth(:,i)=smooth(Pro_Vector_WaveOut_re(:,i));
end


%% Visual
% figure
% plot(time(1:300),Pro_Vector_FIST)
% title('FIST')
% figure
% plot(time(1:300),Pro_Vector_Stretch)
% title('Stretch')
% figure
% plot(time(1:300),Pro_Vector_WaveIn)
% title('WaveIn')
% figure
% plot(time(1:300),Pro_Vector_WaveOut)
% title('WaveOut')

% figure
% plot(time(1:300),Pro_Vector_FIST_Smooth)
% title('FIST')
% figure
% plot(time(1:300),Pro_Vector_Stretch_Smooth)
% title('Stretch')
% figure
% plot(time(1:300),Pro_Vector_WaveIn_Smooth)
% title('WaveIn')
% figure
% plot(time(1:300),Pro_Vector_WaveOut_Smooth)
% title('WaveOut')


% 
% figure
% plot(time(1:100)*3,Pro_Vector_FIST_re)
% title('FIST')
% figure
% plot(time(1:100)*3,Pro_Vector_Stretch_re)
% title('Stretch')
% figure
% plot(time(1:100)*3,Pro_Vector_WaveIn_re)
% title('WaveIn')
% figure
% plot(time(1:100)*3,Pro_Vector_WaveOut_re)
% title('WaveOut')


figure
plot(time(1:100)*3,Pro_Vector_FIST_re)
title('FIST')
axis([0 0.6 0.30 0.6])
figure
plot(time(1:100)*3,Pro_Vector_Stretch_re)
title('Stretch')
axis([0 0.6 0.30 0.6])
figure
plot(time(1:100)*3,Pro_Vector_WaveIn_re)
title('WaveIn')
axis([0 0.6 0.30 0.6])
figure
plot(time(1:100)*3,Pro_Vector_WaveOut_re)
title('WaveOut')
axis([0 0.6 0.30 0.6])
toc;