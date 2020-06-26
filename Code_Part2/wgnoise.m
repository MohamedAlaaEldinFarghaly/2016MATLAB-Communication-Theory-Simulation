function [ scaledwgn ] = wgnoise( No,Slength )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

newvar=No/2;

noise=randn(Slength,1);%wgn(Slength,1,0);    %white gaussian noise has 0dB
%var(noise)
%figure,stem(noise(1:50)),title('noise')
scaledwgn=sqrt(newvar)*noise;%wgn(Slength,1,No/2,'linear');%sqrt(newvar)*noise;  %scaled white gaussian noise to new varience 
%var(scaledwgn)
%figure,stem(scaledwgn(1:50)),title('snoise')
end

