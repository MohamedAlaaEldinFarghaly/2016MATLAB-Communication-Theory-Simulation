function [ y ] = noisefreeISI( Bits,Ts,PAMlevel,EyeDuration,PulseShape)

%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


symbolrate=1;
A=1;
SPS=Ts;

[h,hnorm]=genPulse(Ts,PulseShape,symbolrate,PAMlevel);
y=PAM(Bits,PAMlevel,A,SPS,h);
figure,plot(y(1:50))
ys=y(SPS+1:end);
eyediagram(ys,EyeDuration*SPS)


end




