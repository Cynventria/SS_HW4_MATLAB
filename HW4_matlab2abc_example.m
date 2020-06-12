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
figure(1);

%%% Load audio file 
filen = 'missingyou_crop.mp3';
audioinfo(filen)

[y,Fs] = audioread(filen);  % y has two channels, Fs is the sampling rate

N = size(y,1);              % Length of the audio signal 
t = [0:1/Fs:(N-1)/Fs];      % Time index 
f = ([0:1:N-1]/N-0.5)*Fs;   % Frequency index (from -fs/2:1/(Nfs):(N-1)/(Nfs)-fs/2)
 
ys = y(:,1);  % we only process one of two channels between both are very similar. 




length(ys)
td = 0:1/48000:length(ys)/48000;
td(length(td)) = [];
subplot(3,1,1);plot(td,ys);title('original(time)');


fd = -pi: 2*pi/length( abs(fftshift(fft(ys)))) :pi;
fd(length(fd)) = [];
fd = fd.*24000/pi;
%fd = fd.^-1;
subplot(3,1,2);plot(fd, abs(fftshift(fft(ys)))); title('oririnal(freq)');
p3 = fft(ys);
for i = length(p3)/2:length(p3)
    p3(i) = 0;
end
subplot(3,1,3);semilogx(fd+24000,abs(p3)); title('original(freq in log(20~20k))');
xlim([20,20000]);






%%% Add noise (Gaussian white noise)
SNR = 30;
noise_var = 10^(-SNR/10);
ys_noise = ys + sqrt(noise_var)*randn(N,1);  % add noise 

%%% Add an inaudible signal with single frequency. 
fc = 19*10^3;   % The frequency of this cosine wave (you CAN change this value)
amp = 0.1;  % amplitude of the cosine wave (DON'T CHANGE this value for your hearing safty)

ys_inau = ys + amp*cos(2*pi*fc*[0:1:N-1]'/Fs); % Add this cosine signal to the orignal music. 

% Play the sound
%sound(ys,Fs)   
%sound(ys_noise, Fs)
sound(ys_inau, Fs)

%%% Export the prcoessed audio with .ogg format
filename = 'org_0710807.ogg'; 
audiowrite(filename,ys,Fs)
audiowrite('noise30dB_0710807.ogg', ys_noise, Fs);
audiowrite('inaudible_0710807.ogg', ys_inau, Fs);




figure(2);
title("noise");

length(ys_noise);
td = 0:1/48000:length(ys)/48000;
td(length(td)) = [];
subplot(3,1,1);plot(td,ys_noise); title('noies(time)');


fd = -pi: 2*pi/length( abs(fftshift(fft(ys_noise)))) :pi;
fd(length(fd)) = [];
fd = fd.*24000/pi;
%fd = fd.^-1;
subplot(3,1,2);plot(fd, abs(fftshift(fft(ys_noise)))); title('noise(freq)');
p3 = fft(ys_noise);
for i = length(p3)/2:length(p3)
    p3(i) = 0;
end
fd2 = fd+24000;
subplot(3,1,3);semilogx(fd2,abs(p3));title('noise(freq in log(20~20k))');
xlim([20,20000]);







figure(3);
title("inau");

length(ys_inau);
td = 0:1/48000:length(ys)/48000;
td(length(td)) = [];
subplot(3,1,1);plot(td,ys_inau); title('inau(time)');


fd = -pi: 2*pi/length( abs(fftshift(fft(ys_inau)))) :pi;
fd(length(fd)) = [];
fd = fd.*24000/pi;
%fd = fd.^-1;
subplot(3,1,2);plot(fd, abs(fftshift(fft(ys_inau)))); title('inau(freq)');
p3 = fft(ys_inau);
for i = length(p3)/2:length(p3)
    p3(i) = 0;
end
fd2 = fd+24000;
subplot(3,1,3);semilogx(fd2,abs(p3)); title('inau(freq in log(20~20k))');
xlim([20,20000]);



