%%%?Matlab assignment 1. To evaluate the effect of windowing effect. 
%%%  See Example 4.7 in Chapter 4 of Haykin's textbook. 

clear all

%%% Original signal
n = -150:1:150;    
x = cos(7*pi*n/16) + cos(9*pi*n/16);

%%% Windowing 
M = [8 20 100];

%%%.............(Specify the window "h" in this line) 

y = x.*h;

%%% Angular frequency in DTFT

%%%..............(Write the code to specify Omega (the variable W in the following) here. Note that you need to analyze three different window sizes) 

X = DTFT(x, n, W);
H = DTFT(h, n, W);
Y = DTFT(y, n, W);
 
figure
subplot(3,2,1); plot(n, x); title('x');
subplot(3,2,2); plot(W, abs(X)); title('DTFT{x}');
subplot(3,2,3); plot(n, h); title('w');
subplot(3,2,4); plot(W, abs(H)); title('DTFT{w}');
subplot(3,2,5); plot(n, y); title('y');
subplot(3,2,6); plot(W, abs(Y)); title('DTFT{y}');


%%%% This is an example to do DTFT 
function X = DTFT(x, n, W)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X = DTFT values computed at W  (1xNw)  
% x = Time sampled signal (1xNn)
% n = sample time vector  (1xNn) 
% W = frequency location vector  (1xNw)
% Nw: The length of W
% Nn: The length of n

X_tmp = exp(-1j*(W.' * n)) * x.';
X = X_tmp.';

end
