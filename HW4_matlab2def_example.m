%%%% Matlab assignment to understand how to process an audio signal (e.g.
%%%% music) using digital signal processing. 
%%%%  (a) Read the data (2-channel stereo music) using Matlab' audioread.
%%%%       Show the time waveform and its Frequency-domain representations
%%%%       using FFT. For simplicity, we will process one channel ONLY
%%%%       (i.e., mono tone).
%%%%  (b) Effects of noise on the music. Add a Guassian white noise to the
%%%%      original signal such that the signal-to-noise ratio is 30 dB. The maximum signal amplitude is assumed to be 1.
%%%%  (c) Test your hearing frequency band. Add a single tone (i.e., a
%%%%      single frequency, cosine signal) to the original data such that
%%%%      you CANNOT hear this single tone. That is, you hear the same as
%%%%      the original music. How to add this single tone?
%%%%  (d) Effects of filtering on the music. Apply the low-pass filter and
%%%%  high-pass filter to listen what is the differnece between them?
%%%%  (e) Downsampling the music. The orignal music has the sampling rate
%%%%  of 48kHz. What happens if you lower the sampling rate to 24kHz or
%%%%  even lower? 
%%%%  (f)  Compression of the music. Use the above filtering or
%%%%  downsampling or other skills you have to compress the music as much
%%%%  as possible without lossing the audio quality too much. 

%%%%  Signals and Systems, Spring 2020, Geng-Shi Jeng, NCTU, Taiwan.
 
clear all

%%% Load audio file 
filen = 'missingyou_crop.mp3';
audioinfo(filen)
[y,Fs] = audioread(filen);  % y has two channels, Fs is the sampling rate

N = size(y,1);              % Length of the audio signal 
t = [0:1/Fs:(N-1)/Fs];      % Time index 
f = ([0:1:N-1]/N-0.5)*Fs; % Frequency index (from -fs/2:1/(Nfs):(N-1)/(Nfs)-fs/2)
 
ys = y(:,1);  % we only process one of two channels between both are very similar. 

%%% Fourier transform of the waveform
ys_fft = fft(ys);

%%% Filter
b_lpf = fir1(64, 10*10^3/(Fs/2));  % LPF  (the cutoff freqency is at 10kHz in this case (i.e., -6dB reduction relative to the passband)
b_hpf = fir1(64, 0.5*10^3/(Fs/2),'high');  % HPF (the cutoff frequency is 1kHz (-6dB). 


%%% Plot the freqency response of two filters
figure(1)
freqz(b_lpf)
title('Low-pass filtering')
figure(2)
freqz(b_hpf)
title('High-pass filtering')


%%% Use convolution to do filtering
%LPF 
ys_lpf_fil = conv(ys,b_lpf,'same');  % use 'same' is to make sure the output data length is the same as the input.
%HPF
%%%%% Please write your code for HPF.

%%% Downsampling by ds
ds = 2;
ys_fil_ds = ys_lpf_fil(1:ds:end); % Use the LPF result before doing downsampling to avoid aliasing.



%%% Save data 
filename = 'processed_downsampling2.ogg'; 
audiowrite(filename,ys_fil_ds,Fs/ds)