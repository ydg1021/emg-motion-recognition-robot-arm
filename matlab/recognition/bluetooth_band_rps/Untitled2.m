%% KNN : 열성분을 행성분으로 만든 후 클래스와 합쳐야 함
EMGSignal = nan(320,1200);
EMGSignal(1:80,:) = raw_fis_F(:,1:80)';
EMGSignal(81:160,:) = raw_pap_F(:,1:80)';
EMGSignal(161:240,:) = raw_in_F(:,1:80)';
EMGSignal(241:320,:) = raw_out_F(:,1:80)';

Classes = nan(320,1);
Classes(1:80, :) = 1;
Classes(81:160, :) = 2;
Classes(161:240, :) = 3;
Classes(241:320, :) = 4;

EMGData = array2table(EMGSignal);
EMGData.Class = categorical(Classes);

%% KNN : test code

NT_F = [raw_fis_F(:,81:100)';
    raw_pap_F(:,81:100)';
   raw_in_F(:,81:100)';
    raw_out_F(:,81:100)';
    ];


EMGSignal = NT_F;

EMGData = array2table(EMGSignal);

yfit1 = euc40_1.predictFcn(EMGData);
yfit2 = euc40_3.predictFcn(EMGData);
yfit3 = euc40_5.predictFcn(EMGData);
yfit4 = euc60_1.predictFcn(EMGData);
yfit5 = euc60_3.predictFcn(EMGData);
yfit6 = euc60_5.predictFcn(EMGData);
yfit7 = euc80_1.predictFcn(EMGData);
yfit8 = euc80_3.predictFcn(EMGData);
yfit9 = euc80_5.predictFcn(EMGData);