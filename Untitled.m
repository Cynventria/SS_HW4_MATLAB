clear all

%%% Load audio file 
filen = 'missingyou_crop.mp3';
audioinfo(filen)
[y,Fs] = audioread(filen);  % y has two channels, Fs is the sampling rate

N = size(y,1);              % Length of the audio signal 
t = [0:1/Fs:(N-1)/Fs];      % Time index 
f = ([0:1:N-1]/N-0.5)*Fs; % Frequency index (from -fs/2:1/(Nfs):(N-1)/(Nfs)-fs/2)
 
ys = y(:,1);  % we only process one of two channels between both are very similar. 


%audiowrite('compress_75_0710807.ogg', ys, Fs, 'Quality', 75);
%audiowrite('compress_50_0710807.ogg', ys, Fs, 'Quality', 50);
%audiowrite('compress_25_0710807.ogg', ys, Fs, 'Quality', 25);

lpf = fir1(64, 0.4);
Ays = conv(ys, lpf, 'same');



Ays = Ays(1:2:end);


audiowrite('DS_compress_5_0710807.ogg', Ays, Fs/2, 'Quality', 5);
audiowrite('compress_0710807.ogg', Ays, Fs/2, 'Quality', 0);

filen2 = 'DS_compress_5_0710807.ogg';
[y2, Fs2] = audioread(filen2);





audiowrite('compress_0710807_defaultQuality.ogg', y2, Fs2);