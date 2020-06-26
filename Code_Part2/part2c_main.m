%part 2-c

clear all;close all; clc;
Bits=randi([0 1],1000,1);
Ts=16;
PAMlevel=2;
EyeDuration=1;
PulseShape='rcosine';
SNR=[-2:7];
%A=1;Tb=1;

for i=1:length(SNR)
m=10^(SNR(i)/10);
N0(i)=1/m;

[Y(:,i),Ymatchedf(:,i)]=awgnoiseISI( Bits,Ts,PAMlevel,N0(i),EyeDuration,PulseShape);

[OutputAmp1,Outputbits1]=DecisionMaker( Y(:,i),Ts,PAMlevel ); %using sqrt rcosine Tx Rx filters


%figure,stem(Outputbits(1:50,i)),hold on, stem([0 0 Bits(1:48)']), title('binary input vs output')

%[OutputAmp,Outputbits]=DecisionMaker( Y(:,i),Ts,PAMlevel ); %using rcosine Tx filter only
output1(:,i)=Outputbits1; %
%output(:,i)=Outputbits(2:end);   %rcosine


end
original1=Bits;

figure,stem(output1(1:50,8)),hold on, stem(original1(1:50)','*'), title('binary input vs output')
%original=Bits(1:end);
%BER( original,output,PAMlevel,N0,Eb)

[ber,bert]=BER( original1,output1,PAMlevel,SNR,N0);
