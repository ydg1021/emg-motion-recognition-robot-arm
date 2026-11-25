%creat a bluetooth object
%HC-05 channel default is 1
b = Bluetooth('YUK',1);
fopen(b);

%write and read function
raw_sig=zeros(50,12,1);
raw_sig_F=zeros(600,1);

k=1
figure(1)
while 1
c=str2num(fscanf(b));
d=c(:,1:6);
e=raw_zero_A(:,1:6);
f=c(:,7:12);
g=raw_zero_A(:,7:12);
if max(d-e)>15 || max(f-g)>100

for i=1:50

raw_sig(i,:,1)=str2num(fscanf(b));

end

raw_sig_A=raw_sig;
raw_sig_F(1:50,1)=raw_sig_A(1:50,1,1);
raw_sig_F(51:100,1)=raw_sig_A(1:50,2,1);
raw_sig_F(101:150,1)=raw_sig_A(1:50,3,1);
raw_sig_F(151:200,1)=raw_sig_A(1:50,4,1);
raw_sig_F(201:250,1)=raw_sig_A(1:50,5,1);
raw_sig_F(251:300,1)=raw_sig_A(1:50,6,1);
raw_sig_F(301:350,1)=raw_sig_A(1:50,7,1);
raw_sig_F(351:400,1)=raw_sig_A(1:50,8,1);
raw_sig_F(401:450,1)=raw_sig_A(1:50,9,1);
raw_sig_F(451:500,1)=raw_sig_A(1:50,10,1);
raw_sig_F(501:550,1)=raw_sig_A(1:50,11,1);
raw_sig_F(551:600,1)=raw_sig_A(1:50,12,1);

RSP_9(raw_sig_F);
gis=ans;

 if find(max(gis)==gis) ==1
             title(['rock'],'fontsize',80)
      
        elseif find(max(gis)==gis) ==2
           title(['scissors'],'fontsize',80)

        elseif find(max(gis)==gis) ==3
            title(['paper'],'fontsize',80)

             elseif find(max(gis)==gis) ==4
            title(['start'],'fontsize',80)
                 elseif find(max(gis)==gis) ==5
           title(['finish'],'fontsize',80)
        else 
        end

raw_sig=zeros(50,12,1);
raw_sig_F=zeros(600,1);


k=k+1

end


drawnow

if k>50
    break
end
end









%close and clear
fclose(b);
clear('b'); 

clear;clc

e1=abs(fist_F-2.1);
e2=abs(sci_F-2.1);
e3=abs(stretch_F-2.1);
e4=mean(e1')
e5=mean(e2')
e6=mean(e3')
subplot(5,1,1)
plot(raw_fis_F_T)
subplot(5,1,2)
plot(raw_sci_F_T)
subplot(5,1,3)
plot(raw_pap_F_T)
subplot(5,1,4)
plot(raw_sta_F_T)
subplot(5,1,5)
plot(raw_fin_F_T)

figure(1)
title(['paper'],'fontsize',80)
