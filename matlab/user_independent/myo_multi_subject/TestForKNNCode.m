
%NT_F = [C';
%    D';
%    J';
%    A';
%    E';
%    B'
%    ];

NT_F = [NE1_F(:,33:64)';
    NE2_F(:,33:64)';
    NE3_F(:,33:64)';
    NE4_F(:,33:64)';
    NE5_F(:,33:64)';
    NE6_F(:,33:64)'
    ];

%C, D, J, A, E, B order (hold fist, hold stretch, hand in, hand out,
%fist in, fist out)


EMGSignal = NT_F;

EMGData = array2table(EMGSignal);

yfit1 = cos1.predictFcn(EMGData);
yfit2 = cos3.predictFcn(EMGData);
yfit3 = cos5.predictFcn(EMGData);
yfit4 = cos7.predictFcn(EMGData);
yfit5 = cos9.predictFcn(EMGData);
yfit6 = che1.predictFcn(EMGData);
yfit7 = che3.predictFcn(EMGData);
yfit8 = che5.predictFcn(EMGData);
yfit9 = che7.predictFcn(EMGData);
yfit10 = che9.predictFcn(EMGData);
yfit11 = Che1.predictFcn(EMGData);
yfit12 = Che3.predictFcn(EMGData);
yfit13 = Che5.predictFcn(EMGData);
yfit14 = Che7.predictFcn(EMGData);
yfit15 = Che9.predictFcn(EMGData);


subplot(3,6,1);
plot(E);
subplot(3,6,7);
plot(NF5_F);
subplot(3,6,13);
plot(NFT6_F);
subplot(3,6,4);
plot(NFT4_F);
subplot(3,6,5);
plot(NFT5_F);
subplot(3,6,6);
plot(NFT6_F);
subplot(3,6,7);
plot(NF1_F);
subplot(3,6,8);
plot(NF2_F);
subplot(3,6,9);
plot(NF3_F);
subplot(3,6,10);
plot(NF4_F);
subplot(3,6,11);
plot(NF5_F);
subplot(3,6,12);
plot(NF6_F);
subplot(3,6,13);
plot(NG1_F);
subplot(3,6,14);
plot(NG2_F);
subplot(3,6,15);
plot(NG3_F);
subplot(3,6,16);
plot(NG4_F);
subplot(3,6,17);
plot(NG5_F);
subplot(3,6,18);
plot(NG6_F);