%extract the data from MITBIH Arrythmia

clear
clc
close all

MIT_BIH_folder='E:\Documents\Matlab\MITBIH';
pwd_or=pwd;
cd(MIT_BIH_folder);
 file_used_to_extract_data=['118';'124';'212';'231';'232'];
 beat_num_in_each_file=[200;200;200;200;200];
 lable_need='R';%the label of the heart beat you wanna find
 mark_number=5;% mark_number

file_num=length(file_used_to_extract_data(:,1));

Y_X=[];%store the results
R_peak_remenber=[];
 ABS_t_signal=[];
for k=1:file_num
 
[tm,signal,Fs]=rdsamp(file_used_to_extract_data(k,:),1); % there are two MLII leads, and I set "1"(you can set "2" as well)
[ann,type]=rdann(file_used_to_extract_data(k,:),'atr');


 num_need=beat_num_in_each_file(k);%set the number of beats you wanna find in this dataset
 
 ecg_h= fr_ecg_bandpass_filter(signal,Fs,0);  % filter
    
    type_p=type;
type_p(1:5)='<';         % set the five beats in the front and the five beats in the last as '<'
type_p(end-4:end)='<';

t_f=find(type_p==lable_need);

t_ind=t_f(randperm(length(t_f)));% 

%-----deal with the data-----------------
before_r=100;
after_f=200;

  for  i=1:num_need
   
    t_R_point=ann(t_ind(i));
    t_signal=ecg_h(t_R_point-before_r:t_R_point+after_f);
    
    abs_t_signal(:,i)=abs(t_signal);
    
    R_peak_ap(i)=ecg_h(t_R_point);
    
    t_signal=t_signal';

   
   [C,L] = wavedec(t_signal, 4, 'db8');  %wavelet transform to get wavelet coefficiences at level 4

   cA4=C(1:L(1));
   cD4=C(1+L(1):L(1)+L(2));
   cD3=C(1+L(1)+L(2):L(1)+L(2)+L(3));
   cD2=C(1+L(1)+L(2)+L(3):L(1)+L(2)+L(3)+L(4));
   cD1=C(1+L(1)+L(2)+L(3)+L(4):L(1)+L(2)+L(3)+L(4)+L(5));
   
   wave_feature=[cA4,cD4,cD3];

previous_rr_interval=(ann(t_ind(i))-ann(t_ind(i)-1))*1/360;

post_rr_interval=(ann(t_ind(i)+1)-ann(t_ind(i)))*1/360;

 t1=t_ind(i)-5;
for j_r=1:10
   
    test_rr_local(j_r)=(ann(t1+j_r)-ann(t1+j_r-1))*1/360;
       
end
local_rr_interval=mean(test_rr_local);
   
 %-------store the features-------------------------
    
    y_x(i,1)=mark_number;
    y_x(i,2)=previous_rr_interval;
   y_x(i,3)=post_rr_interval; 
    y_x(i,4)=local_rr_interval;
    y_x(i,5:118)=wave_feature;

 end
    Y_X=[Y_X;y_x];
    y_x=[]; %empty the array
    R_peak_remenber=[ R_peak_remenber,R_peak_ap];
    ABS_t_signal=[ABS_t_signal,abs_t_signal];
end
 
cd(pwd_or);



