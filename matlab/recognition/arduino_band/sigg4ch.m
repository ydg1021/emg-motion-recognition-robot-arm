column_waveout=zeros(160,50);
column_wavein=zeros(160,50);
column_fist=zeros(160,50);

for j=1:50
for i=0:7

column_waveout(20*i+1:20*i+20,j)=raw_left_wave_out4ch(:,i+1,j);
column_wavein(20*i+1:20*i+20,j)=raw_left_wave_in4ch(:,i+1,j);
column_fist(20*i+1:20*i+20,j)=raw_left_fist4ch(:,i+1,j);

end
end


DS_WAVEOUT4CH=zeros(40,50);
for k=0:39
   DS_WAVEOUT4CH(k+1,:)=mean(column_waveout(4*k+1:4*k+4,:));
end

DS_WAVEIN4CH=zeros(40,50);
for k=0:39
   DS_WAVEIN4CH(k+1,:)=mean(column_wavein(4*k+1:4*k+4,:));
end

DS_FIST4CH=zeros(40,50);
for k=0:39
   DS_FIST4CH(k+1,:)=mean(column_fist(4*k+1:4*k+4,:));
end


DS_ALL4CH=zeros(40,150);
for l=1:50
DS_ALL4CH(:,l)=DS_WAVEOUT4CH(:,l);
end
for m=51:100
    DS_ALL4CH(:,m)=DS_WAVEIN4CH(:,m-50);
end
for n=101:150
    DS_ALL4CH(:,n)=DS_FIST4CH(:,n-100);
end


target = zeros(3,150);
target(1,1:50)=1;
target(2,51:100)=1;
target(3,101:150)=1;
