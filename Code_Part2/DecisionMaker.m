function [ outputAmp, outputbits ] = DecisionMaker( Signal,Ts,PAMlevel )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

Ssampled=Signal(Ts/2+1:Ts:end);
%figure,stem([0:49],Ssampled(1:50)),title('output')

%Descision maker
switch PAMlevel
    case 2
        lamda=0;   %randi function make equal probability for each symbol
        Ssampled(Ssampled<lamda)=-1;
        Ssampled(Ssampled>=lamda)=1;
        outputbits=Ssampled;
        outputbits(outputbits==-1)=0;
        
    case 4
        lamda1=2;lamda2=0;
        Ssampled(Ssampled<=(-lamda1))=-3;
        Ssampled(Ssampled>=lamda1)=3;
        Ssampled(Ssampled>(-lamda1) & Ssampled<=lamda2)= -1;
        Ssampled(Ssampled<(lamda1) & Ssampled>=lamda2)= 1;
        
        bits=0.5*(Ssampled+5);
        bits=dec2bin(bits)'
        [m,n]=size(bits);
        bits=reshape(bits,1,m*n);
        bits=str2num(bits');

        outputbits=bits;
end

outputAmp=Ssampled;
end

