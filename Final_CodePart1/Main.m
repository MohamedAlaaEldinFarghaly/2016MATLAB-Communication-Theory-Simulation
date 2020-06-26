clear;
clc;
close all;
%%% System Parameters
syms t;
syms fm;
xsig = input('enter the signal desired in terms of t and fm');
fm = double(input('enter the signal frequency desired'));
fs = input('enter the sampling frequency desired'); 
fs2=fs*30;  %% initial sampling of the signal
L = input ('enter the number of quantization levels');
mp = input ('enter the peak value of the quantizer');
Mu = input ('enter the value of Mu');
disp('1: unipolar NRZ');
disp('2: polar NRZ');
disp('3: Manchester');
Type = input('choose encoding signal type');
disp('0: uniform quantization');
disp('1: non-uniform quantization');
mode = input('choose quantization type type');
fc = fm+4;   %% Cutoff frequency of the reconstruction filter
t = 0:1/fs2:5*1/fm;
xsig = double(subs(xsig));
%%%%%%%%%% Start of the program %%%%%%%%%%

%%%% Sampling 
[ xsig_sampled] = sampler( xsig,fs,fs2 );
figure('Name','Input signal vs Sampled signal','NumberTitle','off'),
plot(t,xsig);
hold on
stem(t,xsig_sampled);
%%%% Quantization
[qindex,q_out,delta,sqnr,q_level] = quantizer(xsig_sampled,L,mode,mp,Mu);
figure('Name','Sampled signal vs Quantized','NumberTitle','off'),
stem(t,xsig_sampled);
hold on
stem(t,q_out);
if (mode==1)
   q_out=mp.*sign(q_out).*((((Mu+1).^abs(q_out/mp))-1)/Mu);
end
%%%% Encoding
[ES,Zx,Zy] = Encoder(qindex,Type);

%%%% Decoding
Q=Decoder(Zx,Zy,q_level,L,Type);

%%%% reconstruction
[s_rec,S_rec,faxis,lfft]=reconstruction(xsig,fs,fs2,fc);
figure('Name','Input signal vs reconstructed','NumberTitle','off'),
plot(t,s_rec);
hold on
plot(t,xsig);
%%%% Frequency domain analysis
Xsig=fftshift(fft(xsig,lfft));
Xsig_sampled=fftshift(fft(xsig_sampled,lfft));
figure('Name','Frequency domain representation','NumberTitle','off'),
subplot(3,1,1);
plot(faxis,abs(Xsig));
subplot(3,1,2);
plot(faxis,abs(S_rec));
subplot(3,1,3);
plot(faxis,abs(Xsig_sampled));

%%%%%%%%%%%%%%% END of the program %%%%%%%%%%%%%%%%