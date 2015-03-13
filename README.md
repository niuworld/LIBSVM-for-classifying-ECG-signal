# LIBSVM-for-classifying-ECG-signal
using LIBSVM to classify various kinds of heart beats in ECG signals

 


I am doing a research to classify the heart beat using SVM. My database is from [MITBIH ARRYTHMIA](http://physionet.org/physiobank/database/mitdb/). 
  
The LIBSVM is from [Chih-Chung Chang and Chih-Jen Lin](http://www.csie.ntu.edu.tw/~cjlin/libsvm/). Great thanks to them!

fr.get.train.data.from.MIT.BIH.m is to get heart beats from MITBIH DATABSE. Its output includes the labels and features. 

fr.ecg.bandpass.filter.m is a function that helps filter the signal.

SVM_MIV is a SVM including a MIV idea to help better improve in choosing the features. This idea is from the internet but no idea who originally sorted it out.

SVM is to help to train the data and then test our data to see the accuracy. 

The work to be done:

1.	To add a new beat called unknown beat. As in the model i train now, no matter what kind of beat coming into the test, this beat will be classified into one beat among the five beats I set. I assume that the beat that is too far away from the five beats will be classified into the sixth beat.
2.	To include incremental learning in my work. I have take the model which I trained with the data from MITBIH to test the data from AHA. But the result is really bad, just 60%. The goal of my work is able to classifly the heart beat from various kind of people from all over the world. 