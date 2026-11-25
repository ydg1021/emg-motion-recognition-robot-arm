%%make column mat
column_hello=zeros(160,30);
column_mannaseo=zeros(160,30);
column_bangap=zeros(160,30);
column_iam=zeros(160,30);
column_k=zeros(160,30);
column_I=zeros(160,30);
column_t=zeros(160,30);
column_student=zeros(160,30);
column_ipnida=zeros(160,30);
column_gyrohello=zeros(60,30);
column_gyrobangap=zeros(60,30);


%%input raw data
for j=1:30
for i=0:7

column_hello(20*i+1:20*i+20,j)=raw_hello(:,i+1,j);
column_mannaseo(20*i+1:20*i+20,j)=raw_mannaseo(:,i+1,j);
column_bangap(20*i+1:20*i+20,j)=raw_bangap(:,i+1,j);
column_iam(20*i+1:20*i+20,j)=raw_iam(:,i+1,j);
column_k(20*i+1:20*i+20,j)=raw_k(:,i+1,j);
column_I(20*i+1:20*i+20,j)=raw_I(:,i+1,j);
column_t(20*i+1:20*i+20,j)=raw_t(:,i+1,j);
column_student(20*i+1:20*i+20,j)=raw_student(:,i+1,j);
column_ipnida(20*i+1:20*i+20,j)=raw_ipnida(:,i+1,j);

end
end

%%input gyro raw data
for j=1:30
    for i=8:10
        
        column_gyrohello(20*(i-8)+1:20*(i-8)+20,j)=raw_hello(:,i+1,j);
        column_gyrobangap(20*(i-8)+1:20*(i-8)+20,j)=raw_bangap(:,i+1,j);
    end
end

%%gyrotranspose
column_gyrohello=column_gyrohello';
column_gyrobangap=column_gyrobangap';


%%Down Sampling

DS_hello=zeros(40,30);
for k=0:39;
   DS_hello(k+1,:)=mean(column_hello(4*k+1:4*k+4,:));
end;

DS_mannaseo=zeros(40,30);
for k=0:39;
   DS_mannaseo(k+1,:)=mean(column_mannaseo(4*k+1:4*k+4,:));
end;

DS_bangap=zeros(40,30);
for k=0:39;
   DS_bangap(k+1,:)=mean(column_bangap(4*k+1:4*k+4,:));
end;

DS_iam=zeros(40,30);
for k=0:39;
   DS_iam(k+1,:)=mean(column_iam(4*k+1:4*k+4,:));
end;
DS_k=zeros(40,30);
for k=0:39;
   DS_k(k+1,:)=mean(column_k(4*k+1:4*k+4,:));
end;

DS_I=zeros(40,30);
for k=0:39;
   DS_I(k+1,:)=mean(column_I(4*k+1:4*k+4,:));
end;

DS_t=zeros(40,30);
for k=0:39;
   DS_t(k+1,:)=mean(column_t(4*k+1:4*k+4,:));
end;

DS_student=zeros(40,30);
for k=0:39;
   DS_student(k+1,:)=mean(column_student(4*k+1:4*k+4,:));
end;

DS_ipnida=zeros(40,30);
for k=0:39;
   DS_ipnida(k+1,:)=mean(column_ipnida(4*k+1:4*k+4,:));
end;

DS_gyrohello=zeros(3,60);
for k=0:2;
    DS_gyrohello(k+1,:)=mean(column_gyrohello(10*k+1:10*k+10,:));
end;

DS_gyrobangap=zeros(3,60);
for k=0:2;
    DS_gyrobangap(k+1,:)=mean(column_gyrobangap(10*k+1:10*k+10,:));
end;