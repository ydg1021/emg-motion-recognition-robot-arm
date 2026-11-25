column_waveout=zeros(200,50);
column_wavein=zeros(200,50);
column_fist=zeros(200,50);

for j=1:50
for i=0:9

column_waveout(20*i+1:20*i+20,j)=raw_left_wave_out(:,i+1,j);
column_wavein(20*i+1:20*i+20,j)=raw_left_wave_in(:,i+1,j);
column_fist(20*i+1:20*i+20,j)=raw_left_fist(:,i+1,j);

end
end


DS_WAVEOUT=zeros(40,50);
for k=0:39
   DS_WAVEOUT(k+1,:)=mean(column_waveout(5*k+1:5*k+5,:));
end

DS_WAVEIN=zeros(40,50);
for k=0:39
   DS_WAVEIN(k+1,:)=mean(column_wavein(5*k+1:5*k+5,:));
end

DS_FIST=zeros(40,50);
for k=0:39
   DS_FIST(k+1,:)=mean(column_fist(5*k+1:5*k+5,:));
end


DS_ALL=zeros(40,150);
for l=1:50
DS_ALL(:,l)=DS_WAVEOUT(:,l);
end
for m=51:100
    DS_ALL(:,m)=DS_WAVEIN(:,m-50);
end
for n=101:150
    DS_ALL(:,n)=DS_FIST(:,n-100);
end


target = zeros(3,150);
target(1,1:50)=1;
target(2,51:100)=1;
target(3,101:150)=1;
