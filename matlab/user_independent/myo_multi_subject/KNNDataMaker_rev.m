EMGSignal = nan(384,800);

%% E, G, C, F are subject codes 
%% A1= Hold Fist, B1=Hold Stretch, C1=Stretch Right(Hand Out), D1=Stretch left(Hand In), E1=Fist Right(Fist Out), F1=Fist left(Fist In) Right Arm
%% A1= Hold Fist, B1=Hold Stretch, C1=Stretch Right(Hand In), D1=Stretch Left(Hand Out), E1=Fist Right(Fist In), F1=Fist Left(Fist Out) Left Arm
A1=C';
A2=NC1_F';
A3=NF1_F';
A4=NG1_F';
A5=NE1_F(:,1:32)';
B1=D';
B2=NC2_F';
B3=NF2_F';
B4=NG2_F';
B5=NE2_F(:,1:32)';
C1=J';
C2=NC3_F';
C3=NF3_F';
C4=NG3_F';
C5=NE3_F(:,1:32)';
D1=A';
D2=NC4_F';
D3=NF4_F';
D4=NG4_F';
D5=NE4_F(:,1:32)';
E1=E';
E2=NC5_F';
E3=NF5_F';
E4=NG5_F';
E5=NE5_F(:,1:32)';
F1=B';
F2=NC6_F';
F3=NF6_F';
F4=NG6_F';
F5=NE6_F(:,1:32)';


EMGSignal(1:64, :) = A1(1:64, 1:800);
EMGSignal(65:128, :) = A2(1:64,1:800);
EMGSignal(129:192, :) = A3(1:64,1:800);
EMGSignal(193:256, :) = A4(1:64,1:800);
EMGSignal(257:288, :) = A5(1:32,1:800);
%EMGSignal(401:500, :) = A5(1:100, 1:1600);
%EMGSignal(501:600, :) = A6(1:100, 1:1600);
EMGSignal(289:352, :) = B1(1:64, 1:800);
EMGSignal(353:416, :) = B2(1:64,1:800);
EMGSignal(417:480, :) = B3(1:64,1:800);
EMGSignal(481:544, :) = B4(1:64,1:800);
EMGSignal(545:576, :) = B5(1:32,1:800);
%EMGSignal(1001:1100, :) = B5(1:100, 1:1600);
%EMGSignal(1101:1200, :) = B6(1:100, 1:1600);
EMGSignal(577:640, :) = C1(1:64, 1:800);
EMGSignal(641:704, :) = C2(1:64, 1:800);
EMGSignal(705:768, :) = C3(1:64, 1:800);
EMGSignal(769:832, :) = C4(1:64, 1:800);
EMGSignal(833:864, :) = C5(1:32, 1:800);
%EMGSignal(1601:1700, :) = C5(1:100, 1:1600);
%EMGSignal(1701:1800, :) = C6(1:100, 1:1600);
EMGSignal(865:928, :) = D1(1:64, 1:800);
EMGSignal(929:992, :) = D2(1:64, 1:800);
EMGSignal(993:1056, :) = D3(1:64, 1:800);
EMGSignal(1057:1120, :) = D4(1:64, 1:800);
EMGSignal(1121:1152, :) = D5(1:32, 1:800);
%EMGSignal(2201:2300, :) = D5(1:100, 1:1600);
%EMGSignal(2301:2400, :) = D6(1:100, 1:1600);
EMGSignal(1153:1216, :) = E1(1:64, 1:800);
EMGSignal(1217:1280, :) = E2(1:64, 1:800);
EMGSignal(1281:1344, :) = E3(1:64, 1:800);
EMGSignal(1345:1408, :) = E4(1:64, 1:800);
EMGSignal(1409:1440, :) = E5(1:32, 1:800);
%EMGSignal(2801:2900, :) = E5(1:100, 1:1600);
%EMGSignal(2901:3000, :) = E6(1:100, 1:1600);
EMGSignal(1441:1504, :) = F1(1:64, 1:800);
EMGSignal(1505:1568, :) = F2(1:64, 1:800);
EMGSignal(1569:1632, :) = F3(1:64, 1:800);
EMGSignal(1633:1696, :) = F4(1:64, 1:800);
EMGSignal(1697:1728, :) = F5(1:32, 1:800);
%EMGSignal(3401:3500, :) = F5(1:100, 1:1600);
%EMGSignal(3501:3600, :) = F6(1:100, 1:1600);


Classes = nan(1728,1);
Classes(1:288, :) = 1;
Classes(289:576, :) = 2;
Classes(577:864, :) = 3;
Classes(865:1152, :) = 4;
Classes(1153:1440, :) = 5;
Classes(1441:1728, :) = 6;


EMGData = array2table(EMGSignal);
EMGData.Class = categorical(Classes);