b=mean(abs(sci_F-2.1)');
c=mean(abs(stretch_F-2.1)');
subplot(2,2,1)
plot(a)
ylim([0 1]);
xlim([0 120]);
subplot(2,2,2)
plot(b)
subplot(2,2,3)
plot(c)


subplot(3,1,1);
plot(fist_F);
subplot(3,1,2);
plot(sci_F);
subplot(3,1,3);
plot(raw_fist_F);

input = nan(1200,350);
input(:, 1:30) = raw_fis_F_1(:,1:30);
input(:, 31:60) = raw_fis_F_2(:,1:30);
input(:, 61:70) = raw_fis_F_3(:,1:10);
input(:, 71:100) = raw_sci_F_1(:,1:30);
input(:, 101:130) = raw_sci_F_2(:,1:30);
input(:, 131:140) = raw_sci_F_3(:,1:10);
input(:, 141:170) = raw_pap_F_1(:,1:30);
input(:, 171:200) = raw_pap_F_2(:,1:30);
input(:, 201:210) = raw_pap_F_3(:,1:10);
input(:, 211:240) = raw_sta_F_1(:,1:30);
input(:, 241:270) = raw_sta_F_2(:,1:30);
input(:, 271:280) = raw_sta_F_3(:,1:10);
input(:, 281:310) = raw_fin_F_1(:,1:30);
input(:, 311:340) = raw_fin_F_2(:,1:30);
input(:, 341:350) = raw_fin_F_3(:,1:10);

input = nan(1200,300);
input(:, 1:30) = raw_fis_F_1(:,1:30);
input(:, 31:60) = raw_fis_F_2(:,1:30);

input(:, 61:90) = raw_sci_F_1(:,1:30);
input(:, 91:120) = raw_sci_F_2(:,1:30);

input(:, 121:150) = raw_pap_F_1(:,1:30);
input(:, 151:180) = raw_pap_F_2(:,1:30);

input(:, 181:210) = raw_sta_F_1(:,1:30);
input(:, 211:240) = raw_sta_F_2(:,1:30);

input(:, 241:270) = raw_fin_F_1(:,1:30);
input(:, 271:300) = raw_fin_F_2(:,1:30);


input = nan(600,150);
input(:, 1:30) = raw_fis_F_T(:,1:30);
input(:, 31:60) = raw_sci_F_T(:,1:30);
input(:, 61:90) = raw_pap_F_T(:,1:30);
input(:, 91:120) = raw_sta_F_T(:,1:30);
input(:, 121:150) = raw_fin_F_T(:,1:30);
input(:, 161:200) = raw_pap_F_T(:,1:40);
input(:, 201:230) = raw_in_F_1(:,1:30);
input(:, 231:260) = raw_in_F_2(:,1:30);
input(:, 261:300) = raw_in_F_T(:,1:40);
input(:, 301:330) = raw_out_F_1(:,1:30);
input(:, 331:360) = raw_out_F_2(:,1:30);
input(:, 361:400) = raw_out_F_T(:,1:40);

for i=1:5
target(i,(i-1)*70+1:i*70)=1;
end
for i=1:4
testtarget(i,(i-1)*20+1:i*20)=1;
end

input = nan(1200,120);
input(:, 1:30) = raw_fis_F_1(:,1:30);
input(:, 31:60) = raw_pap_F_1(:,1:30);
input(:, 61:90) = raw_in_F_1(:,1:30);
input(:, 91:120) = raw_out_F_1(:,1:30);

input = nan(1200,240);
input(:, 1:30) = raw_fis_F_1(:,1:30);
input(:, 31:60) = raw_fis_F_2(:,1:30);

input(:, 61:90) = raw_pap_F_1(:,1:30);
input(:, 91:120) = raw_pap_F_2(:,1:30);

input(:, 121:150) = raw_in_F_1(:,1:30);
input(:, 151:180) = raw_in_F_2(:,1:30);

input(:, 181:210) = raw_out_F_1(:,1:30);
input(:, 211:240) = raw_out_F_2(:,1:30);

testinput = nan(1200, 80);
testinput(:,1:20) = raw_fis_F_T(:,21:40);
testinput(:,21:40) = raw_pap_F_T(:,21:40);
testinput(:,41:60) = raw_in_F_T(:,21:40);
testinput(:,61:80) = raw_out_F_T(:,21:40);

input = nan(1200,320);
input(:,1:30) = raw_fis_F_1;
input(:,31:60) = raw_fis_F_2;
input(:,61:80) = raw_fis_F_T(:,1:20);
input(:,81:110) = raw_pap_F_1;
input(:,111:140) = raw_pap_F_2;
input(:,141:160) = raw_pap_F_T(:,1:20);
input(:,161:190) = raw_in_F_1;
input(:,191:220) = raw_in_F_2;
input(:,221:240) = raw_in_F_T(:,1:20);
input(:,241:270) = raw_out_F_1;
input(:,271:300) = raw_out_F_2;
input(:,301:320) = raw_out_F_T(:,1:20);

input = nan(1200,200);
input(:,1:30) = raw_fis_F_1;
input(:,31:50) = raw_fis_F_2(:,1:20);

input(:,51:80) = raw_pap_F_1;
input(:,81:100) = raw_pap_F_2(:,1:20);

input(:,101:130) = raw_in_F_1;
input(:,131:150) = raw_in_F_2(:,1:20);

input(:,151:180) = raw_out_F_1;
input(:,181:200) = raw_out_F_2(:,1:20);


%%
raw_fis_train = nan(1200,60);
raw_fis_train(:,1:30) = raw_fis_F_1;
raw_fis_train(:,31:60) = raw_fis_F_2;

raw_pap_train = nan(1200,60);
raw_pap_train(:,1:30) = raw_pap_F_1;
raw_pap_train(:,31:60) = raw_pap_F_2;

raw_in_train = nan(1200,60);
raw_in_train(:,1:30) = raw_in_F_1;
raw_in_train(:,31:60) = raw_in_F_2;

raw_out_train = nan(1200,60);
raw_out_train(:,1:30) = raw_out_F_1;
raw_out_train(:,31:60) = raw_out_F_2;

subplot(2,2,1)
plot(raw_fis_train)
xlim([0 1200])
ylim([-70 550])
subplot(2,2,2)
plot(raw_pap_train)
xlim([0 1200])
ylim([-70 550])
subplot(2,2,3)
plot(raw_in_train)
xlim([0 1200])
ylim([-70 550])
subplot(2,2,4)
plot(raw_out_train)
xlim([0 1200])
ylim([-70 550])
plot(raw_fis_train)

raw_fis_F = nan(1200,100);
raw_fis_F(:,1:30) = raw_fis_F_1;
raw_fis_F(:,31:60) = raw_fis_F_2;
raw_fis_F(:,61:100) = raw_fis_F_T;
raw_pap_F = nan(1200,100);
raw_pap_F(:,1:30) = raw_pap_F_1;
raw_pap_F(:,31:60) = raw_pap_F_2;
raw_pap_F(:,61:100) = raw_pap_F_T;
raw_in_F = nan(1200,100);
raw_in_F(:,1:30) = raw_in_F_1;
raw_in_F(:,31:60) = raw_in_F_2;
raw_in_F(:,61:100) = raw_in_F_T;
raw_out_F = nan(1200,100);
raw_out_F(:,1:30) = raw_out_F_1;
raw_out_F(:,31:60) = raw_out_F_2;
raw_out_F(:,61:100) = raw_out_F_T;

%% mean 1/25
mean25_fis = nan(48,100);
mean25_pap = nan(48,100);
mean25_in = nan(48,100);
mean25_out = nan(48,100);
for n=1:48
mean25_fis(n,:)=mean(raw_fis_F(25*(n-1)+1:25*n,:));
end
for n=1:48
mean25_pap(n,:)=mean(raw_pap_F(25*(n-1)+1:25*n,:));
end
for n=1:48
mean25_in(n,:)=mean(raw_in_F(25*(n-1)+1:25*n,:));
end
for n=1:48
mean25_out(n,:)=mean(raw_out_F(25*(n-1)+1:25*n,:));
end

mean25 = nan(48,400);
mean25(:,1:100) = mean25_fis;
mean25(:,101:200) = mean25_pap;
mean25(:,201:300) = mean25_in;
mean25(:,301:400) = mean25_out;

%% mean 1/50

mean50_fis = nan(24,100);
mean50_pap = nan(24,100);
mean50_in = nan(24,100);
mean50_out = nan(24,100);
for n=1:24
mean50_fis(n,:)=mean(raw_fis_F(50*(n-1)+1:50*n,:));
end
for n=1:24
mean50_pap(n,:)=mean(raw_pap_F(50*(n-1)+1:50*n,:));
end
for n=1:24
mean50_in(n,:)=mean(raw_in_F(50*(n-1)+1:50*n,:));
end
for n=1:24
mean505_out(n,:)=mean(raw_out_F(50*(n-1)+1:50*n,:));
end

mean50 = nan(24,400);
mean50(:,1:100) = mean50_fis;
mean50(:,101:200) = mean50_pap;
mean50(:,201:300) = mean50_in;
mean50(:,301:400) = mean50_out;

%% mean 1/100

mean100_fis = nan(12,100);
mean100_pap = nan(12,100);
mean100_in = nan(12,100);
mean100_out = nan(12,100);
for n=1:12
mean100_fis(n,:)=mean(raw_fis_F(100*(n-1)+1:100*n,:));
end
for n=1:12
mean100_pap(n,:)=mean(raw_pap_F(100*(n-1)+1:100*n,:));
end
for n=1:12
mean100_in(n,:)=mean(raw_in_F(100*(n-1)+1:100*n,:));
end
for n=1:12
mean100_out(n,:)=mean(raw_out_F(100*(n-1)+1:100*n,:));
end

mean100 = nan(12,400);
mean100(:,1:100) = mean100_fis;
mean100(:,101:200) = mean100_pap;
mean100(:,201:300) = mean100_in;
mean100(:,301:400) = mean100_out;

subplot(4,1,1)
plot(input)
subplot(4,1,2)
plot(mean25)
subplot(4,1,3)
plot(mean50)
subplot(4,1,4)
plot(mean100)