
cell={'Hold_fist','Stretch', 'hand_out', 'hand_in'}' %출력할 클래스 이름
windowdata = nan(12,4);
Y=[0;0;0;0];
tit=1;

while 1
    


if max(abs(inputSingleScan(s))) > 0.3;

    for m=1:12
    windowdata(m,:) = abs(inputSingleScan(s));
    end
    for o = 1:10
        windowdata(o+1,:) = (windowdata(o,:)+windowdata(o+2,:))/2;
    end
    
    
    gesture(1:12,:)=windowdata(1:12,1);
    gesture(13:24,:)=windowdata(1:12,2);
    gesture(25:36,:)=windowdata(1:12,3);
    gesture(37:48,:)=windowdata(1:12,4);
    Y=testtesttest(gesture);
    tit=char(cell(find(max(Y)==Y),1))
  
    windowdata = nan(12,4);
    pause(1.5);
    end



end