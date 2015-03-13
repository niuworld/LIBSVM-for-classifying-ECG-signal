# LIBSVM-for-classifying-ECG-signal
using LIBSVM to classify various kinds of heart beats in ECG signals

 


I am doing a research to classify the heart beat using SVM. My database is from [MITBIH ARRYTHMIA](http://physionet.org/physiobank/database/mitdb/). 
  
fr.get.train.data.from.MIT.BIH.m is to get heart beat from MITBIH DATABSE. It ouput include the label and feature.

fr.ecg.bandpass.filter.m is a function that help filter the signal.

SVM_MIV is a SVM including a MIV idea to help better improve in choosing the features. This idea is from the internet but no idea who original sort it out.

SVM is to help to train the data and then test our data to see the accuracy. 