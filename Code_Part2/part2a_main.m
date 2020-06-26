
clear all;close all; clc;
Bits=randi([0 1],200,1);
Ts=64;
PAMlevel=4;
EyeDuration=2;
PulseShape='Ideal Nyquist';

ys=noisefreeISI( Bits,Ts,PAMlevel,EyeDuration,PulseShape);

