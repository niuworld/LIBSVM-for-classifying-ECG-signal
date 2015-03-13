function [ ecg_h ] = fr_ecg_bandpass_filter(ecg,fs,gr)
%UNTITLED3 Summary of this function goes here
%   对信号进行带通滤波

if nargin < 3
    gr = 1;   % on default the function always plots
end
ecg = ecg(:); % vectorize

if gr
    figure,plot(ecg);axis tight;title('Raw ECG Signal');
end

%% Noise cancelation(Filtering) % Filters (Filter in between 5-15 Hz)
if fs == 200
%% Low Pass Filter  H(z) = ((1 - z^(-6))^2)/(1 - z^(-1))^2
b = [1 0 0 0 0 0 -2 0 0 0 0 0 1];
a = [1 -2 1];
h_l = filter(b,a,[1 zeros(1,12)]); 
ecg_l = conv (ecg ,h_l);
ecg_l = ecg_l/ max( abs(ecg_l));
delay = 6; %based on the paper
if gr
ax(2)=subplot(322);plot(ecg_l);axis tight;title('Low pass filtered');
end
%% High Pass filter H(z) = (-1+32z^(-16)+z^(-32))/(1+z^(-1))
b = [-1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 32 -32 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];
a = [1 -1];
h_h = filter(b,a,[1 zeros(1,32)]); 
ecg_h = conv (ecg_l ,h_h);
ecg_h = ecg_h/ max( abs(ecg_h));
delay = delay + 16; % 16 samples for highpass filtering
if gr
ax(3)=subplot(323);plot(ecg_h);axis tight;title('High Pass Filtered');
end
else
%% bandpass filter for Noise cancelation of other sampling frequencies(Filtering)
f1=5; %cuttoff low frequency to get rid of baseline wander
f2=15; %cuttoff frequency to discard high frequency noise
Wn=[f1 f2]*2/fs; % cutt off based on fs
N = 3; % order of 3 less processing
[a,b] = butter(N,Wn); %bandpass filtering
ecg_h = filtfilt(a,b,ecg);
ecg_h = ecg_h/ max( abs(ecg_h));
if gr
figure;plot(ecg_h);axis tight;title('Band Pass Filtered');
end


end

