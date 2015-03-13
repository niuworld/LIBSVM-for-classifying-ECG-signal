clear
clc
close all
cd('E:\Documents\Matlab\MIT_DATA');
load('Data_combined');

[size_n,size_m]=size(Data_combined);
Train_Label=Data_combined(1:(size_n/2),1);
Test_Label=Data_combined(((size_n/2)+1):end,1);
Train_Feature=Data_combined(1:(size_n/2),2:end);
Test_Feature=Data_combined(((size_n/2)+1):end,2:end);
%% Scaling for the features
dataset=[Train_Feature;Test_Feature];
[dataset_scale,ps]=mapminmax(dataset',-1,1);% '-1,1' are the scaling threshold
dataset_scale=dataset_scale';

Train_Feature=dataset_scale(1:(size_n/2),2:end);
Test_Feature=dataset_scale(((size_n/2)+1):end,2:end);



model= svmtrain(Train_Label, Train_Feature, ' -c 2 -g 0.2 -t 2 ');% you can set '-c -g -t' as you like. but different value will lead to different result
[predict_label, accuracy,dec_values] = svmpredict(Test_Label, Test_Feature, model);