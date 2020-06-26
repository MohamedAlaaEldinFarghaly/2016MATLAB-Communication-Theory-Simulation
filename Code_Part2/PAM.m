function [ y ] = PAM( bitinput, numlevels,A,SPS,pulseShape )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
switch numlevels
    case 2
        pamS=bitinput;
        pamS(pamS==0)=-A;
        pamS(pamS==1)=A;
        upsampled=upsample(pamS,SPS);
        y=filter(pulseShape,1,upsampled);
    case 4
        k=1;
        for i=1:2:length(bitinput)-1
            pamS(k)=2*bitinput(i)+bitinput(i+1);
            pamS(k)=(1+pamS(k))*2-5;
            pamS(k)=A*pamS(k);
            k=k+1;
        end
        upsampled=upsample(pamS',SPS);
        y=filter(pulseShape,1,upsampled);
end
%delay=zeros(2*SPS,1);
%figure,stem(y(1:100)),hold on,stem([delay' upsampled(1:100-2*SPS)]),stem(upsampled(1:100),'MarkerFaceColor','red','LineStyle','none')
figure,stem(pulseShape)
end

