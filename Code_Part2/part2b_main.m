%Part 2-b

clear all;close all; clc;
Bits=randi([0 1],200,1);
Ts=16;
PAMlevel=2;
EyeDuration=1;
PulseShape='rcosine';
SNR=10;
m=10^(SNR/10);
N0=1/m;
Y=awgnoiseISI( Bits,Ts,PAMlevel,N0,EyeDuration,PulseShape);


