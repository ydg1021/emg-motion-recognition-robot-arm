column_waveout=zeros(120,50);
column_wavein=zeros(120,50);
column_fist=zeros(120,50);

for j=1:50
for i=0:5

column_waveout(20*i+1:20*i+20,j)=raw_left_wave_out3ch(:,i+1,j);
column_wavein(20*i+1:20*i+20,j)=raw_left_wave_in3ch(:,i+1,j);
column_fist(20*i+1:20*i+20,j)=raw_left_fist3ch(:,i+1,j);

end
end


DS_WAVEOUT3CH=zeros(40,50);
for k=0:39
   DS_WAVEOUT3CH(k+1,:)=mean(column_waveout(3*k+1:3*k+3,:));
end

DS_WAVEIN3CH=zeros(40,50);
for k=0:39
   DS_WAVEIN3CH(k+1,:)=mean(column_wavein(3*k+1:3*k+3,:));
end

DS_FIST3CH=zeros(40,50);
for k=0:39
   DS_FIST3CH(k+1,:)=mean(column_fist(3*k+1:3*k+3,:));
end


DS_ALL3CH=zeros(40,150);
for l=1:50
DS_ALL3CH(:,l)=DS_WAVEOUT3CH(:,l);
end
for m=51:100
    DS_ALL3CH(:,m)=DS_WAVEIN3CH(:,m-50);
end
for n=101:150
    DS_ALL3CH(:,n)=DS_FIST3CH(:,n-100);
end


target = zeros(3,150);
target(1,1:50)=1;
target(2,51:100)=1;
target(3,101:150)=1;
