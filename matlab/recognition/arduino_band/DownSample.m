%%make column mat
column_hello=zeros(240,30);
column_mannaseo=zeros(240,30);
column_bangap=zeros(240,30);
column_iam=zeros(240,30);
column_k=zeros(240,30);
column_i=zeros(240,30);
column_t=zeros(240,30);
column_student=zeros(240,30);
column_ipnida=zeros(240,30);



%%input raw data
for j=1:30
for i=0:11

column_hello(20*i+1:20*i+20,j)=raw_hello(:,i+1,j);
column_mannaseo(20*i+1:20*i+20,j)=raw_mannaseo(:,i+1,j);
column_bangap(20*i+1:20*i+20,j)=raw_bangap(:,i+1,j);
column_iam(20*i+1:20*i+20,j)=raw_iam(:,i+1,j);
column_k(20*i+1:20*i+20,j)=raw_k(:,i+1,j);
column_i(20*i+1:20*i+20,j)=raw_I(:,i+1,j);
column_t(20*i+1:20*i+20,j)=raw_t(:,i+1,j);
column_student(20*i+1:20*i+20,j)=raw_student(:,i+1,j);
column_ipnida(20*i+1:20*i+20,j)=raw_ipnida(:,i+1,j);

end
end

%%Down Sampling

DS_hello=zeros(40,30);
for k=0:39
   DS_hello(k+1,:)=mean(column_hello(6*k+1:6*k+6,:));
end

DS_mannaseo=zeros(40,30);
for k=0:39
   DS_mannaseo(k+1,:)=mean(column_mannaseo(6*k+1:6*k+6,:));
end

DS_bangap=zeros(40,30);
for k=0:39
   DS_bangap(k+1,:)=mean(column_bangap(6*k+1:6*k+6,:));
end

DS_iam=zeros(40,30);
for k=0:39
   DS_iam(k+1,:)=mean(column_iam(6*k+1:6*k+6,:));
end

DS_k=zeros(40,30);
for k=0:39
   DS_k(k+1,:)=mean(column_k(6*k+1:6*k+6,:));
end

DS_i=zeros(40,30);
for k=0:39
   DS_i(k+1,:)=mean(column_i(6*k+1:6*k+6,:));
end

DS_t=zeros(40,30);
for k=0:39
   DS_t(k+1,:)=mean(column_t(6*k+1:6*k+6,:));
end

DS_student=zeros(40,30);
for k=0:39
   DS_student(k+1,:)=mean(column_student(6*k+1:6*k+6,:));
end

DS_ipnida=zeros(40,30);
for k=0:39
   DS_ipnida(k+1,:)=mean(column_ipnida(6*k+1:6*k+6,:));
end

DS_ALL=zeros(40,270);
for m1=1:30
DS_ALL(:,m1)=DS_hello(:,m1);
end
for m2=31:60
    DS_ALL(:,m2)=DS_mannaseo(:,m2-30);
end
for m3=61:90
    DS_ALL(:,m3)=DS_bangap(:,m3-60);
end
for m4=91:120
    DS_ALL(:,m4)=DS_iam(:,m4-90);
end
for m5=121:150
    DS_ALL(:,m5)=DS_k(:,m5-120);
end
for m6=151:180
    DS_ALL(:,m6)=DS_i(:,m6-150);
end
for m7=181:210
    DS_ALL(:,m7)=DS_t(:,m7-180);
end
for m8=211:240
    DS_ALL(:,m8)=DS_student(:,m8-210);
end
for m9=241:270
    DS_ALL(:,m9)=DS_ipnida(:,m9-240);
end


%%target

target = zeros(9,270);
target(1,1:30)=1;
target(2,31:60)=1;
target(3,61:90)=1;
target(4,91:120)=1;
target(5,121:150)=1;
target(6,151:180)=1;
target(7,181:210)=1;
target(8,211:240)=1;
target(9,241:270)=1;